import 'package:flutter/material.dart';
import 'analysis_page.dart';
import 'widgets/typewriter_text.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'navigation_provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final List<Widget> _pages = [
      const HomeContent(),
      const UploadContent(),
      const AnalysisPage(),
      const UserCenter(),
    ];

    return Scaffold(
      body: Row(
        children: [
          _buildNavigationRail(context),
          Expanded(child: _pages[navProvider.currentIndex]),
        ],
      ),
    );
  }

  Widget _buildNavigationRail(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    return Container(
      width: 100,
      color: const Color(0xFF548BEB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/icon1.png',
                  width: 120,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const Text(
                  '云 鉴',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: NavigationRail(
              minWidth: 80,
              backgroundColor: const Color(0xFF548BEB),
              selectedIndex: navProvider.currentIndex,
              onDestinationSelected: (index) => navProvider.changeIndex(index),
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme: const IconThemeData(color: Colors.white70),
              selectedLabelTextStyle: const TextStyle(color: Colors.white),
              unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('首页'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.upload_outlined),
                  selectedIcon: Icon(Icons.upload),
                  label: Text('上传'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.analytics_outlined),
                  selectedIcon: Icon(Icons.analytics),
                  label: Text('分析'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_outlined),
                  selectedIcon: Icon(Icons.person),
                  label: Text('用户'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildTypewriterSection(),
          SizedBox(height: 30),
          _buildSectionTitle('关于乒乓'),
          _buildPingpongSections(),
          _buildSectionTitle('根据以往的历史数据和报告，我们给您做以下推荐'),
          _buildRecommendations(),
        ],
      ),
    );
  }

  Widget _buildTypewriterSection() {
    return Container(
      height: 180,
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: TypewriterText(), // 核心组件
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildPingpongSections() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSectionCard('运动准备', 'assets/images/oip-c-1.jpg'),
        _buildSectionCard('运动技巧', 'assets/images/oip-c.jpg'),
        _buildSectionCard('健康饮食', 'assets/images/dl.jpg'),
      ],
    );
  }

  Widget _buildSectionCard(String title, String image) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(image, height: 100),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: Text('了解更多')),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRecommendationCard('力量训练', 'assets/images/oip-c-2.jpg'),
        _buildRecommendationCard('饮食搭配', 'assets/images/meal.jpg'),
        _buildRecommendationCard('用具推荐', 'assets/images/oip-c-3.jpg'),
      ],
    );
  }

  Widget _buildRecommendationCard(String title, String image) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(image, height: 80),
          Text(title, style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: Text('了解更多')),
        ],
      ),
    );
  }
}

class UploadContent extends StatefulWidget {
  const UploadContent({Key? key}) : super(key: key);

  @override
  _UploadContentState createState() => _UploadContentState();
}

class _UploadContentState extends State<UploadContent> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _showGreeting = true;
  String? _currentVideoPath;

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _currentVideoPath = result.files.single.path;
      });
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty && _currentVideoPath == null) return;

    setState(() {
      _showGreeting = false;
      // 添加用户消息（包含视频和文字）
      _messages.add(
        ChatMessage(
          text: text.isNotEmpty ? text : "已上传视频",
          isUser: true,
          videoPath: _currentVideoPath,
        ),
      );
      // 清空输入和视频
      _controller.clear();
      _currentVideoPath = null;
      // 模拟AI回复
      _addAIResponse();
    });
  }

  void _addAIResponse() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: '视频分析已完成，请点击按钮查看报告',
            isUser: false,
            buttonAction: () {
              final navProvider = Provider.of<NavigationProvider>(
                context,
                listen: false,
              );
              navProvider.changeIndex(2);
            },
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // 初始欢迎界面
          if (_showGreeting) _buildGreetingHeader(),
          // 消息列表
          if (!_showGreeting)
            Expanded(
              child: Container(
                width: double.infinity,
                child: _buildMessageList(),
              ),
            ),
          // 输入区域
          const SizedBox(height: 20),
          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildGreetingHeader() {
    return Container(
      width: double.infinity,
      height: 500,
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '晚上好，用户abc，欢迎使用云鉴！',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '(请上传视频并按出你的要求按下ENTER部分发送)',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder:
          (context, index) => Container(
            width: double.infinity, // 列表项占满宽度
            padding: const EdgeInsets.symmetric(horizontal: 20), // 增加水平内边距
            child: _messages[index],
          ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '请输入你的要求...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          // 上传按钮
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: const Color(0xFF4488D7),
            iconSize: 32,
            onPressed: _pickVideo,
          ),
          // 新增发送按钮
          IconButton(
            icon: const Icon(Icons.send),
            color: const Color(0xFF4488D7),
            iconSize: 32,
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final String? videoPath;
  final VoidCallback? buttonAction;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isUser,
    this.videoPath,
    this.buttonAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
              minWidth: 200,
            ),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isUser ? const Color(0xFFE3F2FD) : const Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (videoPath != null) ...[
                  const Icon(Icons.videocam, size: 40),
                  Text('视频文件已上传', style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                ],
                if (text.isNotEmpty)
                  Text(text, style: const TextStyle(fontSize: 16)),
                if (buttonAction != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                      ),
                      onPressed: buttonAction,
                      child: const Text('查看详细报告'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserCenter extends StatelessWidget {
  const UserCenter({Key? key}) : super(key: key); // 修正构造函数

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildProfileSection(auth), // 统一方法名大小写
              const SizedBox(height: 20), // 修正组件名拼写
              _buildFunctionButtons(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileSection(AuthProvider auth) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF5995FD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Text(
              auth.isLoggedIn && auth.username.isNotEmpty
                  ? auth.username[0].toUpperCase()
                  : '?',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                auth.isLoggedIn ? auth.username : 'abcc',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text('ID: 100001', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('关注 110', style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 20),
                  const Text('粉丝 12', style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionButtons() {
    return Column(
      children: [
        _buildFunctionButton('我的报告', Icons.description),
        _buildFunctionButton('历史数据', Icons.history),
        _buildFunctionButton('个人信息', Icons.settings),
      ],
    );
  }

  Widget _buildFunctionButton(String text, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF4488D7)),
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
