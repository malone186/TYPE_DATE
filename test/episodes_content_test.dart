import 'package:flutter_test/flutter_test.dart';
import 'package:type_date/data/episodes.dart';
import 'package:type_date/models/models.dart';

void main() {
  test('에피소드 데이터 무결성 — 턴 수, 선택지, 호감도 배분, 클로징, 보고서', () {
    expect(allEpisodes.length, 4);

    for (final episode in allEpisodes) {
      // 10턴, 턴 번호 1~10
      expect(episode.turns.length, 10, reason: '${episode.id} 턴 수');
      for (var i = 0; i < episode.turns.length; i++) {
        final turn = episode.turns[i];
        expect(turn.turnNumber, i + 1, reason: '${episode.id} 턴 번호');

        // 선택지 A~D, 호감도 +1 두 개 / -1 두 개
        expect(turn.choices.length, 4, reason: '${episode.id} 턴 ${i + 1} 선택지 수');
        expect(turn.choices.map((c) => c.label).toList(), ['A', 'B', 'C', 'D']);
        final likes = turn.choices.where((c) => c.likeScore == 1).length;
        final dislikes = turn.choices.where((c) => c.likeScore == -1).length;
        expect(likes, 2, reason: '${episode.id} 턴 ${i + 1} +1 개수');
        expect(dislikes, 2, reason: '${episode.id} 턴 ${i + 1} -1 개수');

        // 축 값 유효성
        for (final choice in turn.choices) {
          expect('EINSTFJP'.contains(choice.primaryAxis), true,
              reason: '${episode.id} 턴 ${i + 1} ${choice.label} primaryAxis');
          expect('EINSTFJP'.contains(choice.secondaryAxis), true,
              reason: '${episode.id} 턴 ${i + 1} ${choice.label} secondaryAxis');
        }
      }

      // 도입부·클로징·보고서
      expect(episode.openingScript.isNotEmpty, true, reason: '${episode.id} 도입부');
      for (final ending in Ending.values) {
        expect(episode.closingScripts[ending]?.isNotEmpty, true,
            reason: '${episode.id} ${ending.name} 클로징');
      }
      for (final code in ['EF', 'ET', 'IF', 'IT']) {
        final info = episode.styleInfo[code];
        expect(info, isNotNull, reason: '${episode.id} styleInfo[$code]');
        for (final ending in Ending.values) {
          expect(info!.endingMessages[ending]?.isNotEmpty, true,
              reason: '${episode.id} $code ${ending.name} 메시지');
        }
      }

      // 캐릭터 기본 정보
      expect(episode.character.mbti.length, 4, reason: '${episode.id} mbti');
      expect(episode.character.name.isNotEmpty, true);
    }

    // 캐릭터 슬롯 — 16개, 제작된 에피소드 수만큼 실제 캐릭터
    expect(allCharacterSlots.length, 16);
    for (var i = 0; i < allEpisodes.length; i++) {
      expect(allCharacterSlots[i].id, allEpisodes[i].character.id);
    }
  });
}
