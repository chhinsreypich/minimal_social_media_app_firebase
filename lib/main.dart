import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media_app_firebase/auth/auth.dart';
import 'package:minimal_social_media_app_firebase/auth/login_or_register.dart';
import 'package:minimal_social_media_app_firebase/firebase_options.dart';
import 'package:minimal_social_media_app_firebase/pages/home_page.dart';
import 'package:minimal_social_media_app_firebase/pages/profile_page.dart';
import 'package:minimal_social_media_app_firebase/pages/users_page.dart';
import 'package:minimal_social_media_app_firebase/theme/dark_mode.dart';
import 'package:minimal_social_media_app_firebase/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/users_page': (context) => const UsersPage(),
        '/profile_page': (context) =>  ProfilePage(),
      }
    );
  }
}