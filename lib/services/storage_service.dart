import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

/// Handles uploading product photos to Firebase Storage and returns
/// the public download URL to save alongside the product in Firestore.
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  /// Uploads raw image bytes (works for both web & mobile picks) and
  /// returns the download URL.
  Future<String> uploadProductImage(Uint8List bytes, {String? fileName}) async {
    final name = fileName ?? '${_uuid.v4()}.jpg';
    final ref = _storage.ref().child('product_images/$name');
    final uploadTask = await ref.putData(
      bytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return await uploadTask.ref.getDownloadURL();
  }

  /// Deletes an image from storage given its full download URL.
  Future<void> deleteImageByUrl(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (_) {
      // Ignore if already deleted or URL isn't a storage ref.
    }
  }
}
