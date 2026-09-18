import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_constants.dart';
import 'core/app_theme.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'views/screens/admin_dashboard_screen.dart';
import 'views/screens/admin_login_screen.dart';
import 'views/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const GhostRidersApp());
}

class GhostRidersApp extends StatelessWidget {
  const GhostRidersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: '${AppConstants.appName} - ${AppConstants.appTagline}',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        // The storefront ('/') is the default & only screen linked in the
        // UI. '/admin-login' exists as a route so the shop owner can also
        // type it directly in the browser address bar - it is NEVER
        // shown as a link/button to regular visitors.
        initialRoute: AppConstants.homeRoute,
        routes: {
          AppConstants.homeRoute: (_) => const HomeScreen(),
          AppConstants.adminLoginRoute: (_) => const AdminLoginScreen(),
          AppConstants.adminDashboardRoute: (_) => const _AdminGate(),
        },
      ),
    );
  }
}

/// Guards the admin dashboard route: if someone navigates straight to
/// '/admin-dashboard' via URL without being logged in, bounce them to
/// the login screen instead of exposing admin data.
class _AdminGate extends StatelessWidget {
  const _AdminGate();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    if (authProvider.isLoggedIn) {
      return const AdminDashboardScreen();
    }
    return const AdminLoginScreen();
  }
}
