import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../core/app_constants.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import '../services/storage_service.dart';

/// Central controller for product data: live Firestore stream,
/// search & category filtering, and admin CRUD actions.
class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  final StorageService _storageService = StorageService();

  List<ProductModel> _allProducts = [];
  StreamSubscription? _sub;

  String _searchQuery = '';
  String _selectedCategory = 'All';
  bool _isLoading = true;
  bool _isSaving = false;
  String? _error;

  List<ProductModel> get products => _filteredProducts();
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  List<String> get categoryFilters => ['All', ...AppConstants.categories];

  ProductProvider() {
    _listen();
  }

  void _listen() {
    _sub = _productService.streamProducts().listen((products) {
      _allProducts = products;
      _isLoading = false;
      notifyListeners();
    }, onError: (e) {
      _isLoading = false;
      _error = 'Failed to load products.';
      notifyListeners();
    });
  }

  List<ProductModel> _filteredProducts() {
    return _allProducts.where((p) {
      final matchesCategory =
          _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategoryFilter(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = 'All';
    notifyListeners();
  }

  /// Uploads image (if provided) then creates the product document.
  Future<bool> addProduct({
    required String name,
    required String description,
    required double price,
    required String category,
    Uint8List? imageBytes,
    String existingImageUrl = '',
  }) async {
    _isSaving = true;
    _error = null;
    notifyListeners();
    try {
      String imageUrl = existingImageUrl;
      if (imageBytes != null) {
        imageUrl = await _storageService.uploadProductImage(imageBytes);
      }
      final product = ProductModel(
        id: '',
        name: name,
        description: description,
        price: price,
        category: category,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
      );
      await _productService.addProduct(product);
      _isSaving = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isSaving = false;
      _error = 'Failed to add product. Please try again.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct({
    required ProductModel original,
    required String name,
    required String description,
    required double price,
    required String category,
    Uint8List? newImageBytes,
  }) async {
    _isSaving = true;
    _error = null;
    notifyListeners();
    try {
      String imageUrl = original.imageUrl;
      if (newImageBytes != null) {
        imageUrl = await _storageService.uploadProductImage(newImageBytes);
        if (original.imageUrl.isNotEmpty) {
          await _storageService.deleteImageByUrl(original.imageUrl);
        }
      }
      final updated = original.copyWith(
        name: name,
        description: description,
        price: price,
        category: category,
        imageUrl: imageUrl,
      );
      await _productService.updateProduct(updated);
      _isSaving = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isSaving = false;
      _error = 'Failed to update product. Please try again.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProduct(ProductModel product) async {
    try {
      await _productService.deleteProduct(product.id);
      if (product.imageUrl.isNotEmpty) {
        await _storageService.deleteImageByUrl(product.imageUrl);
      }
      return true;
    } catch (e) {
      _error = 'Failed to delete product.';
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
