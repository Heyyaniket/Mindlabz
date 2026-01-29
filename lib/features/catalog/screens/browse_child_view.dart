import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/features/catalog/widgets/category_circle.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';

class BrowseChildView extends StatelessWidget {
  const BrowseChildView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          // 1. CIRCULAR CATEGORY GRID (Matched to Child UI Icons)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 15,
              runSpacing: 25,
              alignment: WrapAlignment.spaceBetween,
              children: const [
                CategoryCircle(name: 'ACCESSORIES', imageUrl: 'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?q=80&w=2070&auto=format&fit=crop'),
                CategoryCircle(name: 'SNEAKERS', imageUrl: 'https://images.unsplash.com/photo-1514989940723-e8a516350466?q=80&w=2070&auto=format&fit=crop'),
                CategoryCircle(name: 'BAGS', imageUrl: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=1935&auto=format&fit=crop'),
                CategoryCircle(name: 'SHOES', imageUrl: 'https://images.unsplash.com/photo-1507464098880-e367bc5d2c08?q=80&w=2070&auto=format&fit=crop'),
                CategoryCircle(name: 'APPAREL', imageUrl: 'https://images.unsplash.com/photo-1518831959646-742c3a14ebf7?q=80&w=1915&auto=format&fit=crop'),
                CategoryCircle(name: 'FORMAL', imageUrl: 'https://images.unsplash.com/photo-1449505278894-297fdb3edbc1?q=80&w=2070&auto=format&fit=crop'),
                CategoryCircle(name: 'DRESSES', imageUrl: 'https://images.unsplash.com/photo-1544642899-f0d6e5f6ed6f?q=80&w=1887&auto=format&fit=crop'),
                CategoryCircle(name: 'WATCHES', imageUrl: 'https://images.unsplash.com/photo-1509048191080-d2984bad6ae5?q=80&w=1965&auto=format&fit=crop'),
              ],
            ),
          ),

          const SizedBox(height: 50),

          // 2. TRENDING HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'TRENDING',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 3. PRODUCT GRID (Kids Fashion)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 15,
              mainAxisSpacing: 30,
              children: const [
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Party Set Duo', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1503919545885-d94bb85506a7?q=80&w=1887&auto=format&fit=crop'),
                ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Vintage Suit', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1519238263496-6361937a2717?q=80&w=1887&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Cozy Winter Set', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?q=80&w=1935&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Striped Shirt', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1621452773781-0f992ee61c67?q=80&w=1974&auto=format&fit=crop'),
                ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Playful Set', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1522771930-78848d9293e8?q=80&w=1935&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Winter Puffer', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1530283084557-0db7054f9d0c?q=80&w=2070&auto=format&fit=crop'),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}