import 'package:flutter/material.dart';
import '../../widgets/dashboard/dashboard_layout.dart';
import '../../widgets/dashboard/dashboard_card.dart';
import 'super_admin_sellers_screen.dart';
import 'super_admin_commissions_screen.dart';
import 'super_admin_analytics_screen.dart';

class SuperAdminDashboardScreen extends StatefulWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  State<SuperAdminDashboardScreen> createState() =>
      _SuperAdminDashboardScreenState();
}

class _SuperAdminDashboardScreenState extends State<SuperAdminDashboardScreen> {
  Widget _currentScreen = const SuperAdminDashboardHome();

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Super Admin Dashboard',
      menuItems: [
        DashboardMenuItem(
          title: 'Dashboard',
          icon: Icons.dashboard,
          onTap: () {
            setState(() {
              _currentScreen = const SuperAdminDashboardHome();
            });
          },
        ),
        DashboardMenuItem(
          title: 'Analytics',
          icon: Icons.analytics,
          onTap: () {
            setState(() {
              _currentScreen = const SuperAdminAnalyticsScreen();
            });
          },
        ),
        DashboardMenuItem(
          title: 'Seller Management',
          icon: Icons.store,
          onTap: () {
            setState(() {
              _currentScreen = const SuperAdminSellersScreen();
            });
          },
        ),
        DashboardMenuItem(
          title: 'Commissions',
          icon: Icons.account_balance,
          onTap: () {
            setState(() {
              _currentScreen = const SuperAdminCommissionsScreen();
            });
          },
        ),
      ],
      body: _currentScreen,
    );
  }
}

class SuperAdminDashboardHome extends StatelessWidget {
  const SuperAdminDashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Platform Overview',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete platform governance and analytics.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),

          // Revenue Cards
          Row(
            children: [
              Expanded(
                child: DashboardCard(
                  title: 'Total Revenue',
                  value: '\$125,430',
                  icon: Icons.attach_money,
                  color: Colors.green,
                  subtitle: 'This month: +15%',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardCard(
                  title: 'Commission Earned',
                  value: '\$8,750',
                  icon: Icons.account_balance_wallet,
                  color: Colors.blue,
                  subtitle: 'Average: 7%',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

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
                    title: 'Active Sellers',
                    value: '42',
                    icon: Icons.store,
                    color: Colors.orange,
                    subtitle: 'Total: 58',
                  ),
                  DashboardCard(
                    title: 'Total Products',
                    value: '1,234',
                    icon: Icons.inventory,
                    color: Colors.purple,
                    subtitle: 'Approved: 1,180',
                  ),
                  DashboardCard(
                    title: 'Total Orders',
                    value: '3,456',
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                    subtitle: 'This month: 432',
                  ),
                  DashboardCard(
                    title: 'Active Users',
                    value: '8,910',
                    icon: Icons.people,
                    color: Colors.teal,
                    subtitle: 'Growth: +12%',
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 32),

          // Revenue Chart
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
                        'Revenue Overview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: 'Last 6 Months',
                        items: const [
                          DropdownMenuItem(
                              value: 'Last 7 Days', child: Text('Last 7 Days')),
                          DropdownMenuItem(
                              value: 'Last 30 Days', child: Text('Last 30 Days')),
                          DropdownMenuItem(
                              value: 'Last 6 Months',
                              child: Text('Last 6 Months')),
                          DropdownMenuItem(
                              value: 'Last Year', child: Text('Last Year')),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Revenue Chart\n(Integration with fl_chart recommended)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Top Performing Sellers
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Top Performing Sellers',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildTopSellerItem(
                            'Fashion Hub', '\$45,230', Colors.amber),
                        _buildTopSellerItem(
                            'Kids Paradise', '\$38,910', Colors.grey),
                        _buildTopSellerItem(
                            'Style Avenue', '\$32,440', Colors.orangeAccent),
                        _buildTopSellerItem(
                            'Trend Setters', '\$28,120', Colors.blueGrey),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Category Performance',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildCategoryItem('Women', 42, Colors.pink),
                        _buildCategoryItem('Men', 35, Colors.blue),
                        _buildCategoryItem('Kids', 23, Colors.orange),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Recent Activity
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildActivityItem(
                    'New seller registration',
                    'Fashion Trends',
                    '2 hours ago',
                    Icons.store,
                    Colors.blue,
                  ),
                  _buildActivityItem(
                    'Commission rate updated',
                    'Women category: 5% → 6%',
                    '5 hours ago',
                    Icons.trending_up,
                    Colors.orange,
                  ),
                  _buildActivityItem(
                    'Seller approved',
                    'Kids Corner',
                    '1 day ago',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSellerItem(String name, String revenue, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(red: 255, green: 255, blue: 255, alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.store, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  revenue,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String name, int percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade200,
              color: color,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String subtitle,
    String time,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(red: 255, green: 255, blue: 255, alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
