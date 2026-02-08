import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/order_provider.dart';
import '../../widgets/dashboard/dashboard_layout.dart';
import '../../widgets/dashboard/dashboard_card.dart';
import 'seller_inventory_screen.dart';
import 'seller_orders_screen.dart';
import 'seller_settlements_screen.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  Widget _currentScreen = const SellerDashboardHome();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final authProvider = context.read<AuthProvider>();
    final sellerId = authProvider.currentUser?.uid;

    if (sellerId != null) {
      context.read<ProductProvider>().loadProductsBySeller(sellerId);
      context.read<OrderProvider>().loadOrdersBySeller(sellerId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    // Check if seller is approved
    if (authProvider.currentUser?.isApproved == false) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.pending, size: 64, color: Colors.orange.shade400),
              const SizedBox(height: 16),
              const Text(
                'Account Pending Approval',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Your seller account is under review.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => authProvider.signOut(),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      );
    }

    return DashboardLayout(
      title: 'Seller Dashboard',
      menuItems: [
        DashboardMenuItem(
          title: 'Dashboard',
          icon: Icons.dashboard,
          onTap: () {
            setState(() {
              _currentScreen = const SellerDashboardHome();
            });
          },
        ),
        DashboardMenuItem(
          title: 'Inventory',
          icon: Icons.inventory_2,
          onTap: () {
            setState(() {
              _currentScreen = const SellerInventoryScreen();
            });
          },
        ),
        DashboardMenuItem(
          title: 'Orders',
          icon: Icons.shopping_bag,
          onTap: () {
            setState(() {
              _currentScreen = const SellerOrdersScreen();
            });
          },
        ),
        DashboardMenuItem(
          title: 'Settlements',
          icon: Icons.payments,
          onTap: () {
            setState(() {
              _currentScreen = const SellerSettlementsScreen();
            });
          },
        ),
      ],
      body: _currentScreen,
    );
  }
}

class SellerDashboardHome extends StatelessWidget {
  const SellerDashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final orderProvider = context.watch<OrderProvider>();

    final totalProducts = productProvider.products.length;
    final lowStockProducts = productProvider.lowStockProducts.length;
    final newOrders = orderProvider.newOrders.length;
    final totalOrders = orderProvider.orders.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Message
          Text(
            'Welcome back!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Here\'s what\'s happening with your store today.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),

          // Stats Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1200
                  ? 4
                  : constraints.maxWidth > 800
                      ? 3
                      : constraints.maxWidth > 500
                          ? 2
                          : 1;

              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  DashboardCard(
                    title: 'Total Products',
                    value: totalProducts.toString(),
                    icon: Icons.inventory,
                    color: Colors.blue,
                    subtitle: 'Active listings',
                  ),
                  DashboardCard(
                    title: 'Low Stock Alert',
                    value: lowStockProducts.toString(),
                    icon: Icons.warning,
                    color: Colors.orange,
                    subtitle: 'Items need restock',
                  ),
                  DashboardCard(
                    title: 'New Orders',
                    value: newOrders.toString(),
                    icon: Icons.shopping_cart,
                    color: Colors.green,
                    subtitle: 'Ready to process',
                  ),
                  DashboardCard(
                    title: 'Total Orders',
                    value: totalOrders.toString(),
                    icon: Icons.shopping_bag,
                    color: Colors.purple,
                    subtitle: 'All time',
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 32),

          // Recent Orders Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (orderProvider.orders.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text('No orders yet'),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orderProvider.orders.take(5).length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final order = orderProvider.orders[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade50,
                            child: Icon(
                              Icons.shopping_bag,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          title: Text('Order #${order.id.substring(0, 8)}'),
                          subtitle: Text(order.customerName),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${order.total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              _buildStatusBadge(order.status),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Low Stock Products Section
          if (lowStockProducts > 0)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: Colors.orange.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'Low Stock Products',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productProvider.lowStockProducts.take(5).length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final product = productProvider.lowStockProducts[index];
                        return ListTile(
                          leading: product.imageUrls.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.imageUrls.first,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.image),
                                ),
                          title: Text(product.title),
                          subtitle: Text('SKU: ${product.sku}'),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${product.stockQuantity} left',
                              style: TextStyle(
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(dynamic status) {
    Color color;
    String text;

    switch (status.toString()) {
      case 'OrderStatus.newOrder':
        color = Colors.blue;
        text = 'New';
        break;
      case 'OrderStatus.readyToShip':
        color = Colors.orange;
        text = 'Ready';
        break;
      case 'OrderStatus.dispatched':
        color = Colors.purple;
        text = 'Dispatched';
        break;
      case 'OrderStatus.delivered':
        color = Colors.green;
        text = 'Delivered';
        break;
      default:
        color = Colors.grey;
        text = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(red: 255, green: 255, blue: 255, alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
