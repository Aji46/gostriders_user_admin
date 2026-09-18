import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_constants.dart';
import '../../utils/link_launcher.dart';
import '../../utils/responsive.dart';

/// Top navigation bar. Shown on the public storefront.
///
/// Hidden admin access: long-press (or long-tap) the logo 5 times
/// quickly is overkill for a shop owner - instead we use a simple,
/// deliberate gesture: a LONG PRESS on the logo opens the admin
/// login screen. Nothing in the visible UI says "Admin" or "Login",
/// so regular customers never see it.
class Navbar extends StatefulWidget {
  final VoidCallback onAdminAccess;
  const Navbar({super.key, required this.onAdminAccess});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _tapCount = 0;

  void _handleSecretTap() {
    _tapCount++;
    if (_tapCount >= 5) {
      _tapCount = 0;
      widget.onAdminAccess();
    }
    // Reset the counter if user pauses tapping.
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _tapCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 14),
      child: Row(
        children: [
          // Logo - long-press OR 5 quick taps opens hidden admin login.
          GestureDetector(
            onLongPress: widget.onAdminAccess,
            onTap: _handleSecretTap,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    AppConstants.logoAssetPath,
                    height: 44,
                    width: 44,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                if (!isMobile)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.appName.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          letterSpacing: 1,
                          color: AppColors.primaryYellow,
                        ),
                      ),
                      const Text(
                        AppConstants.appTagline,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const Spacer(),
          if (!isMobile) ...[
            _NavIconButton(
              icon: Icons.camera_alt_outlined,
              tooltip: 'Instagram',
              onTap: LinkLauncher.openInstagram,
            ),
            _NavIconButton(
              icon: Icons.play_circle_outline,
              tooltip: 'YouTube',
              onTap: LinkLauncher.openYoutube,
            ),
            _NavIconButton(
              icon: Icons.location_on_outlined,
              tooltip: 'Location',
              onTap: LinkLauncher.openLocation,
            ),
            _NavIconButton(
              icon: Icons.call_outlined,
              tooltip: 'Call Us',
              onTap: LinkLauncher.callShop,
            ),
          ] else
            _NavIconButton(
              icon: Icons.call_outlined,
              tooltip: 'Call Us',
              onTap: LinkLauncher.callShop,
            ),
        ],
      ),
    );
  }
}

class _NavIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _NavIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Tooltip(
        message: tooltip,
        child: IconButton(
          onPressed: onTap,
          icon: Icon(icon, color: AppColors.textWhite, size: 22),
        ),
      ),
    );
  }
}
