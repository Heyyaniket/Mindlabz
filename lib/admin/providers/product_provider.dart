import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/firestore_service.dart';

class ProductProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<ProductModel> _products = [];
  List<ProductModel> _pendingProducts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProductModel> get products => _products;
  List<ProductModel> get pendingProducts => _pendingProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<ProductModel> get lowStockProducts =>
      _products.where((p) => p.isLowStock).toList();

  // Load products for seller
  Future<void> loadProductsBySeller(String sellerId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _firestoreService.getProductsBySeller(sellerId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load pending products (for admin)
  Future<void> loadPendingProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _pendingProducts = await _firestoreService.getPendingProducts();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add product
  Future<bool> addProduct(ProductModel product) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.addProduct(product);
      _products.insert(0, product);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update product
  Future<bool> updateProduct(ProductModel product) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.updateProduct(product);
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = product;
      }
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete product
  Future<bool> deleteProduct(String productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.deleteProduct(productId);
      _products.removeWhere((p) => p.id == productId);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Approve product (admin)
  Future<bool> approveProduct(String productId, String approvedBy) async {
    try {
      await _firestoreService.approveProduct(productId, approvedBy);
      _pendingProducts.removeWhere((p) => p.id == productId);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Reject product (admin)
  Future<bool> rejectProduct(String productId, String reason) async {
    try {
      await _firestoreService.rejectProduct(productId, reason);
      _pendingProducts.removeWhere((p) => p.id == productId);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
