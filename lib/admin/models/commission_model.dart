import 'package:cloud_firestore/cloud_firestore.dart';

class CommissionModel {
  final String id;
  final String categoryName;
  final double commissionRate; // Percentage (3-25)
  final DateTime updatedAt;
  final String updatedBy;

  CommissionModel({
    required this.id,
    required this.categoryName,
    required this.commissionRate,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory CommissionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CommissionModel(
      id: doc.id,
      categoryName: data['categoryName'] ?? '',
      commissionRate: (data['commissionRate'] ?? 0).toDouble(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      updatedBy: data['updatedBy'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'categoryName': categoryName,
      'commissionRate': commissionRate,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'updatedBy': updatedBy,
    };
  }
}

class SettlementModel {
  final String id;
  final String sellerId;
  final String sellerName;
  final double totalSales;
  final double commissionDeducted;
  final double netPayout;
  final DateTime periodStart;
  final DateTime periodEnd;
  final bool isPaid;
  final DateTime? paidAt;
  final String? transactionId;
  final DateTime createdAt;

  SettlementModel({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.totalSales,
    required this.commissionDeducted,
    required this.netPayout,
    required this.periodStart,
    required this.periodEnd,
    this.isPaid = false,
    this.paidAt,
    this.transactionId,
    required this.createdAt,
  });

  factory SettlementModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SettlementModel(
      id: doc.id,
      sellerId: data['sellerId'] ?? '',
      sellerName: data['sellerName'] ?? '',
      totalSales: (data['totalSales'] ?? 0).toDouble(),
      commissionDeducted: (data['commissionDeducted'] ?? 0).toDouble(),
      netPayout: (data['netPayout'] ?? 0).toDouble(),
      periodStart: (data['periodStart'] as Timestamp).toDate(),
      periodEnd: (data['periodEnd'] as Timestamp).toDate(),
      isPaid: data['isPaid'] ?? false,
      paidAt: data['paidAt'] != null 
          ? (data['paidAt'] as Timestamp).toDate() 
          : null,
      transactionId: data['transactionId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'sellerId': sellerId,
      'sellerName': sellerName,
      'totalSales': totalSales,
      'commissionDeducted': commissionDeducted,
      'netPayout': netPayout,
      'periodStart': Timestamp.fromDate(periodStart),
      'periodEnd': Timestamp.fromDate(periodEnd),
      'isPaid': isPaid,
      'paidAt': paidAt != null ? Timestamp.fromDate(paidAt!) : null,
      'transactionId': transactionId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
