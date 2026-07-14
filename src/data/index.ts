import { BlindDate, ChatLine, TDCharacter } from '../types';
import { episode1, epilogue1Lines, prologueLines } from './episode1';
import { episode2, epilogue2Lines } from './episode2';
import { episode3, epilogue3Lines } from './episode3';
import { episode4, epilogue4Lines } from './episode4';
import { episode5, epilogue5Lines } from './episode5';
import { episode6, epilogue6Lines } from './episode6';
import { episode7, epilogue7Lines } from './episode7';
import { episode8, epilogue8Lines } from './episode8';
import { episode9, epilogue9Lines } from './episode9';
import { episode10, epilogue10Lines } from './episode10';
import { episode11, epilogue11Lines } from './episode11';
import { episode12, epilogue12Lines } from './episode12';
import { episode13, epilogue13Lines } from './episode13';
import { episode14, epilogue14Lines } from './episode14';
import { episode15, epilogue15Lines } from './episode15';
import { episode16, epilogue16Lines } from './episode16';

// Flutter data/episodes.dart 이식.

export { prologueLines };
export {
  episode1, episode2, episode3, episode4, episode5, episode6, episode7, episode8,
  episode9, episode10, episode11, episode12, episode13, episode14, episode15, episode16,
};

/// 제작된 에피소드 목록 — 순서가 곧 화 번호(index + 1).
export const allEpisodes: BlindDate[] = [
  episode1, episode2, episode3, episode4, episode5, episode6, episode7, episode8,
  episode9, episode10, episode11, episode12, episode13, episode14, episode15, episode16,
];

/// 에피소드별 에필로그(민준 카톡) 대사 — dateId 기준.
export const epilogueLinesByDateId: Record<string, ChatLine[]> = {
  [episode1.id]: epilogue1Lines,
  [episode2.id]: epilogue2Lines,
  [episode3.id]: epilogue3Lines,
  [episode4.id]: epilogue4Lines,
  [episode5.id]: epilogue5Lines,
  [episode6.id]: epilogue6Lines,
  [episode7.id]: epilogue7Lines,
  [episode8.id]: epilogue8Lines,
  [episode9.id]: epilogue9Lines,
  [episode10.id]: epilogue10Lines,
  [episode11.id]: epilogue11Lines,
  [episode12.id]: epilogue12Lines,
  [episode13.id]: epilogue13Lines,
  [episode14.id]: epilogue14Lines,
  [episode15.id]: epilogue15Lines,
  [episode16.id]: epilogue16Lines,
};

export function episodeById(dateId: string): BlindDate {
  return allEpisodes.find((e) => e.id === dateId) ?? episode1;
}

export function episodeForCharacter(character: TDCharacter): BlindDate | undefined {
  return allEpisodes.find((e) => e.character.id === character.id);
}

/// 16개 캐릭터 슬롯 — 제작된 에피소드 + 잠금 placeholder.
export const allCharacterSlots: TDCharacter[] = [
  ...allEpisodes.map((e) => e.character),
  ...Array.from({ length: Math.max(0, 16 - allEpisodes.length) }, (_, k) => {
    const i = allEpisodes.length + 1 + k;
    const slot: TDCharacter = {
      id: `date${i.toString().padStart(2, '0')}`,
      name: '???',
      age: 0,
      job: '',
      location: '',
      mbti: '????',
      intro: '',
      tags: [],
      isUnlocked: false,
    };
    return slot;
  }),
];
