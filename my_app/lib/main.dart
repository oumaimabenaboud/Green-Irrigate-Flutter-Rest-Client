import 'package:flutter/material.dart';
import 'package:my_app/ui/screens/intro_screen.dart';
import 'package:my_app/ui/screens/auth_screen.dart';
import 'package:my_app/ui/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Irrigate',
      theme: ThemeData(
      primarySwatch: MaterialColor(
        0xff4D7F4D, {
          50: Color(0xffE4F1E4),
          100: Color(0xffC7E3C7),
          200: Color(0xffA9D4A9),
          300: Color(0xff8BCC8B),
          400: Color(0xff6EC46E),
          500: Color(0xff4D7F4D), // Primary color
          600: Color(0xff406740),
          700: Color(0xff335433),
          800: Color(0xff263726),
          900: Color(0xff192819),
          1000: Color(0xff92BA92),
          1100: Color(0xffFFBC75),
          1200: Color(0xffC7EDC7),
          1300: Color(0xffF7F7F2),
        },
      ),



        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xfff2f9fe),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(25),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      home: IntroScreen(),
      routes: {
        'intro': (context) => IntroScreen(),
        'home': (context) => HomeScreen(),
        'login': (context) => AuthScreen(authType: AuthType.login),
        'register': (context) => AuthScreen(authType: AuthType.register),
      },
    );
  }
}
