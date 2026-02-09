import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';
import '../seller/seller_dashboard_screen.dart';
import '../admin/admin_dashboard_screen.dart';
import '../super_admin/super_admin_dashboard_screen.dart';
import 'admin_login_screen.dart';

class AdminRootScreen extends StatelessWidget {
  const AdminRootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (kDebugMode) {
          print('[AdminRootScreen] Building...');
          print('[AdminRootScreen] isLoading: ${authProvider.isLoading}');
          print('[AdminRootScreen] isAuthenticated: ${authProvider.isAuthenticated}');
          print('[AdminRootScreen] currentUser: ${authProvider.currentUser?.email}');
          print('[AdminRootScreen] userRole: ${authProvider.userRole}');
        }
        
        // Show loading while checking auth state
        if (authProvider.isLoading) {
          if (kDebugMode) print('[AdminRootScreen] Showing loading screen');
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If not authenticated, show login
        if (!authProvider.isAuthenticated) {
          if (kDebugMode) print('[AdminRootScreen] Showing login screen');
          return const AdminLoginScreen();//change made by ron
        }

        // Route to appropriate dashboard based on role
        if (kDebugMode) print('[AdminRootScreen] Routing to ${authProvider.userRole}');
        return _routeToDashboard(authProvider.userRole!);
      },
    );
  }

  Widget _routeToDashboard(UserRole role) {
    switch (role) {
      case UserRole.seller:
        return const SellerDashboardScreen();
      case UserRole.admin:
        return const AdminDashboardScreen();
      case UserRole.superAdmin:
        return const SuperAdminDashboardScreen();
    }
  }
}
