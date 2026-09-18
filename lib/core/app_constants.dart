/// App-wide constants: branding, contact info & external links.
/// Keeping these in one place makes it easy to update shop details later.
class AppConstants {
  AppConstants._();

  // ---------------- Brand ----------------
  static const String appName = 'Ghost Riders';
  static const String appTagline = 'Bike Accessories & Helmets';
  static const String logoAssetPath = 'assets/images/logo.jpeg';

  // ---------------- Contact ----------------
  // Stored WITHOUT the leading '+' and spaces for WhatsApp / tel: usage.
  static const String phoneDisplay = '+91 80868 16139';
  static const String phoneRaw = '918086816139'; // country code + number
  static const String whatsappNumber = phoneRaw;

  // ---------------- Social Links ----------------
  static const String instagramUrl =
      'https://www.instagram.com/ghostriders._?igsh=MWR3aGp6dHJmODE0NA%3D%3D&utm_source=qr';
  static const String youtubeUrl =
      'https://youtube.com/@ghostridersaccessories?si=zlP1iZMwsII9AiA3';
  static const String locationUrl = 'https://maps.app.goo.gl/22aA3zZ986NMmrC96';

  // ---------------- Product Categories ----------------
  static const List<String> categories = [
    'Helmets',
    'Riding Jackets',
    'Gloves',
    'Riding Boots',
    'Bike Accessories',
    'Bike Parts',
    'Protective Gear',
    'Others',
  ];

  // ---------------- Admin ----------------
  // Hidden admin entry point - not linked anywhere in the normal UI.
  // Reach it by typing this path directly in the browser address bar,
  // e.g. https://yourdomain.com/#/admin-login
  static const String adminLoginRoute = '/admin-login';
  static const String adminDashboardRoute = '/admin-dashboard';
  static const String addEditProductRoute = '/admin-product-form';
  static const String homeRoute = '/';
  static const String productDetailRoute = '/product';
}
