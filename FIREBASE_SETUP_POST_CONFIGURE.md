# Firebase Configuration Complete - Next Steps

After the `flutterfire configure` command completes successfully, you should have:

1. ✅ `lib/firebase_options.dart` - Auto-generated Firebase config
2. ✅ `android/app/google-services.json` - Android configuration
3. ✅ Firebase Console setup for your project

## Update admin_main.dart

Now update your admin_main.dart to import the new firebase_options.dart file:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';  // ← ADD THIS LINE
import 'admin/providers/auth_provider.dart';
import 'admin/providers/product_provider.dart';
import 'admin/providers/order_provider.dart';
import 'admin/screens/shared/admin_root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,  // ← ADD THIS LINE
    );
    runApp(const AdminApp());
  } catch (e) {
    // ... rest of error handler
  }
}
```

## Firebase Console Setup

Visit [Firebase Console](https://console.firebase.google.com/) and for your project:

### 1. Enable Authentication
- Go to **Authentication** → **Get Started**
- Click **Email/Password** → **Enable**
- Save

### 2. Create Firestore Database
- Go to **Firestore Database** → **Create Database**
- Choose: **Start in production mode**
- Location: your preferred region
- Create

### 3. Upload Security Rules
```bash
firebase deploy --only firestore:rules
```

### 4. Create First Super Admin User

**In Firestore Console:**
- Go to **Firestore Database** → **Collections**
- Click **"+ Start Collection"**
- Collection name: `users`
- Click **"Auto ID"** for document ID
- Add fields:
  ```
  email: (string) "admin@example.com"
  fullName: (string) "Super Admin"
  role: (string) "superAdmin"
  isActive: (boolean) true
  createdAt: (timestamp) 2026-02-08T...
  ```
- Save

**In Authentication:**
- Go to **Authentication** → **Users**
- Click **"Add User"**
- Email: `admin@example.com`
- Password: (choose one)
- Create User

## Test It Out

```bash
flutter run -t lib/admin_main.dart
```

You should see:
1. ✅ **Loading screen** while initializing
2. ✅ **Login screen** with email/password fields
3. ✅ Login with the Super Admin credentials

## Troubleshooting

### Still seeing black screen?
- Check device console: `flutter logs`
- Look for errors related to Firebase
- Verify google-services.json exists in android/app/

### Firebase connection errors?
- Verify Firestore Database is created (not in setup mode)
- Check security rules don't block anonymous access during init
- Run: `firebase functions:config:set`

### Login fails?
- Verify user exists in both Firestore AND Authentication
- Email must match exactly
- Check Firestore security rules allow read access

## Production Checklist

Before deploying to production:

- [ ] Firestore security rules deployed
- [ ] Firebase Cloud Storage configured
- [ ] Email verification enabled
- [ ] Password reset feature tested
- [ ] User roles properly configured
- [ ] Seller approval workflow verified
- [ ] Admin/Super Admin permissions tested

See [ADMIN_PORTAL_README.md](ADMIN_PORTAL_README.md) for complete documentation.
