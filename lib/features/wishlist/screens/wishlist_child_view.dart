import 'package:flutter/material.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';

class WishlistChildView extends StatelessWidget {
  const WishlistChildView({super.key});

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
          ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Vintage Suspender', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1519238263496-6361937a2717?q=80&w=1887&auto=format&fit=crop'),
          ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Striped Shirt', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?q=80&w=1935&auto=format&fit=crop'),
        ],
      ),
    );
  }
}