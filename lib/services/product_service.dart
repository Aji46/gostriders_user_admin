import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

/// Handles all Firestore reads/writes for products.
/// Collection: 'products'
class ProductService {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('products');

  /// Real-time stream of all products, newest first.
  Stream<List<ProductModel>> streamProducts() {
    return _productsRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                ProductModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> addProduct(ProductModel product) async {
    await _productsRef.add(product.toMap());
  }

  Future<void> updateProduct(ProductModel product) async {
    await _productsRef.doc(product.id).update(product.toMap());
  }

  Future<void> deleteProduct(String productId) async {
    await _productsRef.doc(productId).delete();
  }
}
