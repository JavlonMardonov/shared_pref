import 'package:flutter/material.dart';
import 'package:shared_pref/storage/data_source.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final database = TokenDataSource();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  bool _rememberMe = true;
  bool _isPasswordVisible = true;
  @override
  void initState() {
    setUserInfos();
    super.initState();
  }

  Future<void> setUserInfos() async {
    final infos = await database.getUserInfo();
    _usernameController.text = infos['name'] ?? "";
    _emailController.text = infos['email'] ?? "";
    _passwordController.text = infos['password'] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     // Handle back press
        //   },
        // ),
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Username',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: _usernameController.text.length > 5
                    ? Icon(
                        Icons.check,
                        color: Colors.green[600],
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    autocorrect: false,
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Email Address',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon:
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(_emailController.text)
                        ? Icon(
                            Icons.check,
                            color: Colors.green[600],
                          )
                        : null,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Remember me'),
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
              activeColor: Colors.purple,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  setState(() {});
                  if (_rememberMe) {
                    await database.saveUserInfo(_usernameController.text,
                        _emailController.text, _passwordController.text);
                  }
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
