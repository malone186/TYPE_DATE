import { create } from 'zustand';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { BlindDate, Choice, DateResult, Ending } from '../types';
import { allEpisodes, episode1 } from '../data';

// Flutter game_state.dart (Riverpod) → Zustand 이식.
// shared_preferences → AsyncStorage.

export type ThemeMode = 'light' | 'dark' | 'system';

const emptyAxis = (): Record<string, number> => ({
  E: 0, I: 0, N: 0, S: 0, T: 0, F: 0, J: 0, P: 0,
});

interface DateSession {
  date: BlindDate;
  currentTurnIndex: number; // 0-based
  likeScore: number;
  axisScore: Record<string, number>;
  choicePending: boolean; // 선택 결과(이펙트/반응) 처리 중인지
  lastChoice: Choice | null;
  history: Choice[]; // 완료된 턴들의 선택 — 누적 대화 로그 재구성용
}

interface AppState {
  // 테마 (Flutter themeModeProvider)
  themeMode: ThemeMode;
  cycleThemeMode: () => void;

  // 지금 플레이하려는 에피소드 (Flutter selectedEpisodeProvider)
  selectedEpisode: BlindDate;
  setSelectedEpisode: (d: BlindDate) => void;

  // 한 회차 진행 상태 (Flutter dateSessionProvider)
  session: DateSession;
  startSession: (date: BlindDate) => void;
  selectChoice: (choice: Choice) => void;
  advanceTurn: () => void;
  buildResult: () => DateResult;

  // 전체 진행 상황 (Flutter gameProgressProvider) — AsyncStorage 영속화
  results: Record<string, DateResult>;
  completedIds: Set<string>;
  totalCompleted: number;
  completeDate: (result: DateResult) => Promise<void>;
  isCompleted: (dateId: string) => boolean;

  // 사용자 이름 (Flutter userNameProvider) — AsyncStorage 영속화
  userName: string;
  setUserName: (name: string) => Promise<void>;

  // 앱 시작 시 영속 데이터 로드
  loadPersisted: () => Promise<void>;
}

const freshSession = (date: BlindDate): DateSession => ({
  date,
  currentTurnIndex: 0,
  likeScore: 0,
  axisScore: emptyAxis(),
  choicePending: false,
  lastChoice: null,
  history: [],
});

function currentTurn(s: DateSession) {
  return s.date.turns[s.currentTurnIndex];
}
function isLastTurn(s: DateSession) {
  return s.currentTurnIndex === s.date.turns.length - 1;
}

export const useStore = create<AppState>((set, get) => ({
  themeMode: 'light',
  cycleThemeMode: () =>
    set((st) => ({
      themeMode:
        st.themeMode === 'light'
          ? 'dark'
          : st.themeMode === 'dark'
            ? 'system'
            : 'light',
    })),

  selectedEpisode: episode1,
  setSelectedEpisode: (d) => set({ selectedEpisode: d }),

  session: freshSession(episode1),
  startSession: (date) => set({ session: freshSession(date) }),

  selectChoice: (choice) => {
    const s = get().session;
    if (s.choicePending) return;
    const newAxis = { ...s.axisScore };
    newAxis[choice.primaryAxis] = (newAxis[choice.primaryAxis] ?? 0) + 1;
    newAxis[choice.secondaryAxis] = (newAxis[choice.secondaryAxis] ?? 0) + 1;
    set({
      session: {
        ...s,
        likeScore: s.likeScore + choice.likeScore,
        axisScore: newAxis,
        choicePending: true,
        lastChoice: choice,
      },
    });
  },

  advanceTurn: () => {
    const s = get().session;
    if (isLastTurn(s)) return;
    const choice = s.lastChoice;
    set({
      session: {
        ...s,
        currentTurnIndex: s.currentTurnIndex + 1,
        choicePending: false,
        lastChoice: null,
        history: choice == null ? s.history : [...s.history, choice],
      },
    });
  },

  buildResult: () => {
    const s = get().session;
    const score = s.likeScore;
    const ending: Ending =
      score >= 5 ? 'success' : score <= -5 ? 'fail' : 'friend';
    const ei = (s.axisScore['E'] ?? 0) >= (s.axisScore['I'] ?? 0) ? 'E' : 'I';
    const tf = (s.axisScore['T'] ?? 0) >= (s.axisScore['F'] ?? 0) ? 'T' : 'F';
    const styleType = `${ei}${tf}`;
    return {
      dateId: s.date.id,
      likeScore: score,
      ending,
      axisScore: s.axisScore,
      styleType,
      completedAt: Date.now(),
    };
  },

  results: {},
  completedIds: new Set<string>(),
  totalCompleted: 0,

  completeDate: async (result) => {
    const st = get();
    const newResults = { ...st.results, [result.dateId]: result };
    const newCompleted = new Set(st.completedIds);
    newCompleted.add(result.dateId);
    set({
      results: newResults,
      completedIds: newCompleted,
      totalCompleted: newCompleted.size,
    });
    await AsyncStorage.setItem(`td_${result.dateId}_completed`, 'true');
  },

  isCompleted: (dateId) => get().completedIds.has(dateId),

  userName: '',
  setUserName: async (name) => {
    set({ userName: name });
    await AsyncStorage.setItem('td_user_name', name);
  },

  loadPersisted: async () => {
    const name = (await AsyncStorage.getItem('td_user_name')) ?? '';
    const completed = new Set<string>();
    for (const e of allEpisodes) {
      const v = await AsyncStorage.getItem(`td_${e.id}_completed`);
      if (v === 'true') completed.add(e.id);
    }
    set({
      userName: name,
      completedIds: completed,
      totalCompleted: completed.size,
    });
  },
}));

// 편의 셀렉터 (컴포넌트에서 파생값 계산에 사용)
export function sessionCurrentTurn(s: DateSession) {
  return currentTurn(s);
}
export function sessionIsLastTurn(s: DateSession) {
  return isLastTurn(s);
}
export function sessionProgress(s: DateSession) {
  return s.currentTurnIndex / s.date.turns.length;
}
export type { DateSession };
