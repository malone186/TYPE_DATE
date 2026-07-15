import { ChatLine } from '../../types';

// 남자 라인 프롤로그 — 주인공(여성 27)이 친구 예린의 결혼식 당일, 홧김에 직접 TYPE DATE를 결제하는 흐름.
// 여자 라인 prologueLines(민준 카톡)와 동일하게 KakaoChatView로 재생. 속마음은 system note(내레이션)와 'me' 혼잣말로 표현.
export const malePrologueLines: ChatLine[] = [
  { sender: 'system', text: '예린의 결혼식 당일. 예식 30분 전, 신부대기실 앞 복도', isSystemNote: true },
  { sender: 'system', text: '카카오톡 채팅방 — 예린 💍', isSystemNote: true },
  { sender: '예린', text: '야 왔어?' },
  { sender: '예린', text: '나 지금 심장 너무 뛰어서 손이 다 떨려' },
  { sender: 'me', text: '방금 도착. 대기실 문 앞이야' },
  { sender: 'me', text: '너 드레스 입은 거 봤어. 진짜 예쁘다' },
  { sender: '예린', text: '고마워. 근데 울지 마, 나 화장 지워져' },
  { sender: '예린', text: '맨 앞자리 맡아놨어. 꼭 거기 앉아' },
  { sender: 'me', text: '응, 얼른 들어가서 앉을게' },
  { sender: 'system', text: '잠시 후, 예식이 시작된다. 주인공은 맨 앞자리에서 친구의 입장을 지켜본다', isSystemNote: true },
  { sender: 'system', text: '스물일곱. 올해만 벌써 세 번째 청첩장이었다', isSystemNote: true },
  { sender: 'system', text: '예린이 아버지 손을 잡고 천천히 걸어 들어온다. 여기저기서 훌쩍이는 소리', isSystemNote: true },
  { sender: 'system', text: '축하하는 마음이 100인데, 그 아래 이상한 게 1 깔린다. 부러움. 아니, 조바심에 더 가깝다', isSystemNote: true },
  { sender: 'me', text: '...나 마지막으로 설렜던 게 언제였지' },
  { sender: 'system', text: '예식이 끝나고, 하객들이 빠져나간 텅 빈 홀. 주인공은 자리에 남아 멍하니 폰을 만진다', isSystemNote: true },
  { sender: 'system', text: "SNS 광고 하나가 뜬다 — 'TYPE DATE : 16번의 소개팅 끝에, 당신의 진짜 인연 유형을 찾아드립니다'", isSystemNote: true },
  { sender: 'system', text: '평소 같으면 그냥 넘겼을 광고였다', isSystemNote: true },
  { sender: 'system', text: '그런데 오늘은, 손가락이 먼저 움직였다', isSystemNote: true },
  { sender: 'system', text: '결제 완료. 9만 8천 원', isSystemNote: true },
  { sender: 'me', text: '...내가 방금 뭘 한 거지' },
  { sender: 'me', text: '환불...' },
  { sender: 'system', text: '환불 버튼 위에서 손가락이 멈춘다', isSystemNote: true },
  { sender: 'me', text: '아 몰라. 이왕 이렇게 된 거' },
  { sender: 'me', text: '진짜 인연이란 게 있긴 한 건지, 내 눈으로 보고 만다' },
];
