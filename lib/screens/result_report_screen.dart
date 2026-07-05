import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../data/episode1_data.dart';
import '../models/models.dart';
import '../widgets/common.dart';
import 'sns_card_screen.dart';
import 'epilogue_screen.dart';

class ResultReportScreen extends StatefulWidget {
  final DateResult result;
  const ResultReportScreen({super.key, required this.result});

  @override
  State<ResultReportScreen> createState() => _ResultReportScreenState();
}

class _ResultReportScreenState extends State<ResultReportScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final style = styleInfoMap[widget.result.styleType] ?? styleInfoMap['EF']!;
    final now = widget.result.completedAt;

    return Scaffold(
      backgroundColor: c.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              const Align(alignment: Alignment.topRight, child: ThemeToggleButton()),
              _DocumentCard(result: widget.result, style: style, now: now, ctrl: _ctrl, c: c),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CoralButton(
                      label: '카드 공유',
                      outlined: true,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SnsCardScreen(result: widget.result),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CoralButton(
                      label: '다음 소개팅',
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => EpilogueScreen(result: widget.result),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final DateResult result;
  final StyleInfo style;
  final DateTime now;
  final AnimationController ctrl;
  final TypeDateTokens c;

  const _DocumentCard({
    required this.result,
    required this.style,
    required this.now,
    required this.ctrl,
    required this.c,
  });

  static const _paperBg   = Color(0xFFFFFDF9);
  static const _paperBorder = Color(0xFF2B2723);
  static const _paperText  = Color(0xFF1A1714);
  static const _paperSub   = Color(0xFF555050);
  static const _accentBlue = Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _paperBg,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.18), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          _coverSection(),
          _dividerLine(),
          _bodySection(),
        ],
      ),
    );
  }

  // ── 표지 영역 ──────────────────────────────────────────────
  Widget _coverSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 36, 28, 32),
      decoration: const BoxDecoration(
        border: Border(
          left:   BorderSide(color: _paperBorder, width: 1.5),
          top:    BorderSide(color: _paperBorder, width: 1.5),
          right:  BorderSide(color: _paperBorder, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 제목
          Text(
            '「${jisu.name}」 소개팅 결과보고서',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _paperText,
              height: 1.5,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 28),

          // 불릿 정보
          _bulletRow('상대방', '${jisu.name} · ${jisu.age}세 (${jisu.mbti})', isHighlight: false),
          const SizedBox(height: 10),
          _bulletRow('나의 유형', '${style.title} ${style.emoji}', isHighlight: true),
          const SizedBox(height: 10),
          _bulletRow('소개팅 결과', _endingLabel(result.ending), isHighlight: false),

          const SizedBox(height: 36),

          // 날짜
          Text(
            '${now.year}년  ${now.month}월  ${now.day}일',
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 13,
              color: _paperSub,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 28),

          // 스탬프 영역
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'TYPE DATE  :',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13,
                  color: _accentBlue,
                ),
              ),
              const SizedBox(width: 40),
              _stampCircle(result.ending),
            ],
          ),
          const SizedBox(height: 24),

          // 수신인
          const Text(
            '나 귀하',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 13,
              color: _paperSub,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletRow(String label, String value, {required bool isHighlight}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•  ', style: TextStyle(fontSize: 13, color: _paperText)),
        Text(
          '$label  :  ',
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 13,
            color: _paperText,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 13,
              color: isHighlight ? _accentBlue : _paperText,
              fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _stampCircle(Ending ending) {
    final (emoji, color) = switch (ending) {
      Ending.success => ('💘', const Color(0xFFE53E3E)),
      Ending.friend  => ('🤝', const Color(0xFF2B6CB0)),
      Ending.fail    => ('💨', const Color(0xFF718096)),
    };
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(emoji, style: const TextStyle(fontSize: 22)),
      ),
    );
  }

  String _endingLabel(Ending e) {
    return switch (e) {
      Ending.success => '💘 성공',
      Ending.friend  => '🤝 친구',
      Ending.fail    => '💨 실패',
    };
  }

  // ── 구분선 ──────────────────────────────────────────────────
  Widget _dividerLine() {
    return Container(
      height: 1.5,
      color: _paperBorder,
    );
  }

  // ── 본문 영역 ──────────────────────────────────────────────
  Widget _bodySection() {
    final endingMsg = style.endingMessages[result.ending] ?? '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
      decoration: const BoxDecoration(
        border: Border(
          left:   BorderSide(color: _paperBorder, width: 1.5),
          bottom: BorderSide(color: _paperBorder, width: 1.5),
          right:  BorderSide(color: _paperBorder, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 성격 유형 분석
          _sectionHeader('1.  성격 유형 분석'),
          const SizedBox(height: 12),
          _axisOverview(),
          const SizedBox(height: 14),
          _axisGrid(),

          _sectionDivider(),

          // 궁합
          _sectionHeader('2.  궁합'),
          const SizedBox(height: 10),
          _infoBlock(
            '${style.compatibilityStars}  ${style.compatibilityComment}',
          ),

          _sectionDivider(),

          // 잘한 점
          _sectionHeader('3.  잘한 점'),
          const SizedBox(height: 10),
          _infoBlock(style.goodPoint),

          _sectionDivider(),

          // 아쉬운 점
          _sectionHeader('4.  아쉬운 점'),
          const SizedBox(height: 10),
          _infoBlock(style.badPoint),

          _sectionDivider(),

          // 한마디
          _sectionHeader('5.  TYPE DATE 한마디'),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FF),
              border: Border.all(color: const Color(0xFFBFD4F5)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              endingMsg,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 13,
                color: _paperText,
                height: 1.7,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 진행 현황
          Center(
            child: Text(
              '1 / 16 완료  ·  15명이 기다리고 있어요 👀',
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 11,
                color: _paperSub,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: _paperText,
          letterSpacing: -0.2,
        ),
      ),
    );
  }

  Widget _sectionDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Divider(color: Color(0xFFDDD8D2), thickness: 1, height: 1),
    );
  }

  Widget _infoBlock(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5F2),
        border: Border(left: BorderSide(color: _paperBorder.withValues(alpha: 0.35), width: 3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 13,
          color: _paperText,
          height: 1.7,
        ),
      ),
    );
  }

  Widget _axisOverview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FF),
        border: Border.all(color: const Color(0xFFD8E3FF)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _accentBlue,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  result.axisLetters,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  style.title,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _paperText,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            style.summary,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              color: _paperSub,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _axisGrid() {
    return AnimatedBuilder(
      animation: ctrl,
      builder: (_, _) => Column(
        children: [
          _axisRow('E', 'I'),
          const SizedBox(height: 8),
          _axisRow('N', 'S'),
          const SizedBox(height: 8),
          _axisRow('T', 'F'),
          const SizedBox(height: 8),
          _axisRow('J', 'P'),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _axisRow(String left, String right) {
    final l = result.axisScore[left] ?? 0;
    final r = result.axisScore[right] ?? 0;
    final total = (l + r) == 0 ? 1 : (l + r);
    final ratio = ((l / total) * ctrl.value + 0.5 * (1 - ctrl.value)).clamp(0.0, 1.0);
    final leftWins = l >= r;
    final leftPercent = ((l / total) * 100).round();
    final rightPercent = 100 - leftPercent;
    final dominant = leftWins ? left : right;

    TextStyle labelStyle(bool isWinner) => TextStyle(
          fontFamily: 'Pretendard',
          fontSize: isWinner ? 13 : 12,
          color: isWinner ? _accentBlue : _paperSub.withValues(alpha: 0.55),
          fontWeight: isWinner ? FontWeight.w800 : FontWeight.w500,
        );

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F7F4),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE7E1DA)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _axisLabel(left),
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _paperText,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _accentBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '$dominant 우세',
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _accentBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 40,
                child: Text('$left  $leftPercent%', style: labelStyle(leftWins)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: SizedBox(
                    height: 10,
                    child: Stack(children: [
                      Container(color: const Color(0xFFE2DDD8)),
                      FractionallySizedBox(
                        widthFactor: ratio,
                        child: Container(color: leftWins ? _accentBlue : _paperBorder),
                      ),
                    ]),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                child: Text(
                  '$rightPercent%  $right',
                  textAlign: TextAlign.right,
                  style: labelStyle(!leftWins),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _axisLabel(String axis) {
    return switch (axis) {
      'E' => '에너지 방향',
      'N' => '정보 해석 방식',
      'T' => '판단 기준',
      'J' => '생활 패턴',
      _ => axis,
    };
  }
}
