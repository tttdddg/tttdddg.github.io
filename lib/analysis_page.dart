import 'package:flutter/material.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '个性化报告',
                      style: TextStyle(fontSize: 24, color: Colors.blue[700]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildProgressButtons(),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.grey[300],
                    child: const Center(child: Text('视频预览区域')),
                  ),
                  const SizedBox(height: 20),
                  _buildReportSection('失分点分析', ''' 
  
\n1.正手连续拉冲失误（动作结构问题）  
\n技术问题：  
正手拉球有时收前臂过快，导致摩擦不充分，球容易出界。  
重心转换不完全，影响连续拉冲的稳定性。  
\n失分方式：  
正手拉球出界（旋转控制不足）  
连续拉冲时失误（还原慢）
  
\n\n2.中远台相持弱势（力量不足）  
\n技术问题：  
在中远台对拉时力量稍逊于对手，容易陷入被动。  
退台后还原慢，影响下一板衔接。  
\n失分方式：  
对拉中下网或出界  
被对手反拉回头

\n\n3.关键分心理波动（过于激进） 
\n技术问题：  
在关键分时， 急于搏杀，导致失误率上升。  
发球变化减少，被对手适应后直接抢攻。  
\n失分方式：  
关键分盲目发力失误  
发球被对手直接抢冲

'''),
                  _buildReportSection('错误动作', '''
\n1．正手拉球收前臂过早（躯干旋转不充分）：正手拉球躯干旋转仅完成60%~70%（正常需80%~90%），过早依赖前臂收缩摩擦，导致挥拍轨迹过短。肩胛骨稳定性不足，击球时肩关节前移（正常应保持肩胛骨下沉后缩）。
\n2. 中远台退台后还原慢（核心肌群代偿不足）：退台击球后腹横肌激活不足，依赖腰部后仰代偿，导致重心后坐。步法衔接脱节，并步与交叉步转换时踝关节背屈不足（正常需背屈20°）。
\n3. 关键分盲目发力（神经肌肉控制失调 ）：关键分时交感神经过度兴奋，导致挥拍轨迹过长（正常应缩短10%~15%），肌肉刚性增加。呼吸模式紊乱（胸式呼吸替代腹式呼吸），降低击球稳定性。

'''),
                  _buildReportSection('可能引发的损伤', '''
\n1. 肩关节前移增加肩峰下撞击综合征风险；前臂代偿发力易引发肱桡肌肌腱。
\n2. 腰部后仰增加腰方肌劳损风险；踝背屈不足易引距腓前韧带扭伤。
\n3. 肌肉刚性增加易引发股四头肌或腘绳肌拉伤 ；胸式呼吸导致膈肌功能抑制，影响核心稳定性

'''),
                  _buildReportSection('针对建议', '''
错误动作一建议：
\n1.躯干旋转分离训练：固定下肢，持拍模拟拉球动作，强制完成90%躯干旋转（对镜练习）。  
2.肩胛稳定性训练 ：弹力带抗阻肩胛后缩（3组×15次/日）。    
3.肩袖肌群强化：外旋抗阻训练（侧卧哑铃外旋，3组×12次/侧）。  
4.前臂离心训练：正手握拍缓慢放球（3组×10次）。
\n\n错误动作二建议：
\n1.核心下肢联动训练 ：药球砸地后快速交叉步还原（强调腹横肌收紧，3组×10次）。  
2.踝关节灵活性训练：弹力带抗阻背屈（3组×15次/日）。  
3.腰方肌拉伸：侧卧躯干侧屈静态拉伸（每侧30秒×3组）。  
4.踝关节稳定性训练：单腿平衡垫站立（1分钟×3组/侧）。
\n\n错误动作三建议：
\n1.神经-肌肉控制训练：高压情境下进行低强度多球训练（如比分9:10时模拟）。  
2.呼吸模式重塑 ：击球前强制腹式呼吸（3秒吸气-2秒屏息-5秒呼气）。  
3.动态拉伸：运动前进行腘绳肌动态拉伸（行进间踢臀跑，2分钟）。  
4.筋膜放松：泡沫轴滚动股四头肌（每侧1分钟×2组）。

'''),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(flex: 1, child: _ChatPanel()),
        ],
      ),
    );
  }
}

class _ChatPanel extends StatefulWidget {
  @override
  __ChatPanelState createState() => __ChatPanelState();
}

class __ChatPanelState extends State<_ChatPanel> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [
    const ChatMessage(text: '您好！AI教练将持续为您服务', isAI: true),
  ];

  // 关键词回复映射
  final Map<String, String> _keywordResponses = {
    '时间久了': '长期以往，会导致肌肉刚性增加，易引发股四头肌或腘绳肌拉伤 ；胸式呼吸导致膈肌功能抑制，影响核心稳定性',
    '手腕': '若出现手腕疼痛应立即停止训练，进行冰敷处理。推荐使用护腕并加强前臂力量训练，预防腱鞘炎。',
    '装备': '推荐使用重量在85-95克之间的碳素底板，搭配反胶套胶。新手建议选择弹性适中的5层纯木底板。',
    '训练计划': '建议每周进行3次专项训练：\n1. 多球定点练习（20分钟）\n2. 步伐配合击球（15分钟）\n3. 发球机随机落点（15分钟）',
  };

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // 添加用户消息
    setState(() {
      _messages.add(ChatMessage(text: text, isAI: false));
    });

    // 模拟AI回复延迟
    Future.delayed(const Duration(milliseconds: 500), () {
      _addAIResponse(text);
    });

    _controller.clear();
  }

  void _addAIResponse(String userInput) {
    String response = '已收到您的咨询，正在分析中...';

    // 关键词匹配逻辑
    _keywordResponses.forEach((key, value) {
      if (userInput.toLowerCase().contains(key)) {
        response = value;
      }
    });

    // 默认回复
    if (response == '已收到您的咨询，正在分析中...') {
      response = '''
    收到，正在为用户定制更进一步的建议
     ''';
    }

    setState(() {
      _messages.add(ChatMessage(text: response, isAI: true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages.reversed.toList()[index];
              return _buildMessage(message);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: '请继续提问',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                mini: true,
                backgroundColor: const Color(0xFF0084FF),
                onPressed: _handleSend,
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      alignment: message.isAI ? Alignment.centerLeft : Alignment.centerRight,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isAI ? const Color(0xFF0084FF) : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: message.isAI ? Radius.zero : const Radius.circular(15),
            bottomRight: message.isAI ? const Radius.circular(15) : Radius.zero,
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isAI ? Colors.white : Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isAI;

  const ChatMessage({required this.text, required this.isAI});
}

Widget _buildProgressButtons() {
  return Center(
    child: Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [_buildProgressButton('精彩回放'), _buildProgressButton('失误捕捉')],
    ),
  );
}

Widget _buildProgressButton(String text) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      side: const BorderSide(color: Colors.grey),
    ),
    onPressed: () {},
    child: Text(text),
  );
}

Widget _buildReportSection(String title, String content) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[700],
          ),
        ),
        const SizedBox(height: 10),
        Text(content),
      ],
    ),
  );
}
