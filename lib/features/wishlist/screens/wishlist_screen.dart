import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/cart/screens/cart_screen.dart'; // <--- NEW IMPORT
import 'package:mindlabz/features/wishlist/screens/wishlist_all_view.dart';
import 'package:mindlabz/features/wishlist/screens/wishlist_child_view.dart';
import 'package:mindlabz/features/wishlist/screens/wishlist_others_view.dart';
import 'package:mindlabz/features/wishlist/screens/wishlist_women_view.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppPallete.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppPallete.backgroundColor,
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),

            // --- HEADER ---
            Text(
              'The Collection!',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: AppPallete.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'YOUR PERSONAL WARDROBE DESIGNED FOR YOU!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade400,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 30),

            // --- TAB BAR ---
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
              ),
              child: TabBar(
                isScrollable: true,
                labelColor: AppPallete.black,
                unselectedLabelColor: Colors.grey.shade400,
                indicatorColor: AppPallete.black,
                indicatorWeight: 2,
                labelStyle: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
                tabs: const [
                  Tab(text: 'ALL'),
                  Tab(text: 'WOMEN'),
                  Tab(text: 'CHILDREN'),
                  Tab(text: 'OTHERS'),
                ],
              ),
            ),

            // --- TAB CONTENT ---
            const Expanded(
              child: TabBarView(
                children: [
                  WishlistAllView(),
                  WishlistWomenView(),
                  WishlistChildView(),
                  WishlistOthersView(),
                ],
              ),
            ),

            // --- GO TO BAG BUTTON (ADDED) ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Cart Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartScreen()),
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
                    'GO TO BAG',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}