import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/features/catalog/widgets/category_circle.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';

class BrowseWomenView extends StatelessWidget {
  const BrowseWomenView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          // 1. CIRCULAR CATEGORY GRID
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 15,
              runSpacing: 25,
              alignment: WrapAlignment.spaceBetween,
              children: [
                CategoryCircle(name: 'DRESS', imageUrl: 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?q=80&w=1966&auto=format&fit=crop'),
                CategoryCircle(name: 'GOWN', imageUrl: 'https://images.unsplash.com/photo-1566174053879-31528523f8ae?q=80&w=1924&auto=format&fit=crop'),
                CategoryCircle(name: 'MAXI', imageUrl: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?q=80&w=1888&auto=format&fit=crop'),
                CategoryCircle(name: 'SETS', imageUrl: 'https://images.unsplash.com/photo-1550614000-4b9519e02a48?q=80&w=1887&auto=format&fit=crop'),
                CategoryCircle(name: 'BLACK', imageUrl: 'https://images.unsplash.com/photo-1539008835657-9e8e9680c956?q=80&w=1887&auto=format&fit=crop'),
                CategoryCircle(name: 'HEELS', imageUrl: 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?q=80&w=2080&auto=format&fit=crop'),
                CategoryCircle(name: 'JEWELRY', imageUrl: 'https://images.unsplash.com/photo-1599643478518-17488fbbcd75?q=80&w=1887&auto=format&fit=crop'),
                CategoryCircle(name: 'WATCH', imageUrl: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?q=80&w=1999&auto=format&fit=crop'),
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

          // 3. PRODUCT GRID
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
                ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Blue Ethnic Tunic', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1617019114583-affb34d1b3cd?q=80&w=1974&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Beige Knit Top', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?q=80&w=1964&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Black Oversize', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=1920&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Linen Shirt', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?q=80&w=1888&auto=format&fit=crop'),
                ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Checkered Dress', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1589810635657-232948472d98?q=80&w=1964&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Creator Hoodie', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1503342394128-c104d54dba01?q=80&w=1974&auto=format&fit=crop'),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}