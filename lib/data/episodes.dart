import '../models/models.dart';
import 'episode1_data.dart';
import 'episode2_data.dart';
import 'episode3_data.dart';
import 'episode4_data.dart';

export 'episode1_data.dart';
export 'episode2_data.dart';
export 'episode3_data.dart';
export 'episode4_data.dart';

/// 제작된 에피소드 목록 — 순서가 곧 화 번호(index + 1).
final List<BlindDate> allEpisodes = [episode1, episode2, episode3, episode4];

/// 에피소드별 에필로그(민준 카톡) 대사 — dateId 기준.
final Map<String, List<ChatLine>> epilogueLinesByDateId = {
  episode1.id: epilogueLines,
  episode2.id: epilogue2Lines,
  episode3.id: epilogue3Lines,
  episode4.id: epilogue4Lines,
};

BlindDate episodeById(String dateId) =>
    allEpisodes.firstWhere((e) => e.id == dateId, orElse: () => episode1);

BlindDate? episodeForCharacter(TDCharacter character) {
  for (final e in allEpisodes) {
    if (e.character.id == character.id) return e;
  }
  return null;
}

/// 16개 캐릭터 슬롯 — 제작된 에피소드 + 잠금 placeholder.
final List<TDCharacter> allCharacterSlots = [
  for (final e in allEpisodes) e.character,
  for (int i = allEpisodes.length + 1; i <= 16; i++)
    TDCharacter(
      id: 'date${i.toString().padLeft(2, '0')}',
      name: '???',
      age: 0,
      job: '',
      location: '',
      mbti: '????',
      intro: '',
      tags: const [],
      isUnlocked: false,
    ),
];
