import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_constants.dart';
import '../../utils/responsive.dart';
import '../../utils/whatsapp_helper.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: isMobile ? 40 : 70),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.background, AppColors.surface],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              AppConstants.logoAssetPath,
              height: isMobile ? 90 : 130,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'GEAR UP. RIDE HARD.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 26 : 42,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: AppColors.primaryYellow,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Premium helmets & bike accessories for the Ghost Riders crew.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 14 : 17,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 26),
          ElevatedButton.icon(
            onPressed: WhatsAppHelper.generalInquiry,
            icon: const Icon(Icons.chat, size: 20),
            label: const Text('Chat on WhatsApp'),
          ),
        ],
      ),
    );
  }
}
