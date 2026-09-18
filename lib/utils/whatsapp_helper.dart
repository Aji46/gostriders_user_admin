import 'package:url_launcher/url_launcher.dart';
import '../core/app_constants.dart';
import '../models/product_model.dart';

/// Builds a pre-filled WhatsApp message and opens a chat with the
/// Ghost Riders business number when a customer wants to buy a product.
///
/// Note: WhatsApp's `wa.me` links only support pre-filled TEXT, not an
/// attached image file directly. We include the product photo's URL in
/// the message so the shop owner can open/view it immediately, and the
/// customer can also see the image on the product page before chatting.
class WhatsAppHelper {
  WhatsAppHelper._();

  static Future<void> orderProduct(ProductModel product) async {
    final message = _buildMessage(product);
    final encoded = Uri.encodeComponent(message);
    final url = Uri.parse(
      'https://wa.me/${AppConstants.whatsappNumber}?text=$encoded',
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  static Future<void> generalInquiry() async {
    const message =
        'Hi Ghost Riders! I have a question about your bike accessories & helmets.';
    final encoded = Uri.encodeComponent(message);
    final url = Uri.parse(
      'https://wa.me/${AppConstants.whatsappNumber}?text=$encoded',
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  static String _buildMessage(ProductModel product) {
    final priceStr = '₹${product.price.toStringAsFixed(0)}';
    return '''Hi Ghost Riders! I'm interested in buying this product:

🏍️ *${product.name}*
📂 Category: ${product.category}
💰 Price: $priceStr
📝 Details: ${product.description}
🖼️ Photo: ${product.imageUrl}

Please let me know the availability and how to proceed.''';
  }
}
