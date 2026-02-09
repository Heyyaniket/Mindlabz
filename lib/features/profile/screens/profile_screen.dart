import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/auth/screens/login_screen.dart';
import 'package:mindlabz/features/profile/widgets/personalization_card.dart';
import 'package:mindlabz/features/profile/widgets/profile_menu_item.dart';
import 'package:mindlabz/features/wishlist/screens/wishlist_screen.dart'; // To link "My Wishlist"

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,

      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false, // No back button on main tab
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'My Profile',
            style: GoogleFonts.playfairDisplay(
              color: AppPallete.black,
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings, color: AppPallete.black, size: 24)
          ),
          const SizedBox(width: 10),
        ],
      ),

      // --- BODY ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // 1. PROFILE PICTURE
            Center(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3), // Gap for the ring
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFC9A761), width: 1), // Gold Ring
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1621452773781-0f992ee61c67?q=80&w=1974&auto=format&fit=crop', // Bear/Kid placeholder
                      ),
                    ),
                  ),
                  // Checkmark Badge
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFC9A761),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 12),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),

            // 2. NAME & VIP STATUS
            Text(
              'Name',
              style: GoogleFonts.playfairDisplay(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: AppPallete.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'VIP',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFC9A761), // Gold
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            // 3. MENU LIST
            ProfileMenuItem(title: 'Order History', onTap: () {}),
            ProfileMenuItem(
                title: 'My Wishlist',
                onTap: () {
                  // Navigate to Wishlist
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WishlistScreen()),
                  );
                }
            ),
            ProfileMenuItem(title: 'Shipping Addresses', onTap: () {}),
            ProfileMenuItem(title: 'Payment Methods', onTap: () {}),
            ProfileMenuItem(title: 'Rewards', onTap: () {}),

            const SizedBox(height: 40),

            // 4. PERSONALIZATION SECTION
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'PERSONALIZATION',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade500,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Row(
              children:  [
                PersonalizationCard(title: 'Personalize', icon: Icons.auto_awesome), // Sparkle Icon
                SizedBox(width: 15),
                PersonalizationCard(title: 'The little Ones', icon: Icons.auto_awesome),
              ],
            ),

            const SizedBox(height: 50),

            // 5. LOGOUT
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false, 
                );
              },
              child: Text(
                'LOGOUT',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFC9A761),
                  letterSpacing: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}