import 'package:alam_tracking/firebase_options.dart';
import 'package:alam_tracking/pages/home.dart';
import 'package:alam_tracking/pages/login.dart';
import 'package:alam_tracking/pages/register.dart';
import 'package:alam_tracking/services/firebase_authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authController = FirebaseAuthController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authController.authStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return MaterialApp(
            title: 'Flutter Demo',
            initialRoute: snapshot.data != null ? '/' : '/login',
            routes: {
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterPage(),
              '/': (context) => Home(),
            },
          );
        }
        return const Loading();
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
