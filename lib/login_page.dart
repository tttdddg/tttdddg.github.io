import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isSignUp = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _toggleView() {
    setState(() {
      _isSignUp = !_isSignUp;
      _isSignUp ? _controller.forward() : _controller.reverse();
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    _isSignUp
                        ? [const Color(0xFF4D84E2), const Color(0xFF5995FD)]
                        : [Colors.white, Colors.white],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.15,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _isSignUp ? _buildSignUpForm() : _buildSignInForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInForm() {
    return _buildFormContainer(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '登录',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          _buildInputField('用户名', Icons.person, _usernameController),
          const SizedBox(height: 15),
          _buildInputField(
            '密码',
            Icons.lock,
            _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4488D7),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text('登录', style: TextStyle(fontSize: 18)),
          ),
          TextButton(onPressed: _toggleView, child: const Text('没有账号？立即注册')),
        ],
      ),
    );
  }

  Widget _buildSignUpForm() {
    return _buildFormContainer(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '注册',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          _buildInputField('用户名', Icons.person, _usernameController),
          const SizedBox(height: 15),
          _buildInputField('邮箱', Icons.email, _emailController),
          const SizedBox(height: 15),
          _buildInputField(
            '密码',
            Icons.lock,
            _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4488D7),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text('注册', style: TextStyle(fontSize: 18)),
          ),
          TextButton(onPressed: _toggleView, child: const Text('已有账号？立即登录')),
        ],
      ),
    );
  }

  Widget _buildFormContainer(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(key: _formKey, child: child),
    );
  }

  Widget _buildInputField(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4488D7), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      style: const TextStyle(fontSize: 14),
      validator: (value) => value!.isEmpty ? '$label不能为空' : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
