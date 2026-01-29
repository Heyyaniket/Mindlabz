import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/catalog/screens/browse_child_view.dart';
import 'package:mindlabz/features/catalog/screens/browse_others_view.dart';
import 'package:mindlabz/features/catalog/screens/browse_women_view.dart';
import 'package:mindlabz/features/wishlist/screens/wishlist_screen.dart';
import 'package:mindlabz/features/search/screens/search_screen.dart'; // <--- NEW IMPORT

class CatalogScreen extends StatefulWidget {
  final int initialIndex;
  const CatalogScreen({super.key, this.initialIndex = 0});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
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
        actions: [
          // --- SEARCH ICON (NAVIGATES TO SEARCH SCREEN) ---
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              icon: const Icon(Icons.search, color: AppPallete.black)
          ),
          // --- CART/BAG ICON REDIRECT ---
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WishlistScreen()),
                );
              },
              icon: const Icon(Icons.shopping_bag_outlined, color: AppPallete.black)
          ),
          const SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTopTab('THE WOMEN', 0),
                  _buildTopTab('THE CHILD', 1),
                  _buildTopTab('THE OTHERS', 2),
                ],
              ),
              const Divider(height: 1, color: Color(0xFFE0E0E0)),
            ],
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_selectedTab == 0) {
      return const BrowseWomenView();
    } else if (_selectedTab == 1) {
      return const BrowseChildView();
    } else {
      return const BrowseOthersView();
    }
  }

  Widget _buildTopTab(String title, int index) {
    bool isActive = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: isActive
            ? const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 2)))
            : null,
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
}