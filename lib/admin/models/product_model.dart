import 'package:cloud_firestore/cloud_firestore.dart';

enum ProductStatus {
  pending,
  approved,
  rejected,
}

enum ProductCategory {
  men,
  women,
  kids,
}

class ProductModel {
  final String id;
  final String sellerId;
  final String sellerName;
  final String title;
  final String description;
  final double price;
  final double? discountedPrice;
  final ProductCategory category;
  final String subCategory;
  final List<String> sizes;
  final List<String> colors;
  final List<String> imageUrls;
  final int stockQuantity;
  final int lowStockThreshold;
  final ProductStatus status;
  final String? rejectionReason;
  final DateTime createdAt;
  final DateTime? approvedAt;
  final String? approvedBy;
  final Map<String, dynamic>? specifications;
  final String brand;
  final String sku;

  ProductModel({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.title,
    required this.description,
    required this.price,
    this.discountedPrice,
    required this.category,
    required this.subCategory,
    required this.sizes,
    required this.colors,
    required this.imageUrls,
    required this.stockQuantity,
    this.lowStockThreshold = 10,
    this.status = ProductStatus.pending,
    this.rejectionReason,
    required this.createdAt,
    this.approvedAt,
    this.approvedBy,
    this.specifications,
    required this.brand,
    required this.sku,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      sellerId: data['sellerId'] ?? '',
      sellerName: data['sellerName'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      discountedPrice: data['discountedPrice']?.toDouble(),
      category: _parseCategory(data['category']),
      subCategory: data['subCategory'] ?? '',
      sizes: List<String>.from(data['sizes'] ?? []),
      colors: List<String>.from(data['colors'] ?? []),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      stockQuantity: data['stockQuantity'] ?? 0,
      lowStockThreshold: data['lowStockThreshold'] ?? 10,
      status: _parseStatus(data['status']),
      rejectionReason: data['rejectionReason'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      approvedAt: data['approvedAt'] != null 
          ? (data['approvedAt'] as Timestamp).toDate() 
          : null,
      approvedBy: data['approvedBy'],
      specifications: data['specifications'],
      brand: data['brand'] ?? '',
      sku: data['sku'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'sellerId': sellerId,
      'sellerName': sellerName,
      'title': title,
      'description': description,
      'price': price,
      'discountedPrice': discountedPrice,
      'category': category.toString().split('.').last,
      'subCategory': subCategory,
      'sizes': sizes,
      'colors': colors,
      'imageUrls': imageUrls,
      'stockQuantity': stockQuantity,
      'lowStockThreshold': lowStockThreshold,
      'status': status.toString().split('.').last,
      'rejectionReason': rejectionReason,
      'createdAt': Timestamp.fromDate(createdAt),
      'approvedAt': approvedAt != null ? Timestamp.fromDate(approvedAt!) : null,
      'approvedBy': approvedBy,
      'specifications': specifications,
      'brand': brand,
      'sku': sku,
    };
  }

  static ProductCategory _parseCategory(String? categoryString) {
    switch (categoryString) {
      case 'men':
        return ProductCategory.men;
      case 'women':
        return ProductCategory.women;
      case 'kids':
        return ProductCategory.kids;
      default:
        return ProductCategory.men;
    }
  }

  static ProductStatus _parseStatus(String? statusString) {
    switch (statusString) {
      case 'pending':
        return ProductStatus.pending;
      case 'approved':
        return ProductStatus.approved;
      case 'rejected':
        return ProductStatus.rejected;
      default:
        return ProductStatus.pending;
    }
  }

  bool get isLowStock => stockQuantity <= lowStockThreshold;

  ProductModel copyWith({
    String? id,
    String? sellerId,
    String? sellerName,
    String? title,
    String? description,
    double? price,
    double? discountedPrice,
    ProductCategory? category,
    String? subCategory,
    List<String>? sizes,
    List<String>? colors,
    List<String>? imageUrls,
    int? stockQuantity,
    int? lowStockThreshold,
    ProductStatus? status,
    String? rejectionReason,
    DateTime? createdAt,
    DateTime? approvedAt,
    String? approvedBy,
    Map<String, dynamic>? specifications,
    String? brand,
    String? sku,
  }) {
    return ProductModel(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      imageUrls: imageUrls ?? this.imageUrls,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      createdAt: createdAt ?? this.createdAt,
      approvedAt: approvedAt ?? this.approvedAt,
      approvedBy: approvedBy ?? this.approvedBy,
      specifications: specifications ?? this.specifications,
      brand: brand ?? this.brand,
      sku: sku ?? this.sku,
    );
  }
}
