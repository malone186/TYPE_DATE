import '../models/models.dart';
import 'episode3_script.dart';

export 'episode3_script.dart';

/// 3화 ISFP 하린 — 캐릭터 정의와 유형별 보고서.
/// 대사·연출 대본은 episode3_script.dart 참고.

const harin = TDCharacter(
  id: 'date03_harin',
  name: '하린',
  age: 25,
  job: '일러스트레이터',
  location: '서울',
  mbti: 'ISFP',
  intro: '말수는 적은데요, 좋아하는 건 진짜 많아요',
  tags: ['#드로잉', '#플레이리스트', '#동네산책', '#빈티지샵', '#고양이집사'],
  isUnlocked: true,
  imagePath: 'assets/images/harin.png',
  facePath: 'assets/images/harin_face.png',
);

/// 유형별 보고서 텍스트 — 하린(ISFP) 기준
final Map<String, StyleInfo> harinStyleInfoMap = {
  'EF': const StyleInfo(
    code: 'EF',
    emoji: '🌞',
    title: '다정한 분위기 메이커',
    summary: '적극적이고 따뜻해요. 먼저 다가가는 타입.',
    goodPoint: '수줍은 하린이 입을 열 때까지 재촉하지 않고 따뜻하게 먼저 물어봐줬어요.',
    badPoint: '텐션이 너무 높아지면 하린처럼 조용한 사람은 반 발짝 물러날 수 있어요.',
    compatibilityStars: '★★★★☆',
    compatibilityComment: '하린의 속도만 존중해주면 정말 잘 맞는 조합이에요.',
    endingMessages: {
      Ending.success: '먼저 다가가되 재촉하지 않는 태도가 하린의 마음을 열었어요. 보리 사진이 곧 도착할 예정 🐱',
      Ending.friend: '하린이 편안해하긴 했지만, 아직 자기 세계까지 보여주진 않았어요. 천천히 가면 돼요.',
      Ending.fail: '그 에너지가 하린에게는 조금 벅찼을 수 있어요. 조용한 사람에겐 침묵도 대화라는 걸 기억해요.',
    },
  ),
  'ET': const StyleInfo(
    code: 'ET',
    emoji: '⚡',
    title: '시원시원한 해결사',
    summary: '활발하고 논리적이에요. 답을 찾아주는 타입.',
    goodPoint: '대화를 시원하게 이끌면서 하린의 고민에 명쾌한 방향을 제시했어요.',
    badPoint: '하린은 답보다 마음을 먼저 알아주는 사람에게 마음을 열어요.',
    compatibilityStars: '★★☆☆☆',
    compatibilityComment: '속도도 온도도 달라요. 서로에게 낯선 세계인 만큼 배울 건 많아요.',
    endingMessages: {
      Ending.success: '의외의 전개! 확신 있는 리드가 수줍은 하린에게는 오히려 든든하게 느껴졌나 봐요.',
      Ending.friend: '하린이 대화가 편하지만은 않았지만, 미워할 수 없는 사람으로 기억했어요.',
      Ending.fail: '조언이 앞서면 하린은 조용히 문을 닫아요. 다음엔 공감 먼저, 해결은 나중에.',
    },
  ),
  'IF': const StyleInfo(
    code: 'IF',
    emoji: '🌿',
    title: '고요한 감성 단짝',
    summary: '말수는 적지만 마음이 깊어요. 결이 닮은 타입.',
    goodPoint: '하린의 속도를 재촉하지 않고, 사소한 감정까지 조용히 알아봐줬어요.',
    badPoint: '둘 다 기다리기만 하면 다음 약속이 흐지부지될 수 있어요. 가끔은 먼저 손 내밀어봐요.',
    compatibilityStars: '★★★★★',
    compatibilityComment: '말 없이 앉아 있어도 편한 사이. 하린이 바라던 온도예요.',
    endingMessages: {
      Ending.success: '결이 닮은 두 사람. 하린이 아무한테도 안 보여준 스케치북을 보여줄 날이 머지않았어요 🌿',
      Ending.friend: '편안했지만 설렘의 불씨가 한 끗 모자랐어요. 이 관계는 천천히 익어가는 쪽에 가까워요.',
      Ending.fail: '둘 다 조심스러워서 서로에게 닿기 전에 시간이 끝나버렸어요. 다음엔 반 발짝만 먼저.',
    },
  ),
  'IT': const StyleInfo(
    code: 'IT',
    emoji: '🧭',
    title: '신중한 관찰자',
    summary: '조용하고 이성적이에요. 차분히 파악하는 타입.',
    goodPoint: '하린을 몰아붙이지 않는 차분한 페이스로 대화를 안정감 있게 이어갔어요.',
    badPoint: '하린의 감정 얘기에 분석으로 답하면 온도 차이가 생겨요.',
    compatibilityStars: '★★★☆☆',
    compatibilityComment: '조용한 리듬은 잘 맞지만 감성 코드에서 반 박자 어긋나요.',
    endingMessages: {
      Ending.success: '차분함 속에서 하린이 안정감을 느꼈어요. 조용한 두 사람의 담백한 시작이네요.',
      Ending.friend: '리듬은 잘 맞았지만 하린의 마음이 크게 움직일 만한 순간은 부족했어요.',
      Ending.fail: '하린의 "요즘 이래요"는 해결해달라는 말이 아니었을 거예요. 다음엔 마음부터 읽어봐요.',
    },
  ),
};

final episode3 = BlindDate(
  id: 'date03',
  character: harin,
  turns: harinTurns,
  openingScript: harinOpeningScript,
  closingScripts: harinClosingScripts,
  styleInfo: harinStyleInfoMap,
);
