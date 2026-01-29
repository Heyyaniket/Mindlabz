import 'package:flutter/material.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';

class WishlistOthersView extends StatelessWidget {
  const WishlistOthersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.55,
        crossAxisSpacing: 15,
        mainAxisSpacing: 30,
        children: const [
          ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Beige Moon Bag', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1598532163257-ae3c6b2524b6?q=80&w=1963&auto=format&fit=crop'),
          ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Classic Watch', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?q=80&w=1894&auto=format&fit=crop'),
        ],
      ),
    );
  }
}