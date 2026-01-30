import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/features/catalog/widgets/category_circle.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';

class BrowseOthersView extends StatelessWidget {
  const BrowseOthersView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          // 1. CIRCULAR CATEGORY GRID (Accessories & Lifestyle)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 15,
              runSpacing: 25,
              alignment: WrapAlignment.spaceBetween,
              children: [
                CategoryCircle(name: 'DRESSES', imageUrl: 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?q=80&w=1966&auto=format&fit=crop'),
                CategoryCircle(name: 'WATCHES', imageUrl: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?q=80&w=1999&auto=format&fit=crop'),
                CategoryCircle(name: 'SHOES', imageUrl: 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?q=80&w=2080&auto=format&fit=crop'),
                CategoryCircle(name: 'RINGS', imageUrl: 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=2070&auto=format&fit=crop'),
                CategoryCircle(name: 'JEWELRY', imageUrl: 'https://images.unsplash.com/photo-1599643478518-17488fbbcd75?q=80&w=1887&auto=format&fit=crop'),
                CategoryCircle(name: 'MEN', imageUrl: 'https://images.unsplash.com/photo-1617137984095-74e4e5e3613f?q=80&w=1887&auto=format&fit=crop'),
                CategoryCircle(name: 'HEELS', imageUrl: 'https://images.unsplash.com/photo-1560343090-f0409e92791a?q=80&w=1964&auto=format&fit=crop'),
                CategoryCircle(name: 'BAGS', imageUrl: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=1935&auto=format&fit=crop'),
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

          // 3. PRODUCT GRID (Accessories)
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
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Beige Moon Bag', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1598532163257-ae3c6b2524b6?q=80&w=1963&auto=format&fit=crop'),
                ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Classic Chrono', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?q=80&w=1894&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Tan Leather Derby', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1614252369475-531eba835eb1?q=80&w=1915&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Structured Tote', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?q=80&w=1938&auto=format&fit=crop'),
                ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Solitaire Ring', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=2070&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Diamond Oval', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1599643478518-17488fbbcd75?q=80&w=1887&auto=format&fit=crop'),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}