import 'package:flutter/material.dart';
import 'dart:async';

class TypewriterText extends StatefulWidget {
  const TypewriterText({super.key});

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  final List<List<String>> textGroups = [
    ['智能分析，让云鉴做你的', '数据管家'],
    ['赛后复盘，让云鉴做你的', '智慧锦囊'],
    ['训练报告，让云鉴做你的', '运动顾问'],
    ['个性推荐，让云鉴做你的', 'AI专家'],
  ];

  int currentGroup = 0;
  int currentSegment = 0;
  int charIndex = 0;
  final List<Widget> currentText = [];
  bool showCursor = true;
  late Timer timer;
  late AnimationController cursorController;

  @override
  void initState() {
    super.initState();
    cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    startTyping();
  }

  void startTyping() {
    timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (currentGroup >= textGroups.length) currentGroup = 0;

      final currentSegments = textGroups[currentGroup];
      if (charIndex < currentSegments[currentSegment].length) {
        setState(() {
          currentText.add(
            AnimatedChar(
              char: currentSegments[currentSegment][charIndex],
              isSpecial: currentSegment == 1,
              delay: charIndex,
            ),
          );
          charIndex++;
        });
      } else if (currentSegment < currentSegments.length - 1) {
        currentSegment++;
        charIndex = 0;
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            currentGroup++;
            currentSegment = 0;
            charIndex = 0;
            currentText.clear();
          });
        });
        timer.cancel();
        Future.delayed(const Duration(seconds: 3), startTyping);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        ...currentText,
        AnimatedBuilder(
          animation: cursorController,
          builder: (context, child) {
            return Visibility(
              visible: showCursor && currentSegment == 1,
              child: Opacity(
                opacity: cursorController.value,
                child: const Text(
                  '_',
                  style: TextStyle(fontSize: 36, color: Colors.blue),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class AnimatedChar extends StatelessWidget {
  final String char;
  final bool isSpecial;
  final int delay;

  const AnimatedChar({
    required this.char,
    required this.isSpecial,
    required this.delay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              char,
              style: TextStyle(
                fontSize: 36,
                color: isSpecial ? Colors.blue : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
