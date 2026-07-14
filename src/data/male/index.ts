import { BlindDate, ChatLine, TDCharacter } from '../../types';
import { maleEpisodeEsfp, maleEpilogueEsfpLines } from './episodeEsfp';
import { malePrologueLines } from './prologue';

// 남자 캐릭터 라인 (주인공 = 여성 27세). 여자 라인 data/index.ts와 동일 구조.
// 일단 1화(ESFP)만 제작 — 나머지 15명은 잠금 placeholder.

export { maleEpisodeEsfp, malePrologueLines };

/// 제작된 남자 라인 에피소드 — 순서가 곧 화 번호(index + 1). 1화 = ESFP 고정.
export const allMaleEpisodes: BlindDate[] = [maleEpisodeEsfp];

/// 에피소드별 에필로그(예린 카톡) 대사 — dateId 기준.
export const maleEpilogueLinesByDateId: Record<string, ChatLine[]> = {
  [maleEpisodeEsfp.id]: maleEpilogueEsfpLines,
};

export function maleEpisodeById(dateId: string): BlindDate {
  return allMaleEpisodes.find((e) => e.id === dateId) ?? maleEpisodeEsfp;
}

export function maleEpisodeForCharacter(character: TDCharacter): BlindDate | undefined {
  return allMaleEpisodes.find((e) => e.character.id === character.id);
}

/// 16개 캐릭터 슬롯 — 제작된 에피소드 + 잠금 placeholder.
export const allMaleCharacterSlots: TDCharacter[] = [
  ...allMaleEpisodes.map((e) => e.character),
  ...Array.from({ length: Math.max(0, 16 - allMaleEpisodes.length) }, (_, k) => {
    const i = allMaleEpisodes.length + 1 + k;
    const slot: TDCharacter = {
      id: `dateM${i.toString().padStart(2, '0')}`,
      name: '???',
      age: 0,
      job: '',
      location: '',
      mbti: '????',
      tags: [],
      intro: '',
      isUnlocked: false,
    };
    return slot;
  }),
];
