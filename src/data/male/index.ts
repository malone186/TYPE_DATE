import { BlindDate, ChatLine, TDCharacter } from '../../types';
import { maleEpisodeEsfp, maleEpilogueEsfpLines } from './episodeEsfp';
import { maleEpisodeIntj, maleEpilogueIntjLines } from './episodeIntj';
import { maleEpisodeEnfp, maleEpilogueEnfpLines } from './episodeEnfp';
import { maleEpisodeIstp, maleEpilogueIstpLines } from './episodeIstp';
import { maleEpisodeEstj, maleEpilogueEstjLines } from './episodeEstj';
import { maleEpisodeInfp, maleEpilogueInfpLines } from './episodeInfp';
import { maleEpisodeEntp, maleEpilogueEntpLines } from './episodeEntp';
import { maleEpisodeIsfp, maleEpilogueIsfpLines } from './episodeIsfp';
import { maleEpisodeEntj, maleEpilogueEntjLines } from './episodeEntj';
import { maleEpisodeIsfj, maleEpilogueIsfjLines } from './episodeIsfj';
import { maleEpisodeIntp, maleEpilogueIntpLines } from './episodeIntp';
import { maleEpisodeEsfj, maleEpilogueEsfjLines } from './episodeEsfj';
import { maleEpisodeIstj, maleEpilogueIstjLines } from './episodeIstj';
import { maleEpisodeEnfj, maleEpilogueEnfjLines } from './episodeEnfj';
import { maleEpisodeEstp, maleEpilogueEstpLines } from './episodeEstp';
import { maleEpisodeInfj, maleEpilogueInfjLines } from './episodeInfj';
import { malePrologueLines } from './prologue';

// 남자 캐릭터 라인 (주인공 = 여성 27세). 여자 라인 data/index.ts와 동일 구조. 16화 전부 제작 완료.

export { maleEpisodeEsfp, malePrologueLines };

/// 제작된 남자 라인 에피소드 — 순서가 곧 화 번호(index + 1). 1화 = ESFP 고정.
export const allMaleEpisodes: BlindDate[] = [
  maleEpisodeEsfp,
  maleEpisodeIntj,
  maleEpisodeEnfp,
  maleEpisodeIstp,
  maleEpisodeEstj,
  maleEpisodeInfp,
  maleEpisodeEntp,
  maleEpisodeIsfp,
  maleEpisodeEntj,
  maleEpisodeIsfj,
  maleEpisodeIntp,
  maleEpisodeEsfj,
  maleEpisodeIstj,
  maleEpisodeEnfj,
  maleEpisodeEstp,
  maleEpisodeInfj,
];

/// 에피소드별 에필로그(예린 카톡) 대사 — dateId 기준.
export const maleEpilogueLinesByDateId: Record<string, ChatLine[]> = {
  [maleEpisodeEsfp.id]: maleEpilogueEsfpLines,
  [maleEpisodeIntj.id]: maleEpilogueIntjLines,
  [maleEpisodeEnfp.id]: maleEpilogueEnfpLines,
  [maleEpisodeIstp.id]: maleEpilogueIstpLines,
  [maleEpisodeEstj.id]: maleEpilogueEstjLines,
  [maleEpisodeInfp.id]: maleEpilogueInfpLines,
  [maleEpisodeEntp.id]: maleEpilogueEntpLines,
  [maleEpisodeIsfp.id]: maleEpilogueIsfpLines,
  [maleEpisodeEntj.id]: maleEpilogueEntjLines,
  [maleEpisodeIsfj.id]: maleEpilogueIsfjLines,
  [maleEpisodeIntp.id]: maleEpilogueIntpLines,
  [maleEpisodeEsfj.id]: maleEpilogueEsfjLines,
  [maleEpisodeIstj.id]: maleEpilogueIstjLines,
  [maleEpisodeEnfj.id]: maleEpilogueEnfjLines,
  [maleEpisodeEstp.id]: maleEpilogueEstpLines,
  [maleEpisodeInfj.id]: maleEpilogueInfjLines,
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
