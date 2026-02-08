import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/banner_model.dart';
import '../models/commission_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ==================== USER OPERATIONS ====================
  
  Future<List<UserModel>> getAllSellers() async {
    final snapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'seller')
        .get();
    return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
  }

  Future<void> approveSeller(String sellerId) async {
    await _firestore.collection('users').doc(sellerId).update({
      'isApproved': true,
      'isActive': true,
    });
  }

  Future<void> rejectSeller(String sellerId) async {
    await _firestore.collection('users').doc(sellerId).update({
      'isApproved': false,
      'isActive': false,
    });
  }

  Future<void> updateUserStatus(String userId, bool isActive) async {
    await _firestore.collection('users').doc(userId).update({
      'isActive': isActive,
    });
  }

  // ==================== PRODUCT OPERATIONS ====================

  Future<String> addProduct(ProductModel product) async {
    final docRef = await _firestore.collection('products').add(product.toFirestore());
    return docRef.id;
  }

  Future<void> updateProduct(ProductModel product) async {
    await _firestore
        .collection('products')
        .doc(product.id)
        .update(product.toFirestore());
  }

  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  Future<List<ProductModel>> getProductsBySeller(String sellerId) async {
    final snapshot = await _firestore
        .collection('products')
        .where('sellerId', isEqualTo: sellerId)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }

  Stream<List<ProductModel>> getProductsBySellerStream(String sellerId) {
    return _firestore
        .collection('products')
        .where('sellerId', isEqualTo: sellerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromFirestore(doc))
            .toList());
  }

  Future<List<ProductModel>> getPendingProducts() async {
    final snapshot = await _firestore
        .collection('products')
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }

  Stream<List<ProductModel>> getPendingProductsStream() {
    return _firestore
        .collection('products')
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromFirestore(doc))
            .toList());
  }

  Future<void> approveProduct(String productId, String approvedBy) async {
    await _firestore.collection('products').doc(productId).update({
      'status': 'approved',
      'approvedAt': FieldValue.serverTimestamp(),
      'approvedBy': approvedBy,
    });
  }

  Future<void> rejectProduct(String productId, String reason) async {
    await _firestore.collection('products').doc(productId).update({
      'status': 'rejected',
      'rejectionReason': reason,
    });
  }

  Future<List<ProductModel>> getLowStockProducts(String sellerId) async {
    final snapshot = await _firestore
        .collection('products')
        .where('sellerId', isEqualTo: sellerId)
        .get();
    
    final products = snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();
    
    return products.where((p) => p.isLowStock).toList();
  }

  // ==================== ORDER OPERATIONS ====================

  Future<List<OrderModel>> getOrdersBySeller(String sellerId) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('sellerId', isEqualTo: sellerId)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();
  }

  Stream<List<OrderModel>> getOrdersBySellerStream(String sellerId) {
    return _firestore
        .collection('orders')
        .where('sellerId', isEqualTo: sellerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromFirestore(doc))
            .toList());
  }

  Future<List<OrderModel>> getOrdersByStatus(String sellerId, OrderStatus status) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('sellerId', isEqualTo: sellerId)
        .where('status', isEqualTo: status.toString().split('.').last)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();
  }

  Future<void> updateOrderStatus(
    String orderId,
    OrderStatus status, {
    String? trackingNumber,
    String? courierService,
  }) async {
    final updateData = <String, dynamic>{
      'status': status.toString().split('.').last,
    };

    if (status == OrderStatus.dispatched) {
      updateData['dispatchedAt'] = FieldValue.serverTimestamp();
      if (trackingNumber != null) updateData['trackingNumber'] = trackingNumber;
      if (courierService != null) updateData['courierService'] = courierService;
    }

    if (status == OrderStatus.delivered) {
      updateData['deliveredAt'] = FieldValue.serverTimestamp();
    }

    await _firestore.collection('orders').doc(orderId).update(updateData);
  }

  // ==================== BANNER OPERATIONS ====================

  Future<String> addBanner(BannerModel banner) async {
    final docRef = await _firestore.collection('banners').add(banner.toFirestore());
    return docRef.id;
  }

  Future<void> updateBanner(BannerModel banner) async {
    await _firestore
        .collection('banners')
        .doc(banner.id)
        .update(banner.toFirestore());
  }

  Future<void> deleteBanner(String bannerId) async {
    await _firestore.collection('banners').doc(bannerId).delete();
  }

  Future<List<BannerModel>> getAllBanners() async {
    final snapshot = await _firestore
        .collection('banners')
        .orderBy('displayOrder')
        .get();
    return snapshot.docs.map((doc) => BannerModel.fromFirestore(doc)).toList();
  }

  Stream<List<BannerModel>> getBannersStream() {
    return _firestore
        .collection('banners')
        .orderBy('displayOrder')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BannerModel.fromFirestore(doc))
            .toList());
  }

  // ==================== COMMISSION OPERATIONS ====================

  Future<void> setCommissionRate(String categoryName, double rate, String updatedBy) async {
    await _firestore.collection('commissions').doc(categoryName).set({
      'categoryName': categoryName,
      'commissionRate': rate,
      'updatedAt': FieldValue.serverTimestamp(),
      'updatedBy': updatedBy,
    });
  }

  Future<List<CommissionModel>> getAllCommissions() async {
    final snapshot = await _firestore.collection('commissions').get();
    return snapshot.docs.map((doc) => CommissionModel.fromFirestore(doc)).toList();
  }

  // ==================== SETTLEMENT OPERATIONS ====================

  Future<List<SettlementModel>> getSettlementsBySeller(String sellerId) async {
    final snapshot = await _firestore
        .collection('settlements')
        .where('sellerId', isEqualTo: sellerId)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => SettlementModel.fromFirestore(doc)).toList();
  }

  Stream<List<SettlementModel>> getSettlementsBySellerStream(String sellerId) {
    return _firestore
        .collection('settlements')
        .where('sellerId', isEqualTo: sellerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SettlementModel.fromFirestore(doc))
            .toList());
  }

  // ==================== STORAGE OPERATIONS ====================

  Future<String> uploadImage(File file, String path) async {
    final ref = _storage.ref().child(path);
    final uploadTask = await ref.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }

  Future<List<String>> uploadMultipleImages(List<File> files, String basePath) async {
    final urls = <String>[];
    for (var i = 0; i < files.length; i++) {
      final url = await uploadImage(files[i], '$basePath/image_$i.jpg');
      urls.add(url);
    }
    return urls;
  }

  Future<void> deleteImage(String imageUrl) async {
    try {
      final ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      // Image might not exist
    }
  }

  // ==================== ANALYTICS ====================

  Future<Map<String, dynamic>> getSellerAnalytics(String sellerId) async {
    final products = await getProductsBySeller(sellerId);
    final orders = await getOrdersBySeller(sellerId);
    
    final totalProducts = products.length;
    final approvedProducts = products.where((p) => p.status == ProductStatus.approved).length;
    final pendingProducts = products.where((p) => p.status == ProductStatus.pending).length;
    final lowStockProducts = products.where((p) => p.isLowStock).length;
    
    final totalOrders = orders.length;
    final newOrders = orders.where((o) => o.status == OrderStatus.newOrder).length;
    final completedOrders = orders.where((o) => o.status == OrderStatus.delivered).length;
    final totalRevenue = orders
        .where((o) => o.status == OrderStatus.delivered)
        .fold(0.0, (total, order) => total + order.total);

    return {
      'totalProducts': totalProducts,
      'approvedProducts': approvedProducts,
      'pendingProducts': pendingProducts,
      'lowStockProducts': lowStockProducts,
      'totalOrders': totalOrders,
      'newOrders': newOrders,
      'completedOrders': completedOrders,
      'totalRevenue': totalRevenue,
    };
  }

  Future<Map<String, dynamic>> getPlatformAnalytics() async {
    final usersSnapshot = await _firestore.collection('users').get();
    final productsSnapshot = await _firestore.collection('products').get();
    final ordersSnapshot = await _firestore.collection('orders').get();

    final totalSellers = usersSnapshot.docs
        .where((doc) => doc.data()['role'] == 'seller')
        .length;
    final activeSellers = usersSnapshot.docs
        .where((doc) => doc.data()['role'] == 'seller' && doc.data()['isActive'] == true)
        .length;

    final totalProducts = productsSnapshot.docs.length;
    final pendingProducts = productsSnapshot.docs
        .where((doc) => doc.data()['status'] == 'pending')
        .length;

    final totalOrders = ordersSnapshot.docs.length;
    final totalRevenue = ordersSnapshot.docs.fold(0.0, (total, doc) {
      final data = doc.data();
      if (data['status'] == 'delivered') {
        return total + (data['total'] ?? 0).toDouble();
      }
      return total;
    });

    return {
      'totalSellers': totalSellers,
      'activeSellers': activeSellers,
      'totalProducts': totalProducts,
      'pendingProducts': pendingProducts,
      'totalOrders': totalOrders,
      'totalRevenue': totalRevenue,
    };
  }
}
