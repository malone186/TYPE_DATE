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
                        MaterialPageRoute(builder: (_) => const EpilogueScreen()),
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
          _axisGrid(),
          const SizedBox(height: 6),
          Text(
            style.summary,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              color: _paperSub,
              height: 1.6,
            ),
          ),

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

    return Row(
      children: [
        SizedBox(
          width: 14,
          child: Text(left,
            style: const TextStyle(fontFamily: 'Pretendard', fontSize: 11, color: _paperSub, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: SizedBox(
              height: 7,
              child: Stack(children: [
                Container(color: const Color(0xFFE2DDD8)),
                FractionallySizedBox(
                  widthFactor: ratio,
                  child: Container(color: _paperBorder),
                ),
              ]),
            ),
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          width: 14,
          child: Text(right,
            textAlign: TextAlign.right,
            style: const TextStyle(fontFamily: 'Pretendard', fontSize: 11, color: _paperSub, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
