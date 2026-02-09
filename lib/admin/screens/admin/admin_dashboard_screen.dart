import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/dashboard/dashboard_layout.dart';
import '../../widgets/dashboard/dashboard_card.dart';
import 'admin_product_approval_screen.dart';
import 'admin_banners_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  Widget _currentScreen = const AdminDashboardHome();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    context.read<ProductProvider>().loadPendingProducts();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Admin Dashboard',
      menuItems: [
        DashboardMenuItem(
          title: 'Dashboard',
          icon: Icons.dashboard,
          onTap: () {
            setState(() {
              _currentScreen = const AdminDashboardHome();
            });
          },
        ),
        DashboardMenuItem(
          title: 'Product Approval',
          icon: Icons.approval,
          onTap: () {
            setState(() {
              _currentScreen = const AdminProductApprovalScreen();
            });
          },
        ),
        DashboardMenuItem(
          title: 'Banner Management',
          icon: Icons.image,
          onTap: () {
            setState(() {
              _currentScreen = const AdminBannersScreen();
            });
          },
        ),
      ],
      body: _currentScreen,
    );
  }
}

class AdminDashboardHome extends StatelessWidget {
  const AdminDashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final pendingProducts = productProvider.pendingProducts.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Dashboard',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage platform operations and content.',
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
                    title: 'Pending Approvals',
                    value: pendingProducts.toString(),
                    icon: Icons.pending_actions,
                    color: Colors.orange,
                    subtitle: 'Products awaiting review',
                  ),
                  DashboardCard(
                    title: 'Active Sellers',
                    value: '42',
                    icon: Icons.store,
                    color: Colors.blue,
                    subtitle: 'Approved sellers',
                  ),
                  DashboardCard(
                    title: 'Total Products',
                    value: '1,234',
                    icon: Icons.inventory,
                    color: Colors.green,
                    subtitle: 'Live on platform',
                  ),
                  DashboardCard(
                    title: 'Active Banners',
                    value: '8',
                    icon: Icons.image,
                    color: Colors.purple,
                    subtitle: 'Currently displaying',
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 32),

          // Pending Products Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.pending_actions, color: Colors.orange.shade700),
                          const SizedBox(width: 8),
                          const Text(
                            'Pending Product Approvals',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to approval screen
                        },
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (productProvider.pendingProducts.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text('No pending products'),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productProvider.pendingProducts.take(5).length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final product = productProvider.pendingProducts[index];
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
                          subtitle: Text('By: ${product.sellerName}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.check_circle, color: Colors.green),
                                onPressed: () {
                                  // Approve product
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.cancel, color: Colors.red),
                                onPressed: () {
                                  // Reject product
                                },
                              ),
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

          // Quick Actions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildQuickActionButton(
                        'Create Banner',
                        Icons.add_photo_alternate,
                        Colors.purple,
                        () {},
                      ),
                      _buildQuickActionButton(
                        'Schedule Sale',
                        Icons.local_offer,
                        Colors.red,
                        () {},
                      ),
                      _buildQuickActionButton(
                        'View Reports',
                        Icons.analytics,
                        Colors.blue,
                        () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      ),
    );
  }
}
