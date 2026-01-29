import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/catalog/widgets/category_circle.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,

      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mindlabs',
          style: GoogleFonts.playfairDisplay(
            color: AppPallete.black,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: AppPallete.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag_outlined, color: AppPallete.black)),
          const SizedBox(width: 10),
        ],
      ),

      // --- BODY ---
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // 1. FILTER CHIPS
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildFilterChip('NEW IN'),
                  const SizedBox(width: 10),
                  _buildFilterChip('NEW IN'),
                  const SizedBox(width: 10),
                  _buildFilterChip('OFFERS'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 2. CATEGORIES HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Categories',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. CATEGORIES LIST
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  CategoryCircle(name: 'NAME', imageUrl: 'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?q=80&w=1894&auto=format&fit=crop'),
                  SizedBox(width: 20),
                  CategoryCircle(name: 'NAME', imageUrl: 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?q=80&w=2080&auto=format&fit=crop'),
                  SizedBox(width: 20),
                  CategoryCircle(name: 'NAME', imageUrl: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=1935&auto=format&fit=crop'),
                  SizedBox(width: 20),
                  CategoryCircle(name: 'NAME', imageUrl: 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?q=80&w=1966&auto=format&fit=crop'),
                  SizedBox(width: 20),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4. PRODUCT GRID
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
                  ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Girl Dress', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1621452773781-0f992ee61c67?q=80&w=1974&auto=format&fit=crop'),
                  ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Cozy Set', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?q=80&w=1935&auto=format&fit=crop'),
                  ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Vintage Look', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1519238263496-6361937a2717?q=80&w=1887&auto=format&fit=crop'),
                  ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Mens Watch', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?q=80&w=1894&auto=format&fit=crop'),
                  ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Purple Top', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?q=80&w=1966&auto=format&fit=crop'),
                  ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Creator Hoodie', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=1920&auto=format&fit=crop'),
                  ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Classic Heels', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?q=80&w=2080&auto=format&fit=crop'),
                  ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Puffer Jacket', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?q=80&w=1935&auto=format&fit=crop'),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      // --- VISUAL BOTTOM NAV ---
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade400,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Catalog'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: const Color(0xFFC9A761)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFC9A761),
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}