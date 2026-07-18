import { BlindDate, ChatLine, DateResult } from '../types';

// 16화 완주 후 최종 에필로그 — 가장 잘 맞았던 상대와 연애를 시작하는 마무리 스토리.
// 남/여 라인 공용: 상대 이름만 캐릭터에서 가져오고, 톤은 본편과 같게 담백하게 유지한다.

export interface FinalMatch {
  episode: BlindDate;
  result: DateResult;
}

const ENDING_RANK: Record<string, number> = { success: 2, friend: 1, fail: 0 };

/// 완료된 결과 중 최고 매칭 상대 선정 — 엔딩 등급(success > friend > fail) 우선,
/// 동률이면 호감도 높은 쪽, 그래도 같으면 먼저 만난 사람.
export function pickBestMatch(
  episodes: BlindDate[],
  results: Record<string, DateResult>,
): FinalMatch | null {
  let best: FinalMatch | null = null;
  let bestIndex = -1;
  episodes.forEach((episode, i) => {
    const result = results[episode.id];
    if (result == null) return;
    if (best == null) {
      best = { episode, result };
      bestIndex = i;
      return;
    }
    const a = ENDING_RANK[result.ending] ?? 0;
    const b = ENDING_RANK[best.result.ending] ?? 0;
    const better =
      a > b ||
      (a === b &&
        (result.likeScore > best.result.likeScore ||
          (result.likeScore === best.result.likeScore && i < bestIndex)));
    if (better) {
      best = { episode, result };
      bestIndex = i;
    }
  });
  return best;
}

/// 최종 에필로그 카톡 대본 — 상대가 먼저 연락해 소개팅이 아닌 진짜 만남을 제안한다.
export function buildFinalEpilogueLines(match: FinalMatch, userName: string): ChatLine[] {
  const partner = match.episode.character;
  const trimmed = userName.trim();
  const callName = trimmed.length === 0 ? '그쪽' : `${trimmed}씨`;
  return [
    {
      sender: 'system',
      text: '열여섯 번째 소개팅까지 전부 끝난 밤. 침대에 누워 천장을 보는데, 휴대폰이 울린다',
      isSystemNote: true,
    },
    { sender: 'system', text: `카카오톡 채팅방 — ${partner.name}`, isSystemNote: true },
    { sender: partner.name, text: '자요?' },
    { sender: 'me', text: '아직요' },
    { sender: partner.name, text: '다행이다. 이 시간에 보내도 되나 한참 고민했어요' },
    {
      sender: partner.name,
      text: '열여섯 명 다 만났다면서요. 결과가 어떻게 나왔는지는 안 물어볼게요',
    },
    { sender: 'me', text: '안 물어봐도 돼요?' },
    { sender: partner.name, text: '네. 저는 그 결과랑 상관없이 할 말이 있어서요' },
    {
      sender: partner.name,
      text: `저 그날 이후로 계속 생각났어요. ${callName}가 다른 사람들 만나고 있다는 거 알면서도요`,
    },
    { sender: 'me', text: '심장이 한 박자 빨리 뛰기 시작했다.', isMonologue: true },
    {
      sender: partner.name,
      text: `그래서 말인데요. 우리 이제 소개팅 말고, 그냥 만나요. ${callName}만 괜찮다면요`,
    },
    {
      sender: 'me',
      text: '...사실 저도요. 열여섯 명 중에 제일 오래 남은 사람이 누구냐고 물으면, 답은 진작 정해져 있었어요',
    },
    { sender: 'me', text: '좋아요. 대신 이번엔 앱 없이요' },
    { sender: partner.name, text: '콜. 내일 봐요. 장소는 지난번 거기서' },
    {
      sender: 'system',
      text: '— 열일곱 번째 만남부터는, 더 이상 소개팅이 아니었다 —',
      isSystemNote: true,
    },
  ];
}
