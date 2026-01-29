import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String brand;
  final String size;
  final String price;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.brand,
    required this.size,
    required this.price,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. IMAGE
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),

          // 2. DETAILS (Middle)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      brand.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Size:$size',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppPallete.textGrey,
                      ),
                    ),
                  ],
                ),

                // Move to Wishlist Link
                GestureDetector(
                  onTap: () {
                    // Logic to move to wishlist would go here
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey, width: 1))
                    ),
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      'MOVE TO WISHLIST',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.textGrey,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. ACTION & PRICE (Right)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Cross Button (Remove)
              GestureDetector(
                onTap: onRemove,
                child: const Icon(Icons.close, size: 18, color: Color(0xFFC9A761)), // Gold/Brownish color from UI
              ),
              // Price
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  price,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}