// PRD v1.2 §10 데이터 모델 기반

class TDCharacter {
  final String id;
  final String name;
  final int age;
  final String job;
  final String location;
  final String mbti;
  final String intro;
  final List<String> tags;
  final bool isUnlocked;
  final String? imagePath;

  const TDCharacter({
    required this.id,
    required this.name,
    required this.age,
    required this.job,
    required this.location,
    required this.mbti,
    required this.intro,
    required this.tags,
    this.isUnlocked = false,
    this.imagePath,
  });
}

class Choice {
  final String label; // A / B / C / D
  final String text;
  final String primaryAxis;
  final String secondaryAxis;
  final int likeScore; // +1 or -1
  final String npcReaction;

  const Choice({
    required this.label,
    required this.text,
    required this.primaryAxis,
    required this.secondaryAxis,
    required this.likeScore,
    required this.npcReaction,
  });
}

class Turn {
  final int turnNumber;
  final String npcMessage;
  final String monologue;
  final bool isPlayerInitiated;
  final List<Choice> choices; // A,B,C,D

  const Turn({
    required this.turnNumber,
    required this.npcMessage,
    required this.monologue,
    required this.isPlayerInitiated,
    required this.choices,
  });
}

class BlindDate {
  final String id;
  final TDCharacter character;
  final List<Turn> turns;
  final List<ChatLine> openingScript; // 도착·인사·착석 — 선택지 없이 자동 진행되는 도입부

  const BlindDate({
    required this.id,
    required this.character,
    required this.turns,
    this.openingScript = const [],
  });
}

enum Ending { success, friend, fail }

class DateResult {
  final String dateId;
  final int likeScore;
  final Ending ending;
  final Map<String, int> axisScore; // E,I,N,S,T,F,J,P
  final String styleType; // EF/ET/IF/IT
  final DateTime completedAt;

  const DateResult({
    required this.dateId,
    required this.likeScore,
    required this.ending,
    required this.axisScore,
    required this.styleType,
    required this.completedAt,
  });

  String get axisLetters {
    final ei = (axisScore['E'] ?? 0) >= (axisScore['I'] ?? 0) ? 'E' : 'I';
    final ns = (axisScore['N'] ?? 0) >= (axisScore['S'] ?? 0) ? 'N' : 'S';
    final tf = (axisScore['T'] ?? 0) >= (axisScore['F'] ?? 0) ? 'T' : 'F';
    final jp = (axisScore['J'] ?? 0) >= (axisScore['P'] ?? 0) ? 'J' : 'P';
    return '$ei$ns$tf$jp';
  }
}

class StyleInfo {
  final String code; // EF/ET/IF/IT
  final String emoji;
  final String title;
  final String summary;
  final String goodPoint;
  final String badPoint;
  final String compatibilityStars; // e.g. ★★★★★
  final String compatibilityComment;
  final Map<Ending, String> endingMessages;

  const StyleInfo({
    required this.code,
    required this.emoji,
    required this.title,
    required this.summary,
    required this.goodPoint,
    required this.badPoint,
    required this.compatibilityStars,
    required this.compatibilityComment,
    required this.endingMessages,
  });
}

class GameProgress {
  final Map<String, DateResult> results;
  final int totalCompleted;
  final String? overallStyle;

  const GameProgress({
    this.results = const {},
    this.totalCompleted = 0,
    this.overallStyle,
  });

  GameProgress copyWith({
    Map<String, DateResult>? results,
    int? totalCompleted,
    String? overallStyle,
  }) {
    return GameProgress(
      results: results ?? this.results,
      totalCompleted: totalCompleted ?? this.totalCompleted,
      overallStyle: overallStyle ?? this.overallStyle,
    );
  }
}

/// 카톡 모방 채팅 한 줄 (프롤로그/에필로그/소개팅 도입부용)
class ChatLine {
  final String sender; // 'me' or character name
  final String text;
  final bool isSystemNote; // [화면 설명] 류 — 가운데 정렬 안내문
  final bool isMonologue; // 주인공 속마음 — 이탤릭 가운데 정렬

  const ChatLine(
    this.sender,
    this.text, {
    this.isSystemNote = false,
    this.isMonologue = false,
  });
}
