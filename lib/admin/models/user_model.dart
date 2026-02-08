import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole {
  seller,
  admin,
  superAdmin,
}

class UserModel {
  final String uid;
  final String email;
  final String fullName;
  final UserRole role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLogin;
  
  // Seller-specific fields
  final String? gstin;
  final String? brandName;
  final String? warehouseAddress;
  final bool? isApproved;
  
  UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.role,
    this.isActive = true,
    required this.createdAt,
    this.lastLogin,
    this.gstin,
    this.brandName,
    this.warehouseAddress,
    this.isApproved,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      role: _parseRole(data['role']),
      isActive: data['isActive'] ?? true,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLogin: data['lastLogin'] != null 
          ? (data['lastLogin'] as Timestamp).toDate() 
          : null,
      gstin: data['gstin'],
      brandName: data['brandName'],
      warehouseAddress: data['warehouseAddress'],
      isApproved: data['isApproved'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'fullName': fullName,
      'role': role.toString().split('.').last,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': lastLogin != null ? Timestamp.fromDate(lastLogin!) : null,
      'gstin': gstin,
      'brandName': brandName,
      'warehouseAddress': warehouseAddress,
      'isApproved': isApproved,
    };
  }

  static UserRole _parseRole(String? roleString) {
    switch (roleString) {
      case 'seller':
        return UserRole.seller;
      case 'admin':
        return UserRole.admin;
      case 'superAdmin':
        return UserRole.superAdmin;
      default:
        return UserRole.seller;
    }
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    UserRole? role,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastLogin,
    String? gstin,
    String? brandName,
    String? warehouseAddress,
    bool? isApproved,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      gstin: gstin ?? this.gstin,
      brandName: brandName ?? this.brandName,
      warehouseAddress: warehouseAddress ?? this.warehouseAddress,
      isApproved: isApproved ?? this.isApproved,
    );
  }
}
