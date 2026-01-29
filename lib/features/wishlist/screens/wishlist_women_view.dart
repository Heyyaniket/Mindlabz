import 'package:flutter/material.dart';
import 'package:mindlabz/features/home/widgets/product_card.dart';

class WishlistWomenView extends StatelessWidget {
  const WishlistWomenView({super.key});

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
          ProductCard(tag: 'HOT', brand: 'BRAND', name: 'Purple Wrap Top', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1496747611176-843222e1e57c?q=80&w=2073&auto=format&fit=crop'),
          ProductCard(tag: 'NEW', brand: 'BRAND', name: 'Beige Knit', price: '\$500.00', imageUrl: 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?q=80&w=1964&auto=format&fit=crop'),
        ],
      ),
    );
  }
}