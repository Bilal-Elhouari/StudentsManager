import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teachers/authentication/login_screen.dart';
import 'package:teachers/authentication/signup_screen.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.indigoAccent,
      ),
      home: LoginScreen(),
    );
  }
}

