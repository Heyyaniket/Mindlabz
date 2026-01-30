import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
// import 'package:mindlabz/features/cart/screens/cart_screen.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        centerTitle: false, // Left aligned as per design might look better centered, but let's stick to standard
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: AppPallete.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag_outlined, color: AppPallete.black)),
          const SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabItem('THE HOME', isActive: true),
                _buildTabItem('THE WOMEN'),
                _buildTabItem('THE CHILD'),
              ],
            ),
          ),
        ),
      ),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppPallete.white,
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
      ),

      // --- BODY CONTENT ---
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 1. HERO SECTION (Editorial Collection)
            Stack(
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      // Placeholder fashion image
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPallete.white,
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

            // 2. THE ESSENTIALS
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
                  Text(
                    'DISCOVER ALL',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFC9A761),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFFC9A761),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Horizontal Scroll for Essentials
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

            // 3. RECOMMENDED SECTION
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

            // 4. PRODUCT GRID
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Important inside SingleChildScrollView
                crossAxisCount: 2,
                childAspectRatio: 0.55, // Adjust this to make cards taller/shorter
                crossAxisSpacing: 15,
                mainAxisSpacing: 30,
                children: const [
                  ProductCard(
                    tag: 'HOT',
                    brand: 'BRAND',
                    name: 'Cozy Knit Sweater',
                    price: '\$500.00',
                    imageUrl: 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?q=80&w=1964&auto=format&fit=crop',
                  ),
                  ProductCard(
                    tag: 'NEW',
                    brand: 'BRAND',
                    name: 'Urban Hoodie',
                    price: '\$500.00',
                    imageUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=1920&auto=format&fit=crop',
                  ),
                  ProductCard(
                    tag: 'NEW',
                    brand: 'BRAND',
                    name: 'Classic White Set',
                    price: '\$500.00',
                    imageUrl: 'https://images.unsplash.com/photo-1589810635657-232948472d98?q=80&w=1964&auto=format&fit=crop',
                  ),
                  ProductCard(
                    tag: 'NEW',
                    brand: 'BRAND',
                    name: 'Streetwear Tee',
                    price: '\$500.00',
                    imageUrl: 'https://images.unsplash.com/photo-1503342394128-c104d54dba01?q=80&w=1974&auto=format&fit=crop',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // 5. FOOTER (Join The Cult)
            Container(
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
              child: Column(
                children: [
                  Text(
                    'Join The Cult!',
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 32,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Weekly insights on luxury parenting, fashion, and lifestyle delivered to your space.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Email Input
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'EMAIL ADDRESS',
                              hintStyle: GoogleFonts.inter(
                                color: Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        const Icon(Icons.mail_outline, color: Colors.white54, size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildTabItem(String title, {bool isActive = false}) {
    return Container(
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
            child: Image.network(iconUrl, color: Colors.black87), // Simple icon
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