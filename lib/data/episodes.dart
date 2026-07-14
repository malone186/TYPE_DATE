import '../models/models.dart';
import 'episode1_data.dart';
import 'episode2_data.dart';
import 'episode3_data.dart';
import 'episode4_data.dart';
import 'episode5_data.dart';
import 'episode6_data.dart';
import 'episode7_data.dart';
import 'episode8_data.dart';
import 'episode9_data.dart';
import 'episode10_data.dart';
import 'episode11_data.dart';
import 'episode12_data.dart';
import 'episode13_data.dart';
import 'episode14_data.dart';
import 'episode15_data.dart';
import 'episode16_data.dart';

export 'episode1_data.dart';
export 'episode2_data.dart';
export 'episode3_data.dart';
export 'episode4_data.dart';
export 'episode5_data.dart';
export 'episode6_data.dart';
export 'episode7_data.dart';
export 'episode8_data.dart';
export 'episode9_data.dart';
export 'episode10_data.dart';
export 'episode11_data.dart';
export 'episode12_data.dart';
export 'episode13_data.dart';
export 'episode14_data.dart';
export 'episode15_data.dart';
export 'episode16_data.dart';

/// 제작된 에피소드 목록 — 순서가 곧 화 번호(index + 1).
final List<BlindDate> allEpisodes = [
  episode1,
  episode2,
  episode3,
  episode4,
  episode5,
  episode6,
  episode7,
  episode8,
  episode9,
  episode10,
  episode11,
  episode12,
  episode13,
  episode14,
  episode15,
  episode16,
];

/// 에피소드별 에필로그(민준 카톡) 대사 — dateId 기준.
final Map<String, List<ChatLine>> epilogueLinesByDateId = {
  episode1.id: epilogueLines,
  episode2.id: epilogue2Lines,
  episode3.id: epilogue3Lines,
  episode4.id: epilogue4Lines,
  episode5.id: epilogue5Lines,
  episode6.id: epilogue6Lines,
  episode7.id: epilogue7Lines,
  episode8.id: epilogue8Lines,
  episode9.id: epilogue9Lines,
  episode10.id: epilogue10Lines,
  episode11.id: epilogue11Lines,
  episode12.id: epilogue12Lines,
  episode13.id: epilogue13Lines,
  episode14.id: epilogue14Lines,
  episode15.id: epilogue15Lines,
  episode16.id: epilogue16Lines,
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
