import 'package:flutter/material.dart';
import 'package:smart_auction_platform/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _showBanner = false;

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    bool valid = true;

    if (!email.contains('@')) {
      setState(() {
        _showBanner = true;
      });
      valid = false;
    } else {
      setState(() {
        _showBanner = false;
      });
    }

    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 8 characters long.'),
        ),
      );
      valid = false;
    }

    if (!valid) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Please check your email and password.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } else {
      // Navigate to main page and clear stack
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Application()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            if (_showBanner)
              MaterialBanner(
                content: const Text('Email must contain @'),
                backgroundColor: Colors.red[100],
                actions: [
                  TextButton(
                    onPressed: () => setState(() => _showBanner = false),
                    child: const Text('DISMISS'),
                  ),
                ],
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        filled: true,
                        fillColor: Color(0xFFF3F4F6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        filled: true,
                        fillColor: const Color(0xFFF3F4F6),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed:
                              () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text('Sign In'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?'),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Bottom navigation bar
            Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.home, size: 28),
                      Text('Home', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.info_outline, size: 28),
                      Text('About', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
