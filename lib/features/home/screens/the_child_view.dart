import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/catalog/screens/catalog_screen.dart';
import 'package:mindlabz/features/home/widgets/footer_section.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';
import 'package:mindlabz/features/product/screens/product_detail_screen.dart';

class TheChildView extends StatelessWidget {
  const TheChildView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. HERO SECTION
          Stack(
            children: [
              Container(
                height: 500,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('[https://images.unsplash.com/photo-1621452773781-0f992ee61c67?q=80&w=1974&auto=format&fit=crop](https://images.unsplash.com/photo-1621452773781-0f992ee61c67?q=80&w=1974&auto=format&fit=crop)'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EDITORIAL COLLECTION',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'New\nCollection',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 42,
                        fontStyle: FontStyle.italic,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppPallete.black,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: Text(
                        'VIEW LOGBOOK',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 40),

          // 2. LIMITED EDITION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LIMITED EDITION',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFC9A761), // Gold color
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      color: AppPallete.black,
                    ),
                    children: const [
                      TextSpan(text: 'Festive '),
                      TextSpan(text: 'Special', style: TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Horizontal Scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                _buildFestiveCard(
                  '[https://images.unsplash.com/photo-1519457431-44ccd64a579b?q=80&w=1935&auto=format&fit=crop](https://images.unsplash.com/photo-1519457431-44ccd64a579b?q=80&w=1935&auto=format&fit=crop)',
                  'The Gen-Z Collection',
                  'LUX KIDS EDITION',
                ),
                _buildFestiveCard(
                  '[https://images.unsplash.com/photo-1514090458221-65bb69cf63e6?q=80&w=1887&auto=format&fit=crop](https://images.unsplash.com/photo-1514090458221-65bb69cf63e6?q=80&w=1887&auto=format&fit=crop)',
                  'Mini Royals',
                  'PARTY EDITION',
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          // 3. CATEGORIES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CatalogScreen(initialIndex: 1),
                      ),
                    );
                  },
                  child: Text(
                    'DISCOVER ALL',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFC9A761),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFFC9A761),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Categories Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                _buildCategoryItem('Sneakers', '[https://cdn-icons-png.flaticon.com/128/5499/5499242.png](https://cdn-icons-png.flaticon.com/128/5499/5499242.png)'),
                _buildCategoryItem('Necklace', '[https://cdn-icons-png.flaticon.com/128/3616/3616578.png](https://cdn-icons-png.flaticon.com/128/3616/3616578.png)'),
                _buildCategoryItem('Outfits', '[https://cdn-icons-png.flaticon.com/128/2784/2784403.png](https://cdn-icons-png.flaticon.com/128/2784/2784403.png)'),
                _buildCategoryItem('Accs', '[https://cdn-icons-png.flaticon.com/128/5900/5900292.png](https://cdn-icons-png.flaticon.com/128/5900/5900292.png)'),
              ],
            ),
          ),

          const SizedBox(height: 50),

          // 4. TRENDING
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TRENDING',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CatalogScreen(initialIndex: 1),
                      ),
                    );
                  },
                  child: Text(
                    'VIEW ALL',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Grid
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
                ProductCard(
                  tag: 'NEW',
                  brand: 'BRAND',
                  name: 'Striped Shirt',
                  price: '\$500.00',
                  imageUrl: '[https://images.unsplash.com/photo-1519238263496-6361937a2717?q=80&w=1887&auto=format&fit=crop](https://images.unsplash.com/photo-1519238263496-6361937a2717?q=80&w=1887&auto=format&fit=crop)',
                ),
                ProductCard(
                  tag: 'HOT',
                  brand: 'BRAND',
                  name: 'Puffer Jacket',
                  price: '\$500.00',
                  imageUrl: '[https://images.unsplash.com/photo-1503919545885-d94bb85506a7?q=80&w=1887&auto=format&fit=crop](https://images.unsplash.com/photo-1503919545885-d94bb85506a7?q=80&w=1887&auto=format&fit=crop)',
                ),
                ProductCard(
                  tag: 'NEW',
                  brand: 'BRAND',
                  name: 'Casual Hoodie',
                  price: '\$500.00',
                  imageUrl: '[https://images.unsplash.com/photo-1519457431-44ccd64a579b?q=80&w=1935&auto=format&fit=crop](https://images.unsplash.com/photo-1519457431-44ccd64a579b?q=80&w=1935&auto=format&fit=crop)',
                ),
                ProductCard(
                  tag: 'NEW',
                  brand: 'BRAND',
                  name: 'Summer Set',
                  price: '\$500.00',
                  imageUrl: '[https://images.unsplash.com/photo-1522771930-78848d9293e8?q=80&w=1935&auto=format&fit=crop](https://images.unsplash.com/photo-1522771930-78848d9293e8?q=80&w=1935&auto=format&fit=crop)',
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // 5. FOOTER
          const FooterSection(),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildFestiveCard(String imageUrl, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            height: 320,
            width: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String name, String iconUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
            ),
            padding: const EdgeInsets.all(18),
            child: Image.network(iconUrl, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Text(
            name.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppPallete.textGrey,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}