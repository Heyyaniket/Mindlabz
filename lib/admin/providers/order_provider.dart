import 'package:flutter/foundation.dart';
import '../models/order_model.dart';
import '../services/firestore_service.dart';

class OrderProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<OrderModel> get newOrders =>
      _orders.where((o) => o.status == OrderStatus.newOrder).toList();

  List<OrderModel> get readyToShipOrders =>
      _orders.where((o) => o.status == OrderStatus.readyToShip).toList();

  List<OrderModel> get dispatchedOrders =>
      _orders.where((o) => o.status == OrderStatus.dispatched).toList();

  // Load orders for seller
  Future<void> loadOrdersBySeller(String sellerId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _orders = await _firestoreService.getOrdersBySeller(sellerId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update order status
  Future<bool> updateOrderStatus(
    String orderId,
    OrderStatus status, {
    String? trackingNumber,
    String? courierService,
  }) async {
    try {
      await _firestoreService.updateOrderStatus(
        orderId,
        status,
        trackingNumber: trackingNumber,
        courierService: courierService,
      );

      final index = _orders.indexWhere((o) => o.id == orderId);
      if (index != -1) {
        _orders[index] = _orders[index].copyWith(
          status: status,
          trackingNumber: trackingNumber,
          courierService: courierService,
          dispatchedAt: status == OrderStatus.dispatched ? DateTime.now() : null,
          deliveredAt: status == OrderStatus.delivered ? DateTime.now() : null,
        );
      }

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
