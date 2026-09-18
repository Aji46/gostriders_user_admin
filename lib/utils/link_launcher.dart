import 'package:url_launcher/url_launcher.dart';
import '../core/app_constants.dart';

/// Opens external links: Instagram, YouTube, Maps, phone call.
class LinkLauncher {
  LinkLauncher._();

  static Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> openInstagram() => _open(AppConstants.instagramUrl);

  static Future<void> openYoutube() => _open(AppConstants.youtubeUrl);

  static Future<void> openLocation() => _open(AppConstants.locationUrl);

  static Future<void> callShop() => _open('tel:+${AppConstants.phoneRaw}');
}
