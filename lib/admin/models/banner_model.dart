import 'package:cloud_firestore/cloud_firestore.dart';

enum BannerType {
  seasonal,
  promotional,
  category,
}

class BannerModel {
  final String id;
  final String title;
  final String imageUrl;
  final BannerType type;
  final String? targetUrl;
  final bool isActive;
  final DateTime startDate;
  final DateTime endDate;
  final int displayOrder;
  final DateTime createdAt;
  final String createdBy;

  BannerModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.type,
    this.targetUrl,
    this.isActive = true,
    required this.startDate,
    required this.endDate,
    this.displayOrder = 0,
    required this.createdAt,
    required this.createdBy,
  });

  factory BannerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BannerModel(
      id: doc.id,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      type: _parseType(data['type']),
      targetUrl: data['targetUrl'],
      isActive: data['isActive'] ?? true,
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      displayOrder: data['displayOrder'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      createdBy: data['createdBy'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'type': type.toString().split('.').last,
      'targetUrl': targetUrl,
      'isActive': isActive,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'displayOrder': displayOrder,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
    };
  }

  static BannerType _parseType(String? typeString) {
    switch (typeString) {
      case 'seasonal':
        return BannerType.seasonal;
      case 'promotional':
        return BannerType.promotional;
      case 'category':
        return BannerType.category;
      default:
        return BannerType.promotional;
    }
  }

  bool get isCurrentlyActive {
    final now = DateTime.now();
    return isActive && now.isAfter(startDate) && now.isBefore(endDate);
  }
}
