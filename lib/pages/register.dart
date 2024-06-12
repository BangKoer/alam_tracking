import 'package:alam_tracking/services/firebase_authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  final _emailTextfieldcontroller = TextEditingController();
  final _passwordTextfieldcontroller = TextEditingController();
  final _fullnameTextfieldcontroller = TextEditingController();
  final _usernameTextfieldcontroller = TextEditingController();
  final FirebaseAuthController _auth = FirebaseAuthController();

  @override
  void dispose() {
    _emailTextfieldcontroller.dispose();
    _passwordTextfieldcontroller.dispose();
    _fullnameTextfieldcontroller.dispose();
    _usernameTextfieldcontroller.dispose();
    super.dispose();
  }

  void signup() async {
    String email = _emailTextfieldcontroller.text;
    String password = _passwordTextfieldcontroller.text;
    String fullname = _fullnameTextfieldcontroller.text;
    String username = _usernameTextfieldcontroller.text;

    User? user = await _auth.registerwithEmailandPassword(
        email, password, fullname, username);
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Register Success!"),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error Register! Try again"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/hiking.png",
              scale: 4,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _fullnameTextfieldcontroller,
              decoration: InputDecoration(
                suffixIconColor: Colors.green.shade700,
                prefixIconColor: Colors.green.shade700,
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: Colors.green.shade700),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green.shade700),
                ),
                label: Text("Fullname"),
                prefixIcon: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _usernameTextfieldcontroller,
              decoration: InputDecoration(
                suffixIconColor: Colors.green.shade700,
                prefixIconColor: Colors.green.shade700,
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: Colors.green.shade700),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green.shade700),
                ),
                label: Text("Username"),
                prefixIcon: Icon(
                  Icons.alternate_email,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _emailTextfieldcontroller,
              decoration: InputDecoration(
                suffixIconColor: Colors.green.shade700,
                prefixIconColor: Colors.green.shade700,
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: Colors.green.shade700),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green.shade700),
                ),
                label: Text("Email"),
                prefixIcon: Icon(
                  Icons.email,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordTextfieldcontroller,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                suffixIconColor: Colors.green.shade700,
                prefixIconColor: Colors.green.shade700,
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: Colors.green.shade700),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green.shade700),
                ),
                label: const Text("Password"),
                prefixIcon: const Icon(
                  Icons.lock,
                  size: 30,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Icon(_isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green[700],
              ),
              onPressed: signup,
              child: const Text("Sign Up"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already Have an Account ? "),
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green[700],
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Login"))
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
