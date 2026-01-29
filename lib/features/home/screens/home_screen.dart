import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/catalog/screens/catalog_screen.dart';
import 'package:mindlabz/features/home/screens/the_child_view.dart';
import 'package:mindlabz/features/home/screens/the_women_view.dart';
import 'package:mindlabz/features/home/widgets/footer_section.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';
import 'package:mindlabz/features/product/screens/product_detail_screen.dart';
import 'package:mindlabz/features/wishlist/screens/wishlist_screen.dart';
import 'package:mindlabz/features/search/screens/search_screen.dart';
import 'package:mindlabz/features/profile/screens/profile_screen.dart'; // <--- NEW IMPORT

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Navigation State
  int _bottomNavIndex = 0; // 0=Home, 1=Catalog, 2=Wishlist, 3=Profile
  int _homeTabIndex = 0;   // Controls Home Tabs (Home/Women/Child)

  @override
  Widget build(BuildContext context) {
    // --- CATALOG VIEW (Index 1) ---
    if (_bottomNavIndex == 1) {
      return Scaffold(
        body: const CatalogScreen(initialIndex: 0),
        bottomNavigationBar: _buildBottomNavBar(),
      );
    }

    // --- WISHLIST VIEW (Index 2) ---
    if (_bottomNavIndex == 2) {
      return Scaffold(
        body: const WishlistScreen(),
        bottomNavigationBar: _buildBottomNavBar(),
      );
    }

    // --- PROFILE VIEW (Index 3) --- (UPDATED)
    if (_bottomNavIndex == 3) {
      return Scaffold(
        body: const ProfileScreen(), // <--- Shows Profile Screen
        bottomNavigationBar: _buildBottomNavBar(),
      );
    }

    // --- HOME VIEW (Index 0) ---
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,

      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
        title: Text(
          'Mindlabs',
          style: GoogleFonts.playfairDisplay(
            color: AppPallete.black,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.search, color: AppPallete.black),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  _bottomNavIndex = 2; // Switch to Wishlist Tab
                });
              },
              icon: const Icon(Icons.shopping_bag_outlined, color: AppPallete.black)
          ),
          const SizedBox(width: 10),
        ],
        // --- TAB BAR ---
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildHomeTabItem('THE HOME', 0),
                _buildHomeTabItem('THE WOMEN', 1),
                _buildHomeTabItem('THE CHILD', 2),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: _buildBottomNavBar(),
      body: _buildHomeBody(),
    );
  }

  // --- WIDGETS ---

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: _bottomNavIndex,
      onTap: (index) => setState(() => _bottomNavIndex = index),
      selectedItemColor: AppPallete.black,
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
    );
  }

  Widget _buildHomeBody() {
    if (_homeTabIndex == 1) return const TheWomenView();
    if (_homeTabIndex == 2) return const TheChildView();
    return _buildOriginalHomeContent();
  }

  Widget _buildHomeTabItem(String title, int index) {
    bool isActive = _homeTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _homeTabIndex = index;
        });
      },
      child: Container(
        decoration: isActive
            ? const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 2)))
            : null,
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.black : Colors.grey.shade400,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildOriginalHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero
          Stack(
            children: [
              Container(
                height: 500,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=2070&auto=format&fit=crop'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
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

          // Essentials
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'The Essentials',
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
                        builder: (context) => const CatalogScreen(initialIndex: 0),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                _buildEssentialItem('Dress', 'https://cdn-icons-png.flaticon.com/128/2784/2784403.png'),
                _buildEssentialItem('Shoes', 'https://cdn-icons-png.flaticon.com/128/5499/5499242.png'),
                _buildEssentialItem('Ring', 'https://cdn-icons-png.flaticon.com/128/3616/3616578.png'),
                _buildEssentialItem('Necklace', 'https://cdn-icons-png.flaticon.com/128/9953/9953538.png'),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Recommended
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Icon(Icons.filter_list, size: 20),
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
                ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Cozy Knit Sweater', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?q=80&w=1964&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Urban Hoodie', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=1920&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Classic White Set', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1589810635657-232948472d98?q=80&w=1964&auto=format&fit=crop'),
                ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Streetwear Tee', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1503342394128-c104d54dba01?q=80&w=1974&auto=format&fit=crop'),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // Footer
          const FooterSection(),
        ],
      ),
    );
  }

  Widget _buildEssentialItem(String name, String iconUrl) {
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