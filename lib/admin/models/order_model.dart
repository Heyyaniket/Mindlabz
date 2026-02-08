import 'package:cloud_firestore/cloud_firestore.dart';

enum OrderStatus {
  newOrder,
  readyToShip,
  dispatched,
  inTransit,
  delivered,
  cancelled,
  returned,
}

class OrderItemModel {
  final String productId;
  final String productTitle;
  final String imageUrl;
  final double price;
  final int quantity;
  final String size;
  final String color;

  OrderItemModel({
    required this.productId,
    required this.productTitle,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.size,
    required this.color,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> data) {
    return OrderItemModel(
      productId: data['productId'] ?? '',
      productTitle: data['productTitle'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      quantity: data['quantity'] ?? 0,
      size: data['size'] ?? '',
      color: data['color'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productTitle': productTitle,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }
}

class OrderModel {
  final String id;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final String sellerId;
  final String sellerName;
  final List<OrderItemModel> items;
  final double subtotal;
  final double shippingFee;
  final double tax;
  final double total;
  final OrderStatus status;
  final String shippingAddress;
  final String? trackingNumber;
  final String? courierService;
  final DateTime createdAt;
  final DateTime? dispatchedAt;
  final DateTime? deliveredAt;
  final Map<String, dynamic>? statusHistory;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.sellerId,
    required this.sellerName,
    required this.items,
    required this.subtotal,
    required this.shippingFee,
    required this.tax,
    required this.total,
    this.status = OrderStatus.newOrder,
    required this.shippingAddress,
    this.trackingNumber,
    this.courierService,
    required this.createdAt,
    this.dispatchedAt,
    this.deliveredAt,
    this.statusHistory,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      customerId: data['customerId'] ?? '',
      customerName: data['customerName'] ?? '',
      customerEmail: data['customerEmail'] ?? '',
      sellerId: data['sellerId'] ?? '',
      sellerName: data['sellerName'] ?? '',
      items: (data['items'] as List<dynamic>)
          .map((item) => OrderItemModel.fromMap(item as Map<String, dynamic>))
          .toList(),
      subtotal: (data['subtotal'] ?? 0).toDouble(),
      shippingFee: (data['shippingFee'] ?? 0).toDouble(),
      tax: (data['tax'] ?? 0).toDouble(),
      total: (data['total'] ?? 0).toDouble(),
      status: _parseStatus(data['status']),
      shippingAddress: data['shippingAddress'] ?? '',
      trackingNumber: data['trackingNumber'],
      courierService: data['courierService'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      dispatchedAt: data['dispatchedAt'] != null 
          ? (data['dispatchedAt'] as Timestamp).toDate() 
          : null,
      deliveredAt: data['deliveredAt'] != null 
          ? (data['deliveredAt'] as Timestamp).toDate() 
          : null,
      statusHistory: data['statusHistory'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'items': items.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'shippingFee': shippingFee,
      'tax': tax,
      'total': total,
      'status': status.toString().split('.').last,
      'shippingAddress': shippingAddress,
      'trackingNumber': trackingNumber,
      'courierService': courierService,
      'createdAt': Timestamp.fromDate(createdAt),
      'dispatchedAt': dispatchedAt != null ? Timestamp.fromDate(dispatchedAt!) : null,
      'deliveredAt': deliveredAt != null ? Timestamp.fromDate(deliveredAt!) : null,
      'statusHistory': statusHistory,
    };
  }

  static OrderStatus _parseStatus(String? statusString) {
    switch (statusString) {
      case 'newOrder':
        return OrderStatus.newOrder;
      case 'readyToShip':
        return OrderStatus.readyToShip;
      case 'dispatched':
        return OrderStatus.dispatched;
      case 'inTransit':
        return OrderStatus.inTransit;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'returned':
        return OrderStatus.returned;
      default:
        return OrderStatus.newOrder;
    }
  }

  OrderModel copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? sellerId,
    String? sellerName,
    List<OrderItemModel>? items,
    double? subtotal,
    double? shippingFee,
    double? tax,
    double? total,
    OrderStatus? status,
    String? shippingAddress,
    String? trackingNumber,
    String? courierService,
    DateTime? createdAt,
    DateTime? dispatchedAt,
    DateTime? deliveredAt,
    Map<String, dynamic>? statusHistory,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      shippingFee: shippingFee ?? this.shippingFee,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      status: status ?? this.status,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      courierService: courierService ?? this.courierService,
      createdAt: createdAt ?? this.createdAt,
      dispatchedAt: dispatchedAt ?? this.dispatchedAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      statusHistory: statusHistory ?? this.statusHistory,
    );
  }
}
