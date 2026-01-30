import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/cart/widgets/cart_item_card.dart';
import 'package:mindlabz/features/catalog/screens/catalog_screen.dart';
import 'package:mindlabz/features/checkout/screens/checkout_screen.dart';
import 'package:mindlabz/features/home/screens/home_screen.dart';
import 'package:mindlabz/features/profile/screens/profile_screen.dart';
import 'package:mindlabz/features/wishlist/screens/wishlist_screen.dart'; // <--- NEW IMPORT

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartManager _cartManager = CartManager();
  List<Map<String, String>>? get cartItems => _cartManager.items;

  void _removeItem(int index) {
    setState(() {
      _cartManager.removeItem(index);
    });
  }

  int _getQty(Map<String, String> item) {
    return int.tryParse(item['quantity'] ?? '1') ?? 1;
  }

  double _parsePrice(String? raw) {
    if (raw == null) return 0.0;
    final cleaned = raw.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  double _calculateTotal() {
    if (cartItems == null || cartItems!.isEmpty) return 0.0;
    double total = 0.0;
    for (final item in cartItems!) {
      final price = _parsePrice(item['price']);
      final qty = _getQty(item);
      total += price * qty;
    }
    return total;
  }

  void _incrementQty(int index) {
    setState(() {
      if (cartItems == null) return;
      final item = cartItems![index];
      final qty = _getQty(item) + 1;
      item['quantity'] = qty.toString();
    });
  }

  void _decrementQty(int index) {
    setState(() {
      if (cartItems == null) return;
      final item = cartItems![index];
      final qty = _getQty(item) - 1;
      item['quantity'] = (qty < 1 ? 1 : qty).toString();
    });
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 14, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Your Bag!',
          style: GoogleFonts.playfairDisplay(
            color: AppPallete.black,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),

      // --- BODY ---
      body: Column(
        children: [
          const SizedBox(height: 30),
          // 1. CART ITEMS LIST
          
          Expanded(
            child: cartItems == null || cartItems!.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 80,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Your cart is empty',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Add items to get started',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: cartItems!.length,
                    itemBuilder: (context, index) {
                      final item = cartItems![index];
                      final qty = _getQty(item);

                      return Stack(
                        children: [
                          CartItemCard(
                            imageUrl: item['image']!,
                            name: item['name']!,
                            brand: item['brand']!,
                            size: item['size']!,
                            price: item['price']!,
                            onRemove: () => _removeItem(index),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(231, 82, 80, 80)
                                        .withAlpha(15),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _qtyButton(
                                    icon: Icons.remove,
                                    onTap: () => _decrementQty(index),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '$qty',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  _qtyButton(
                                    icon: Icons.add,
                                    onTap: () => _incrementQty(index),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),

          // 2. TOTALS & CHECKOUT SECTION
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
            ),
            child: Column(
              children: [
                // Subtotal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SUBTOTAL',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      '\$${_calculateTotal().toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.black,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(color: Color(0xFFE0E0E0)),
                const SizedBox(height: 15),

                // Shipping
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SHIPPING',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'COMPLIMENTARY',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFC9A761), // Gold Color
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // CHECKOUT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Checkout Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckoutScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPallete.black,
                      foregroundColor: AppPallete.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'PROCEED TO CHECKOUT',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // --- BOTTOM NAV ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Cart tab selected
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade400,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
         onTap: (index) {
    if (index == 2) return; // already on cart
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
    BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Cart'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
  ],
),
    );
  }
}

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<Map<String, String>> _items = [];

  List<Map<String, String>> get items => _items;

  void addItem(Map<String, String> item) {
    _items.add(item);
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }

  bool get isEmpty => _items.isEmpty;
}
