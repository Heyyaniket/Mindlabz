import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class DashboardLayout extends StatefulWidget {
  final String title;
  final List<DashboardMenuItem> menuItems;
  final Widget body;
  final Widget? floatingActionButton;

  const DashboardLayout({
    super.key,
    required this.title,
    required this.menuItems,
    required this.body,
    this.floatingActionButton,
  });

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  int _selectedIndex = 0;
  bool _isDrawerOpen = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 800;
        final isMobile = constraints.maxWidth < 600;

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            elevation: 0,
            leading: isWideScreen
                ? null
                : IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      if (isMobile) {
                        Scaffold.of(context).openDrawer();
                      } else {
                        setState(() {
                          _isDrawerOpen = !_isDrawerOpen;
                        });
                      }
                    },
                  ),
            actions: [
              // Notifications
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No new notifications'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              // Profile Menu
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return PopupMenuButton<String>(
                    icon: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        authProvider.currentUser?.fullName[0].toUpperCase() ?? 'U',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        enabled: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authProvider.currentUser?.fullName ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              authProvider.currentUser?.email ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: 'profile',
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 8),
                            Text('Profile'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'settings',
                        child: Row(
                          children: [
                            Icon(Icons.settings),
                            SizedBox(width: 8),
                            Text('Settings'),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: 'logout',
                        child: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Logout', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      switch (value) {
                        case 'logout':
                          context.read<AuthProvider>().signOut();
                          break;
                        case 'profile':
                          Navigator.pushNamed(context, '/profile');
                          break;
                        case 'settings':
                          Navigator.pushNamed(context, '/settings');
                          break;
                      }
                    },
                  );
                },
              ),
              const SizedBox(width: 16),
            ],
          ),
          drawer: isMobile
              ? _buildDrawer()
              : null,
          body: Row(
            children: [
              // Sidebar for desktop/tablet
              if (!isMobile && _isDrawerOpen)
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(red: 0, green: 0, blue: 0, alpha: 0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: _buildMenuList(),
                ),
              // Main Content
              Expanded(
                child: Container(
                  color: Colors.grey.shade50,
                  child: widget.body,
                ),
              ),
            ],
          ),
          floatingActionButton: widget.floatingActionButton,
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: _buildMenuList(),
    );
  }

  Widget _buildMenuList() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade500],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.dashboard,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ...widget.menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return ListTile(
            leading: Icon(
              item.icon,
              color: _selectedIndex == index
                  ? Colors.blue.shade700
                  : Colors.grey.shade600,
            ),
            title: Text(
              item.title,
              style: TextStyle(
                color: _selectedIndex == index
                    ? Colors.blue.shade700
                    : Colors.grey.shade800,
                fontWeight:
                    _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            selected: _selectedIndex == index,
            selectedTileColor: Colors.blue.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              item.onTap();
              // Close drawer on mobile
              if (MediaQuery.of(context).size.width < 600) {
                Navigator.pop(context);
              }
            },
          );
        }),
      ],
    );
  }
}

class DashboardMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  DashboardMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
