import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/auth/screens/login_screen.dart'; // <--- This is the key import!

void main() {
  runApp(const MindlabzApp());
}

class MindlabzApp extends StatelessWidget {
  const MindlabzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindlabz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.inter().fontFamily, // Default font for the whole app
        scaffoldBackgroundColor: AppPallete.backgroundColor, // Set default background
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPallete.black,
          brightness: Brightness.light,
        ),
      ),
      // This tells the app to load your Login Screen first
      home: const LoginScreen(),
    );
  }
}