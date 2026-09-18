import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../utils/responsive.dart';
import '../../utils/whatsapp_helper.dart';
import '../widgets/footer.dart';
import '../widgets/hero_banner.dart';
import '../widgets/navbar.dart';
import '../widgets/product_grid.dart';
import '../widgets/search_filter_bar.dart';
import 'admin_login_screen.dart';

/// Public storefront home screen. This is the ONLY screen normal
/// visitors ever see by default - the admin login is reachable only
/// via the hidden gesture on the logo inside [Navbar].
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openAdminLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: WhatsAppHelper.generalInquiry,
        backgroundColor: AppColors.success,
        icon: const Icon(Icons.chat, color: Colors.white),
        label: const Text('WhatsApp Us', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.contentMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Navbar(onAdminAccess: () => _openAdminLogin(context)),
                const HeroBanner(),
                const SearchFilterBar(),
                const ProductGrid(),
                const SizedBox(height: 20),
                const AppFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
