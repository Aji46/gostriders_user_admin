import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_constants.dart';
import '../../utils/link_launcher.dart';
import '../../utils/responsive.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 36),
      child: Column(
        children: [
          Text(
            AppConstants.appName.toUpperCase(),
            style: const TextStyle(
              color: AppColors.primaryYellow,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            AppConstants.appTagline,
            style: TextStyle(color: AppColors.textGrey, fontSize: 12),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 22,
            runSpacing: 12,
            children: [
              _FooterAction(
                icon: Icons.camera_alt_outlined,
                label: 'Instagram',
                onTap: LinkLauncher.openInstagram,
              ),
              _FooterAction(
                icon: Icons.play_circle_outline,
                label: 'YouTube',
                onTap: LinkLauncher.openYoutube,
              ),
              _FooterAction(
                icon: Icons.location_on_outlined,
                label: 'Find Us',
                onTap: LinkLauncher.openLocation,
              ),
              _FooterAction(
                icon: Icons.call_outlined,
                label: AppConstants.phoneDisplay,
                onTap: LinkLauncher.callShop,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 14),
          Text(
            '© ${DateTime.now().year} Ghost Riders. All rights reserved.',
            style: const TextStyle(color: AppColors.textGrey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _FooterAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FooterAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: AppColors.textWhite),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(color: AppColors.textWhite, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
