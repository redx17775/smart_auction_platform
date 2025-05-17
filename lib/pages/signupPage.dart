import 'package:flutter/material.dart';
import '../models/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String accountType = 'Buyer';

  bool _validateUsername(String username) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(username);
  }

  bool _validatePassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[a-zA-Z]').hasMatch(password) &&
        RegExp(r'\d').hasMatch(password);
  }

  bool _validateEmail(String email) {
    return email.endsWith('@gmail.com');
  }

  bool _validatePhone(String phone) {
    return phone.length == 8 &&
        (phone.startsWith('7') || phone.startsWith('9')) &&
        RegExp(r'^[0-9]+$').hasMatch(phone);
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      users.add(User(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim().isEmpty
            ? null
            : _addressController.text.trim(),
        accountType: accountType,
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signup Successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _usernameController,
                    decoration: _inputDecoration('Username'),
                    validator: (value) {
                      if (value == null || !_validateUsername(value.trim())) {
                        return 'Username must contain letters only ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: _inputDecoration('Password'),
                    validator: (value) {
                      if (value == null || !_validatePassword(value.trim())) {
                        return 'Password must be at least 8 characters(letters and numbers)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: _inputDecoration('Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || !_validateEmail(value.trim())) {
                        return 'Incorrect Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: _inputDecoration('Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || !_validatePhone(value.trim())) {
                        return 'Incorrect Phone Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: _inputDecoration('Address'),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text('Account Type:'),
                      const SizedBox(width: 20),
                      DropdownButton<String>(
                        value: accountType,
                        onChanged: (value) {
                          setState(() {
                            accountType = value!;
                          });
                        },
                        items: ['Buyer', 'Seller']
                            .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                            .toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
