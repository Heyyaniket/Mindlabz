import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/home/screens/home_screen.dart'; // To return home

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order Placed!',
          style: GoogleFonts.playfairDisplay(
            color: AppPallete.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. CHECKMARK ICON
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer thin ring
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFF5EFE6), width: 1.5),
                      ),
                    ),
                    // Inner Gold Circle with Check
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFC9A761), // Gold
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 30),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 2. THANK YOU TEXT
              Text(
                'Thankyou\nfor your order',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: AppPallete.black,
                  fontStyle: FontStyle.italic,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 40),

              // 3. CONFIRMATION NUMBER
              Text(
                'CONFIRMATION',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade400,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '#MH-16-100101',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 30),

              // 4. DIVIDER
              const SizedBox(
                width: 200,
                child: Divider(color: Color(0xFFE0E0E0)),
              ),
              const SizedBox(height: 30),

              // 5. CONFIRMATION MESSAGE
              Text(
                'An email confirmation has been sent to your\nemail address. Happy Shopping!',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 60),

              // 6. TRACK ORDER BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: () {
                    // Track order logic
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFC9A761)),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text(
                    'TRACK YOUR ORDER',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFC9A761),
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 7. RETURN HOME LINK
              GestureDetector(
                onTap: () {
                  // Navigate back to Home and clear stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (route) => false,
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1))
                  ),
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'RETURN HOME',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade400,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}