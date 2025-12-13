import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page.dart';
import 'signup_page.dart';
import 'forgot_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.to(() => const ForgotPage()),
                child: const Text('Forgot Password?'),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Get.off(() => const HomePage());
              },
              child: const Text('Login'),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () => Get.to(() => const SignupPage()),
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
