# Firebase Firestore Schema Documentation

## Collections Overview

### 1. users
Stores information about all platform users (Sellers, Admins, Super Admins, and Customers).

```
users/{userId}
  - uid: string (document ID)
  - email: string
  - fullName: string
  - role: string ('seller' | 'admin' | 'superAdmin' | 'customer')
  - isActive: boolean
  - createdAt: timestamp
  - lastLogin: timestamp (nullable)
  
  // Seller-specific fields
  - gstin: string (nullable)
  - brandName: string (nullable)
  - warehouseAddress: string (nullable)
  - isApproved: boolean (nullable, only for sellers)
```

### 2. products
Stores all product listings created by sellers.

```
products/{productId}
  - sellerId: string (reference to users)
  - sellerName: string
  - title: string
  - description: string
  - price: number
  - discountedPrice: number (nullable)
  - category: string ('men' | 'women' | 'kids')
  - subCategory: string
  - sizes: array<string>
  - colors: array<string>
  - imageUrls: array<string>
  - stockQuantity: number
  - lowStockThreshold: number (default: 10)
  - status: string ('pending' | 'approved' | 'rejected')
  - rejectionReason: string (nullable)
  - createdAt: timestamp
  - approvedAt: timestamp (nullable)
  - approvedBy: string (nullable, admin userId)
  - specifications: map (nullable)
  - brand: string
  - sku: string
```

### 3. orders
Stores all customer orders.

```
orders/{orderId}
  - customerId: string (reference to users)
  - customerName: string
  - customerEmail: string
  - sellerId: string (reference to users)
  - sellerName: string
  - items: array<map>
    - productId: string
    - productTitle: string
    - imageUrl: string
    - price: number
    - quantity: number
    - size: string
    - color: string
  - subtotal: number
  - shippingFee: number
  - tax: number
  - total: number
  - status: string ('newOrder' | 'readyToShip' | 'dispatched' | 'inTransit' | 'delivered' | 'cancelled' | 'returned')
  - shippingAddress: string
  - trackingNumber: string (nullable)
  - courierService: string (nullable)
  - createdAt: timestamp
  - dispatchedAt: timestamp (nullable)
  - deliveredAt: timestamp (nullable)
  - statusHistory: map (nullable)
```

### 4. banners
Stores promotional banners for the customer app.

```
banners/{bannerId}
  - title: string
  - imageUrl: string
  - type: string ('seasonal' | 'promotional' | 'category')
  - targetUrl: string (nullable, deep link or web URL)
  - isActive: boolean
  - startDate: timestamp
  - endDate: timestamp
  - displayOrder: number
  - createdAt: timestamp
  - createdBy: string (admin userId)
```

### 5. commissions
Stores commission rates per category set by Super Admin.

```
commissions/{categoryName} (document ID is the category name)
  - categoryName: string
  - commissionRate: number (3-25, percentage)
  - updatedAt: timestamp
  - updatedBy: string (superAdmin userId)
```

### 6. settlements
Stores payout information for sellers.

```
settlements/{settlementId}
  - sellerId: string (reference to users)
  - sellerName: string
  - totalSales: number
  - commissionDeducted: number
  - netPayout: number
  - periodStart: timestamp
  - periodEnd: timestamp
  - isPaid: boolean
  - paidAt: timestamp (nullable)
  - transactionId: string (nullable)
  - createdAt: timestamp
```

### 7. analytics (optional, for caching)
Stores pre-computed analytics data for dashboard performance.

```
analytics/platform
  - totalUsers: number
  - totalSellers: number
  - activeSellers: number
  - totalProducts: number
  - totalOrders: number
  - totalRevenue: number
  - updatedAt: timestamp

analytics/seller_{sellerId}
  - sellerId: string
  - totalProducts: number
  - approvedProducts: number
  - pendingProducts: number
  - lowStockProducts: number
  - totalOrders: number
  - newOrders: number
  - completedOrders: number
  - totalRevenue: number
  - updatedAt: timestamp
```

## Indexes Required

Create these composite indexes in Firebase Console:

1. **products**: 
   - sellerId (Ascending) + createdAt (Descending)
   - status (Ascending) + createdAt (Descending)

2. **orders**: 
   - sellerId (Ascending) + createdAt (Descending)
   - sellerId (Ascending) + status (Ascending) + createdAt (Descending)
   - customerId (Ascending) + createdAt (Descending)

3. **settlements**: 
   - sellerId (Ascending) + createdAt (Descending)

## Storage Structure

```
gs://your-bucket/
  products/
    {sellerId}/
      {productId}/
        image_0.jpg
        image_1.jpg
        ...
  banners/
    {bannerId}/
      banner.jpg
  users/
    {userId}/
      profile.jpg
```

## Role-Based Access Summary

| Collection   | Seller (Approved) | Admin | Super Admin | Customer |
|--------------|------------------|-------|-------------|----------|
| users        | Own (Read)       | Sellers (R/W) | All (R/W) | Own (Read) |
| products     | Own (R/W), Create | All (R, Approve) | All (R/W/D) | Approved (Read) |
| orders       | Own (R, Update Status) | All (R/W) | All (R/W) | Own (R, Create) |
| banners      | - | R/W/D | R/W/D | Read |
| commissions  | Read | Read | R/W | - |
| settlements  | Own (Read) | All (Read) | All (R/W) | - |

## Setup Instructions

1. Deploy firestore.rules to your Firebase project:
   ```bash
   firebase deploy --only firestore:rules
   ```

2. Create the required indexes in Firebase Console or using firestore.indexes.json

3. Set up Firebase Storage CORS and security rules

4. Initialize your first Super Admin user manually in Firestore Console
