import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/episodes.dart';
import '../models/models.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

/// 지금 플레이하려는(또는 플레이 중인) 에피소드 — 프로필 화면에서 설정
final selectedEpisodeProvider = StateProvider<BlindDate>((ref) => episode1);

/// 13턴 동안 쌓이는 한 회차의 진행 상태
class DateSessionState {
  final BlindDate date;
  final int currentTurnIndex; // 0-based
  final int likeScore;
  final Map<String, int> axisScore;
  final bool choicePending; // 선택 결과(이펙트/반응) 처리 중인지
  final Choice? lastChoice;
  final List<Choice> history; // 완료된 턴들의 선택 — 누적 대화 로그 재구성용

  const DateSessionState({
    required this.date,
    this.currentTurnIndex = 0,
    this.likeScore = 0,
    this.axisScore = const {
      'E': 0, 'I': 0, 'N': 0, 'S': 0, 'T': 0, 'F': 0, 'J': 0, 'P': 0,
    },
    this.choicePending = false,
    this.lastChoice,
    this.history = const [],
  });

  Turn get currentTurn => date.turns[currentTurnIndex];
  bool get isLastTurn => currentTurnIndex == date.turns.length - 1;
  double get progress => (currentTurnIndex) / date.turns.length;

  DateSessionState copyWith({
    int? currentTurnIndex,
    int? likeScore,
    Map<String, int>? axisScore,
    bool? choicePending,
    Choice? lastChoice,
    List<Choice>? history,
  }) {
    return DateSessionState(
      date: date,
      currentTurnIndex: currentTurnIndex ?? this.currentTurnIndex,
      likeScore: likeScore ?? this.likeScore,
      axisScore: axisScore ?? this.axisScore,
      choicePending: choicePending ?? this.choicePending,
      lastChoice: lastChoice,
      history: history ?? this.history,
    );
  }
}

class DateSessionNotifier extends Notifier<DateSessionState> {
  @override
  DateSessionState build() => DateSessionState(date: ref.watch(selectedEpisodeProvider));

  void selectChoice(Choice choice) {
    if (state.choicePending) return;
    final newAxis = Map<String, int>.from(state.axisScore);
    newAxis[choice.primaryAxis] = (newAxis[choice.primaryAxis] ?? 0) + 1;
    newAxis[choice.secondaryAxis] = (newAxis[choice.secondaryAxis] ?? 0) + 1;
    state = state.copyWith(
      likeScore: state.likeScore + choice.likeScore,
      axisScore: newAxis,
      choicePending: true,
      lastChoice: choice,
    );
  }

  void advanceTurn() {
    if (state.isLastTurn) return;
    final choice = state.lastChoice;
    state = state.copyWith(
      currentTurnIndex: state.currentTurnIndex + 1,
      choicePending: false,
      lastChoice: null,
      history: choice == null ? state.history : [...state.history, choice],
    );
  }

  DateResult buildResult() {
    final score = state.likeScore;
    final ending = score >= 5
        ? Ending.success
        : (score <= -5 ? Ending.fail : Ending.friend);
    final ei = (state.axisScore['E'] ?? 0) >= (state.axisScore['I'] ?? 0) ? 'E' : 'I';
    final tf = (state.axisScore['T'] ?? 0) >= (state.axisScore['F'] ?? 0) ? 'T' : 'F';
    final styleType = '$ei$tf';
    return DateResult(
      dateId: state.date.id,
      likeScore: score,
      ending: ending,
      axisScore: state.axisScore,
      styleType: styleType,
      completedAt: DateTime.now(),
    );
  }
}

final dateSessionProvider =
    NotifierProvider.autoDispose<DateSessionNotifier, DateSessionState>(
  DateSessionNotifier.new,
);

/// 전체 진행 상황(완료한 화 결과 등) — SharedPreferences 로 영속화
class GameProgressNotifier extends Notifier<GameProgress> {
  @override
  GameProgress build() {
    _load();
    return const GameProgress();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = <String>{
      for (final e in allEpisodes)
        if (prefs.getBool('td_${e.id}_completed') ?? false) e.id,
    };
    if (completed.isNotEmpty) {
      state = state.copyWith(
        completedIds: completed,
        totalCompleted: completed.length,
      );
    }
  }

  Future<void> completeDate(DateResult result) async {
    final newResults = Map<String, DateResult>.from(state.results);
    newResults[result.dateId] = result;
    final newCompleted = {...state.completedIds, result.dateId};
    state = state.copyWith(
      results: newResults,
      completedIds: newCompleted,
      totalCompleted: newCompleted.length,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('td_${result.dateId}_completed', true);
  }

  bool isCompleted(String dateId) => state.isCompleted(dateId);
}

final gameProgressProvider = NotifierProvider<GameProgressNotifier, GameProgress>(
  GameProgressNotifier.new,
);

/// 사용자가 입력한 이름 — SharedPreferences 로 영속화, 대사에서 "{name}씨" 치환에 사용
class UserNameNotifier extends Notifier<String> {
  @override
  String build() {
    _load();
    return '';
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('td_user_name') ?? '';
  }

  Future<void> setName(String name) async {
    state = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('td_user_name', name);
  }
}

final userNameProvider = NotifierProvider<UserNameNotifier, String>(UserNameNotifier.new);
