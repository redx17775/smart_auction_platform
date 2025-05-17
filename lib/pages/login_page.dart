import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_auction_platform/main.dart';
import '../providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _showBanner = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    bool valid = true;

    // Clear any previous errors
    context.read<AuthProvider>().clearError();

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
          backgroundColor: Colors.red,
        ),
      );
      valid = false;
    }

    if (!valid) {
      return;
    }

    try {
      print('Starting sign in process...'); // Debug log
      await context.read<AuthProvider>().signIn(email, password);
      print('Sign in completed successfully'); // Debug log
    } catch (e) {
      print('Error during sign in: $e'); // Debug log
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    }
  }

  void _testFirestoreConnection() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final result = await firestore.collection('users').limit(1).get();
      print(
        'Firestore connection test - Documents found: ${result.docs.length}',
      );
      if (result.docs.isNotEmpty) {
        print('Sample document data: ${result.docs.first.data()}');
      }
    } catch (e) {
      print('Firestore connection error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isAuthenticated) {
          // Navigate to main page and clear stack
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Application()),
              (route) => false,
            );
          });
        }

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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          enabled: !authProvider.isLoading,
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
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
                          enabled: !authProvider.isLoading,
                        ),
                        if (authProvider.error != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              authProvider.error!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: authProvider.isLoading ? null : _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child:
                                authProvider.isLoading
                                    ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : const Text('Log In'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextButton(
                          onPressed: authProvider.isLoading ? null : () {},
                          child: const Text('Forgot Password?'),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text("Don't have an account? "),
                            TextButton(
                              onPressed: authProvider.isLoading ? null : () {},
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
      },
    );
  }
}
