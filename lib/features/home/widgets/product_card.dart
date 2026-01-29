import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/product/screens/product_detail_screen.dart'; // <--- NEW IMPORT

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String tag; // "HOT" or "NEW"
  final String brand;
  final String name;
  final String price;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.tag,
    required this.brand,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // --- NAVIGATION LOGIC ---
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductDetailScreen(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- IMAGE & TAG SECTION ---
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Tag (HOT/NEW)
                if (tag.isNotEmpty) // Only show if tag exists
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      color: AppPallete.black,
                      child: Text(
                        tag,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                // Heart Icon
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(Icons.favorite, color: Color(0xFFFBB000), size: 20),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // --- DETAILS SECTION ---
          Text(
            brand.toUpperCase(),
            style: GoogleFonts.inter(
              color: const Color(0xFFC9A761), // Gold
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: GoogleFonts.playfairDisplay(
              color: AppPallete.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: GoogleFonts.inter(
              color: AppPallete.textGrey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}