import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/auth/screens/login_screen.dart';
import 'package:mindlabz/features/auth/widgets/auth_field.dart';
import 'package:mindlabz/features/auth/widgets/social_button.dart';

class RecoverAccountScreen extends StatelessWidget {
  const RecoverAccountScreen({super.key});

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
              const SizedBox(height: 60),

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
                'Set New Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: AppPallete.textGrey,
                ),
              ),

              const SizedBox(height: 50),

              // --- INPUTS ---
              const AuthField(
                label: 'NEW PASSWORD',
                hintText: '******',
                isObscure: true,
              ),
              const SizedBox(height: 25),
              const AuthField(
                label: 'CONFIRM PASSWORD',
                hintText: '******',
                isObscure: true,
              ),

              const SizedBox(height: 40),

              // --- RESET BUTTON ---
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
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
                    'RESET PASSWORD',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // --- CONNECT WITH ---
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

              // --- SOCIAL BUTTONS ---
              const Row(
                children: [
                  Expanded(child: SocialButton(icon: Icons.apple, size: 26)),
                  SizedBox(width: 20),
                  Expanded(child: SocialButton(icon: Icons.g_mobiledata, size: 36, isGoogle: true)),
                ],
              ),

              const SizedBox(height: 60),

              // --- FOOTER (Link back to Sign In) ---
              Column(
                children: [
                  Text(
                    'Remember Password?',
                    style: GoogleFonts.inter(
                      color: AppPallete.textGrey.withOpacity(0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false,
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppPallete.goldAccent, width: 1))
                      ),
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        'SIGN IN',
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