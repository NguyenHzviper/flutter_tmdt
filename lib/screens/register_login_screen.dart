// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:price_alert/screens/dashboard_screen.dart";
import "package:price_alert/services/firebase_auth.dart";
import "package:price_alert/services/flask_service.dart";
import "package:price_alert/api/firebase_message.dart";

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final fcmToken = FirebaseMessage().getStoredToken();
    emailController.text = "nguyen@gmail.com";
    passwordController.text = "123456";
    final authProvider = AuthProvider();
    final flaskProvider = FlaskProvider();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Center(
          child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: "Email", hintText: "user@example.com"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  labelText: "Password", hintText: "Password"),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Register a new user
                    String? uid = await authProvider.registerUser(
                      emailController.text,
                      passwordController.text,
                    );
                    String? token = await fcmToken;
                    if (uid != null && token != null) {
                      await flaskProvider.addDevice(uid, token);
                    }
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Log in an existing user
                    try {
                      await authProvider
                          .loginUser(
                            emailController.text,
                            passwordController.text,
                          )
                          .then((value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoard())));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
