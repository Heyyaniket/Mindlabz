import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/auth/screens/forgot_password_screen.dart';
import 'package:mindlabz/features/auth/screens/signup_screen.dart';
import 'package:mindlabz/features/auth/widgets/auth_field.dart';
import 'package:mindlabz/features/auth/widgets/social_button.dart';
import 'package:mindlabz/features/home/screens/home_screen.dart'; // <--- NEW IMPORT

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),

              // --- HEADER ---
              Text(
                'Mindlabs',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: AppPallete.black,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: AppPallete.textGrey,
                ),
              ),

              const SizedBox(height: 60),

              // --- INPUTS ---
              const AuthField(label: 'EMAIL ADDRESS', hintText: 'example@mindlabs.com'),
              const SizedBox(height: 25),
              const AuthField(label: 'PASSWORD', hintText: '******', isObscure: true),

              const SizedBox(height: 40),

              // --- LOGIN BUTTON ---
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Home Screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.black,
                    foregroundColor: AppPallete.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'LOGIN',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // --- FORGOT PASSWORD (LINKED) ---
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  style: TextButton.styleFrom(foregroundColor: AppPallete.textGrey),
                  child: Text(
                    'FORGOT PASSWORD?',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // --- DIVIDER ---
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFE0E0E0), thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'CONNECT WITH',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade400,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFE0E0E0), thickness: 1)),
                ],
              ),

              const SizedBox(height: 40),

              // --- SOCIAL BUTTONS (LINKED TO HOME) ---
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Home Screen on Tap
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                      child: const SocialButton(icon: Icons.apple, size: 26),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Home Screen on Tap
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                      child: const SocialButton(icon: Icons.g_mobiledata, size: 36, isGoogle: true),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 80),

              // --- CREATE ACCOUNT FOOTER ---
              Column(
                children: [
                  Text(
                    'New User?',
                    style: GoogleFonts.inter(
                      color: AppPallete.textGrey.withValues(alpha: 0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupScreen()),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppPallete.goldAccent, width: 1))
                      ),
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        'CREATE ACCOUNT',
                        style: GoogleFonts.inter(
                          color: AppPallete.goldAccent,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}