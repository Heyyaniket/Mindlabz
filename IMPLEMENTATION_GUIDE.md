# Quick Implementation Guide

## Common Tasks & Code Snippets

### 1. Adding Firebase to Your Project

**pubspec.yaml:**
```yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  cloud_firestore: ^4.13.0
  firebase_storage: ^11.5.0
  provider: ^6.1.1
```

**Initialize in main:**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AdminApp());
}
```

---

### 2. Implementing Image Upload

Add to `FirestoreService`:

```dart
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// In your add product screen
Future<List<String>> _uploadProductImages(List<File> images, String sellerId) async {
  final firestoreService = context.read<FirestoreService>();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  
  return await firestoreService.uploadMultipleImages(
    images,
    'products/$sellerId/$timestamp',
  );
}

// Image picker helper
Future<List<File>> _pickImages() async {
  final picker = ImagePicker();
  final images = await picker.pickMultiImage();
  return images.map((xFile) => File(xFile.path)).toList();
}
```

---

### 3. Complete Product Creation Form

```dart
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _skuController = TextEditingController();
  final _stockController = TextEditingController();
  final _brandController = TextEditingController();
  
  ProductCategory _selectedCategory = ProductCategory.men;
  String _selectedSubCategory = 'Shirts';
  List<String> _sizes = [];
  List<String> _colors = [];
  List<File> _images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Image Picker
            GestureDetector(
              onTap: _pickImages,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _images.isEmpty
                    ? const Center(child: Text('Tap to add images'))
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Image.file(_images[index], fit: BoxFit.cover);
                        },
                      ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Product Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            
            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            
            // Price
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
                prefixText: '\$',
              ),
              keyboardType: TextInputType.number,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            
            // SKU & Brand
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _skuController,
                    decoration: const InputDecoration(
                      labelText: 'SKU',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(
                      labelText: 'Brand',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Category
            DropdownButtonFormField<ProductCategory>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: ProductCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.toString().split('.').last),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Stock
            TextFormField(
              controller: _stockController,
              decoration: const InputDecoration(
                labelText: 'Stock Quantity',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 32),
            
            // Submit Button
            ElevatedButton(
              onPressed: _submitProduct,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();
    setState(() {
      _images = images.map((xFile) => File(xFile.path)).toList();
    });
  }

  Future<void> _submitProduct() async {
    if (!_formKey.currentState!.validate()) return;
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one image')),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final firestoreService = FirestoreService();
    
    // Upload images
    final imageUrls = await firestoreService.uploadMultipleImages(
      _images,
      'products/${authProvider.currentUser!.uid}/${DateTime.now().millisecondsSinceEpoch}',
    );

    // Create product
    final product = ProductModel(
      id: '',
      sellerId: authProvider.currentUser!.uid,
      sellerName: authProvider.currentUser!.fullName,
      title: _titleController.text,
      description: _descriptionController.text,
      price: double.parse(_priceController.text),
      category: _selectedCategory,
      subCategory: _selectedSubCategory,
      sizes: _sizes,
      colors: _colors,
      imageUrls: imageUrls,
      stockQuantity: int.parse(_stockController.text),
      brand: _brandController.text,
      sku: _skuController.text,
      createdAt: DateTime.now(),
    );

    await firestoreService.addProduct(product);
    
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _skuController.dispose();
    _stockController.dispose();
    _brandController.dispose();
    super.dispose();
  }
}
```

---

### 4. Integrating Charts (fl_chart)

Add dependency:
```yaml
dependencies:
  fl_chart: ^0.65.0
```

Example revenue chart:
```dart
import 'package:fl_chart/fl_chart.dart';

class RevenueChart extends StatelessWidget {
  const RevenueChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 3000),
              const FlSpot(1, 4500),
              const FlSpot(2, 4000),
              const FlSpot(3, 5500),
              const FlSpot(4, 6000),
              const FlSpot(5, 7200),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

### 5. Email Notifications

Add to `pubspec.yaml`:
```yaml
dependencies:
  cloud_functions: ^4.5.0
```

Create Firebase Cloud Function:
```javascript
// functions/index.js
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

admin.initializeApp();

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'your-email@gmail.com',
    pass: 'your-app-password',
  },
});

exports.sendSellerApprovalEmail = functions.firestore
  .document('users/{userId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    if (!before.isApproved && after.isApproved) {
      const mailOptions = {
        from: 'your-email@gmail.com',
        to: after.email,
        subject: 'Seller Account Approved!',
        html: `
          <h1>Congratulations!</h1>
          <p>Your seller account has been approved.</p>
          <p>You can now start adding products to the platform.</p>
        `,
      };

      await transporter.sendMail(mailOptions);
    }
  });
```

---

### 6. Real-time Updates

Use Firestore streams instead of one-time reads:

```dart
// In ProductProvider
Stream<List<ProductModel>> watchProductsBySeller(String sellerId) {
  return _firestoreService.getProductsBySellerStream(sellerId);
}

// In UI
StreamBuilder<List<ProductModel>>(
  stream: productProvider.watchProductsBySeller(sellerId),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final product = snapshot.data![index];
          return ProductCard(product: product);
        },
      );
    }
    return const CircularProgressIndicator();
  },
)
```

---

### 7. Search Functionality

Add to Firestore Service:
```dart
Future<List<ProductModel>> searchProducts(String query) async {
  // Note: For production, use Algolia or ElasticSearch
  final snapshot = await _firestore
      .collection('products')
      .where('status', isEqualTo: 'approved')
      .get();
  
  final products = snapshot.docs
      .map((doc) => ProductModel.fromFirestore(doc))
      .toList();
  
  return products.where((product) {
    final titleMatch = product.title.toLowerCase().contains(query.toLowerCase());
    final skuMatch = product.sku.toLowerCase().contains(query.toLowerCase());
    return titleMatch || skuMatch;
  }).toList();
}
```

---

### 8. Export Reports to PDF

Add dependency:
```yaml
dependencies:
  pdf: ^3.10.0
  printing: ^5.11.0
```

Example:
```dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generateSettlementReport(SettlementModel settlement) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Settlement Report', style: pw.TextStyle(fontSize: 24)),
          pw.SizedBox(height: 20),
          pw.Text('Period: ${settlement.periodStart} - ${settlement.periodEnd}'),
          pw.Text('Total Sales: \$${settlement.totalSales}'),
          pw.Text('Commission: \$${settlement.commissionDeducted}'),
          pw.Text('Net Payout: \$${settlement.netPayout}'),
        ],
      ),
    ),
  );

  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}
```

---

### 9. Running in Production

**Web deployment:**
```bash
flutter build web -t lib/admin_main.dart
firebase deploy --only hosting
```

**Desktop:**
```bash
flutter build windows -t lib/admin_main.dart
flutter build macos -t lib/admin_main.dart
flutter build linux -t lib/admin_main.dart
```

---

### 10. Environment Variables

Create separate Firebase configs for dev/prod:

```dart
class FirebaseConfig {
  static FirebaseOptions get currentPlatform {
    if (kDebugMode) {
      return _devOptions;
    }
    return _prodOptions;
  }

  static const FirebaseOptions _devOptions = FirebaseOptions(
    apiKey: 'dev-api-key',
    appId: 'dev-app-id',
    messagingSenderId: 'dev-sender-id',
    projectId: 'dev-project-id',
  );

  static const FirebaseOptions _prodOptions = FirebaseOptions(
    apiKey: 'prod-api-key',
    appId: 'prod-app-id',
    messagingSenderId: 'prod-sender-id',
    projectId: 'prod-project-id',
  );
}
```

---

## Testing

### Unit Tests Example

```dart
void main() {
  group('ProductModel', () {
    test('should create product from Firestore', () {
      final doc = MockDocumentSnapshot();
      final product = ProductModel.fromFirestore(doc);
      expect(product.title, 'Test Product');
    });

    test('should identify low stock', () {
      final product = ProductModel(
        // ... fields
        stockQuantity: 5,
        lowStockThreshold: 10,
      );
      expect(product.isLowStock, true);
    });
  });
}
```

---

## Performance Tips

1. **Use StreamBuilder only when needed** - For real-time updates
2. **Implement pagination** - For large lists
3. **Cache images** - Use `cached_network_image`
4. **Lazy load data** - Don't load everything at once
5. **Index Firestore queries** - Follow console suggestions
6. **Optimize images** - Compress before upload
7. **Use const constructors** - For better performance

---

## Security Checklist

- ✅ Firebase rules deployed and tested
- ✅ API keys protected (use environment variables)
- ✅ User input validated
- ✅ Rate limiting on sensitive operations
- ✅ HTTPS only
- ✅ Regular security audits
- ✅ Keep dependencies updated

---

For more examples and documentation, refer to:
- [ADMIN_PORTAL_README.md](ADMIN_PORTAL_README.md)
- [FIREBASE_SCHEMA.md](FIREBASE_SCHEMA.md)
