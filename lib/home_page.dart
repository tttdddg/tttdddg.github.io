import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _colorController;
  late Animation<Color?> _titleAnimation;
  late Animation<Color?> _buttonAnimation;

  final String _description =
      '这是一个通过视觉识别、动作分析和跨模态整合研究，AI技术来帮助运动员提升技术细节、减少训练中的错误动作和运动损伤的网站。';
  int _textIndex = 0;
  late Timer _textTimer;

  @override
  void initState() {
    super.initState();

    // 颜色动画配置
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _titleAnimation = ColorTween(
      begin: const Color.fromARGB(255, 100, 84, 110),
      end: Colors.white,
    ).animate(_colorController);

    _buttonAnimation = ColorTween(
      begin: const Color.fromARGB(255, 63, 86, 113),
      end: Colors.blueAccent,
    ).animate(_colorController);

    _textTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_textIndex < _description.length) {
        setState(() => _textIndex++);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _colorController.dispose();
    _textTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              // 变色标题
              AnimatedBuilder(
                animation: _colorController,
                builder: (context, child) {
                  return Text(
                    '云 鉴',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: _titleAnimation.value,
                      shadows: const [Shadow(blurRadius: 10)],
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
              // 逐字显示文字
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _description.substring(0, _textIndex),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              _buildWelcomeText(),
              const Spacer(),
              _buildStartButton(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        _buildAnimatedLine('在这个智能分析的平台上，'),
        const SizedBox(height: 20),
        _buildAnimatedLine('我们致力于提供精准的运动分析解决方案'),
        const SizedBox(height: 20),
        _buildAnimatedLine('欢迎您的加入和使用！', isMain: true),
      ],
    );
  }

  Widget _buildAnimatedLine(String text, {bool isMain = false}) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _textIndex >= _description.length ? 1.0 : 0.0,
      child: Text(
        text,
        style: TextStyle(
          color: isMain ? Colors.white : Colors.white70,
          fontSize: isMain ? 20 : 16,
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorController,
      builder: (context, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _buttonAnimation.value,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 5,
            shadowColor: Colors.black54,
          ),
          onPressed: () => Navigator.pushNamed(context, '/login'),
          child: const Text(
            '点击开始使用',
            style: TextStyle(
              fontSize: 21,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 2)],
            ),
          ),
        );
      },
    );
  }
}
