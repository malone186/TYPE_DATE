import '../models/models.dart';
import 'episode13_script.dart';

export 'episode13_script.dart';

/// 13화 ISTJ 은서 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode13_script.dart 참고.

const eunseo = TDCharacter(
  id: 'date13_eunseo',
  name: '은서',
  age: 29,
  job: '회계사',
  location: '서울',
  mbti: 'ISTJ',
  intro: '화려한 말은 못 해요. 대신 한 말은 지켜요',
  tags: ['#회계사', '#손글씨가계부', '#야구직관', '#경주여행', '#만년필'],
  isUnlocked: true,
);

/// 13화(은서) 기준 유형별 보고서 텍스트
final Map<String, StyleInfo> eunseoStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌟',
    title: '소개팅계 공감왕',
    summary: '적극적이고 따뜻해요. 분위기를 살리는 타입.',
    goodPoint: '조용한 한정식집의 침묵을 부담스럽지 않게 채우고, 은서의 반전 매력을 신나게 반겨줬어요.',
    badPoint: '은서에게 높은 텐션과 서프라이즈는 당황 항목이에요. 예고된 다정함이 이 사람에게는 더 로맨틱해요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '온도는 따뜻한데 박자가 달라요. 은서의 페이스가 눌리면 마음의 장부를 닫아버릴 수 있는 조합.',
    endingMessages: {
      Ending.success: '은서가 "좋았던 날"이라고 말하게 만들었어요. 8년 단골집 역사상 처음 있는 일이래요 🌟',
      Ending.friend: '은서도 즐거웠지만 템포 차이가 남았어요. 대신 야구 직관 초대는 진심이에요. 응원가는 외워 가세요.',
      Ending.fail: '화려한 리액션이 은서에게는 검증 안 된 숫자처럼 들렸을 수 있어요. 다음엔 볼륨 대신 꾸준함을 보여주세요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '직진형 승부사',
    summary: '적극적이고 명확해요. 결론부터 말하는 타입.',
    goodPoint: '약속을 그 자리에서 확정 짓는 화법이 은서의 신뢰 기준을 정확히 통과했어요.',
    badPoint: '은서는 결론까지 검토 시간이 필요한 사람이에요. 밀어붙이기보다 기한을 주고 기다려주세요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '명확함은 통하는데 속도가 달라요. 은서의 검토 기간을 재촉하면 결재가 반려될 수 있는 조합.',
    endingMessages: {
      Ending.success: '치킨과 기록지의 분업 계약이 성사됐어요. 은서가 만년필로 적은 약속은 취소가 없대요 ⚡',
      Ending.friend: '대화의 잔액은 딱 맞았는데 설렘 항목이 비었어요. 은서와는 두 번째 만남부터가 진짜예요.',
      Ending.fail: '빠른 결론이 은서에게는 성급한 마감으로 보였을 수 있어요. 이 사람의 장부는 천천히 열려요.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌙',
    title: '조용한 감성러',
    summary: '말은 적지만 공감이 깊어요. 진지한 타입.',
    goodPoint: '"재미없다"는 말에 1년째 갇혀 있던 은서에게, 그 말이 틀렸다는 걸 처음으로 믿게 해줬어요.',
    badPoint: '은서는 확답을 좋아하는 사람이에요. 마음을 정했다면 날짜와 함께 분명하게 말해주세요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '조용한 깊이가 통하는 조합. 은서의 접힌 페이지를 알아보는 몇 안 되는 유형이에요.',
    endingMessages: {
      Ending.success: '은서의 가계부 비고란에 당신의 문장이 적혔어요. 지출 없이 얻은 것 중 제일 비싼 문장으로요 🌙',
      Ending.friend: '은서의 신뢰 목록에 올랐어요. 다음 단계로 가려면 마음에도 기한과 금액을 적어서 보여주세요.',
      Ending.fail: '둘 다 기다리다가 마감이 지나버렸을 수 있어요. 은서에게는 먼저 내미는 확답이 필요해요.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🔍',
    title: '조용한 전략가',
    summary: '신중하지만 논리는 명확해요. 핵심만 말하는 타입.',
    goodPoint: '실패 비용, 표본, 보상 체계 — 은서의 언어를 통역 없이 알아듣고 같은 언어로 답했어요.',
    badPoint: '둘 다 감정을 결산 후에만 공개하는 타입이에요. 가끔은 가결산 상태의 마음도 공유해보세요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '장부가 1원까지 맞아떨어지는 조합. 은서가 "잔액이 맞는 기분"이라고 말하게 되는 상대예요.',
    endingMessages: {
      Ending.success: '은서의 직관 승률 표본에 최고 기록으로 남았어요. 이 사람의 기록은 만년필이라 안 지워져요 🔍',
      Ending.friend: '신뢰 잔액은 최상급이에요. 여기서 감정 계정 하나만 추가하면 관계의 재무 상태가 바뀌어요.',
      Ending.fail: '논리는 통했는데 마음이 계상되지 않았어요. 은서에게는 정확한 말만큼 정확한 온기가 필요해요.',
    },
  ),
};

final episode13 = BlindDate(
  id: 'date13',
  character: eunseo,
  turns: eunseoTurns,
  openingScript: eunseoOpeningScript,
  closingScripts: eunseoClosingScripts,
  styleInfo: eunseoStyleInfoMap,
);
