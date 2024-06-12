import 'package:alam_tracking/services/firebase_authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final _emailTextfieldcontroller = TextEditingController();
  final _passwordTextfieldcontroller = TextEditingController();
  final FirebaseAuthController _auth = FirebaseAuthController();

  void dispose() {
    // TODO: implement dispose
    _emailTextfieldcontroller.dispose();
    _passwordTextfieldcontroller.dispose();
    super.dispose();
  }

  void signIn() async {
    String email = _emailTextfieldcontroller.text;
    String password = _passwordTextfieldcontroller.text;
    User? user = await _auth.loginwithEmailandPassword(email, password);
    if (user != null) {
      print("Login Success");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login Success!"),
        backgroundColor: Colors.green,
      ));
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (route) => false,
      );
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
      body: SafeArea(
        child: Padding(
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
                cursorColor: Colors.green,
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
                    Icons.password,
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
                onPressed: signIn,
                child: const Text("Login"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have an Account ? "),
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green[700],
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/register'),
                      child: const Text("Register"))
                ],
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
