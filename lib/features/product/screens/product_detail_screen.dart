import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/cart/screens/cart_screen.dart';
import 'package:mindlabz/features/catalog/screens/catalog_screen.dart'; // <--- NEW IMPORT for Navigation
import 'package:mindlabz/features/home/screens/home_screen.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';
import 'package:mindlabz/features/profile/screens/profile_screen.dart';
import 'package:mindlabz/features/wishlist/screens/wishlist_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // State for selections
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 1; // Default to 'M'

  final List<Color> _colors = [
    const Color(0xFFD4AF37), // Gold/Mustard
    Colors.black,
    const Color(0xFFF0E0D0), // Beige/Pinkish
    const Color(0xFF1B4D3E), // Deep Green
  ];

  final List<String> _sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HERO IMAGE SECTION
            Stack(
              children: [
                Container(
                  height: 550, // Tall hero image
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      // Using the kid image from your screenshot
                      image: NetworkImage('https://images.unsplash.com/photo-1519238263496-6361937a2717?q=80&w=1887&auto=format&fit=crop'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                // Custom Back Button
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
                    ),
                  ),
                ),
                // Heart Button
                const Positioned(
                  top: 50,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(Icons.favorite, size: 20, color: Color(0xFFFBB000)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 2. PRODUCT INFO HEADER
            Text(
              'SOME COLLECTION NAME',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFC9A761),
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Product Name',
              style: GoogleFonts.playfairDisplay(
                fontSize: 36,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$500',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 40),

            // 3. COLOR SELECTOR
            Text(
              'SELECT COLORS',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade400,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_colors.length, (index) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedColorIndex = index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(2), // Gap for ring
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: _selectedColorIndex == index
                          ? Border.all(color: Colors.black, width: 1)
                          : null,
                    ),
                    child: CircleAvatar(
                      backgroundColor: _colors[index],
                      radius: 14,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),

            // 4. SIZE SELECTOR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SELECT SIZE',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade400,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'SIZE GUIDE',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_sizes.length, (index) {
                  bool isSelected = _selectedSizeIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedSizeIndex = index),
                    child: Container(
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.transparent,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Center(
                        child: Text(
                          _sizes[index],
                          style: GoogleFonts.inter(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 40),

            // 5. ADD TO CART BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                 onPressed: () {
    final item = {
      'name': 'Product Name',
      'brand': 'SOME COLLECTION NAME',
      'size': _sizes[_selectedSizeIndex],
      'price': '\$500',
      'image': 'https://images.unsplash.com/photo-1519238263496-6361937a2717?q=80&w=1887&auto=format&fit=crop',
    };

    CartManager().addItem(item);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart')),
    );
  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFC9A761)),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text(
                    'ADD TO CART',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFC9A761),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
            const Divider(height: 1),

            // 6. EXPANDABLE PANELS
            _buildInfoTile('Description', 'Some random description of of the product\nSome random description of of the product'),
            const Divider(height: 1),
            _buildInfoTile('Material', '100% Cotton, Premium quality fabric.'),
            const Divider(height: 1),
            _buildInfoTile('Delivery', 'Free shipping on orders over \$200.\nEstimated delivery: 3-5 business days.'),
            const Divider(height: 1),

            const SizedBox(height: 60),

            // 7. SIMILAR ITEMS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Similar Items',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // --- LINKED "VIEW ALL" ---
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CatalogScreen()),
                      );
                    },
                    child: Text(
                      'VIEW ALL',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Similar Items Grid
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
                  ProductCard(tag: '', brand: 'NAME', name: '\$500', price: '', imageUrl: 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?q=80&w=1935&auto=format&fit=crop'),
                  ProductCard(tag: '', brand: 'NAME', name: '\$500', price: '', imageUrl: 'https://images.unsplash.com/photo-1522771930-78848d9293e8?q=80&w=1935&auto=format&fit=crop'),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 8. CURRENT TREND
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Trend',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // --- LINKED "VIEW ALL" ---
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CatalogScreen()),
                      );
                    },
                    child: Text(
                      'VIEW ALL',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Current Trend Grid
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
                  ProductCard(tag: '', brand: 'NAME', name: '\$500', price: '', imageUrl: 'https://images.unsplash.com/photo-1530283084557-0db7054f9d0c?q=80&w=2070&auto=format&fit=crop'),
                  ProductCard(tag: '', brand: 'NAME', name: '\$500', price: '', imageUrl: 'https://images.unsplash.com/photo-1518831959646-742c3a14ebf7?q=80&w=1915&auto=format&fit=crop'),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
     // --- FUNCTIONAL BOTTOM NAV ---
bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.white,
  selectedItemColor: Colors.black,
  unselectedItemColor: Colors.grey.shade400,
  showSelectedLabels: false,
  showUnselectedLabels: false,
  type: BottomNavigationBarType.fixed,
  onTap: (index) {
    final pages = [
      const HomeScreen(),
      const CatalogScreen(),
      const CartScreen(),
      const WishlistScreen(),
      const ProfileScreen(),
    ];
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => pages[index]),
    );
  },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Catalog'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  // --- HELPER FOR EXPANDABLE PANELS ---
  Widget _buildInfoTile(String title, String content) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        title: Text(
          title,
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFFC9A761)),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: Text(
              content,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey.shade500,
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}