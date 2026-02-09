# Firebase Setup for Android - Quick Fix

## The Problem
You're seeing a black screen because Firebase is not configured for Android. The app needs `google-services.json` to initialize Firebase.

## Solution (Choose ONE method)

### Method 1: Using FlutterFire CLI (Recommended - 2 minutes)

1. **Install FlutterFire CLI** (one-time setup):
```bash
dart pub global activate flutterfire_cli
```

2. **Login to Firebase**:
```bash
firebase login
```

3. **Configure Firebase automatically**:
```bash
flutterfire configure
```

This command will:
- Create a Firebase project (or use existing)
- Download `google-services.json` for Android
- Generate `firebase_options.dart`
- Configure all platforms automatically

4. **Update admin_main.dart** (add one line):
```dart
import 'firebase_options.dart'; // ADD THIS LINE

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // ADD THIS LINE
    );
    runApp(const AdminApp());
  } catch (e) {
    // ... error handling
  }
}
```

5. **Run the app again**:
```bash
flutter run -t lib/admin_main.dart
```

---

### Method 2: Manual Setup (if FlutterFire doesn't work)

1. **Go to Firebase Console**: https://console.firebase.google.com/

2. **Create a new project** (or use existing)

3. **Add Android app**:
   - Click "Add app" → Android icon
   - Android package name: `com.example.mindlabz` 
     *(found in android/app/build.gradle)*
   - Download `google-services.json`

4. **Place the file**:
   ```
   android/app/google-services.json  <-- PUT FILE HERE
   ```

5. **Enable Firebase services**:
   - Go to Authentication → Get Started → Enable Email/Password
   - Go to Firestore Database → Create Database → Start in **production mode**
   - Go to Storage → Get Started

6. **Deploy security rules**:
   ```bash
   firebase init firestore
   firebase deploy --only firestore:rules
   ```

7. **Run the app**:
   ```bash
   flutter run -t lib/admin_main.dart
   ```

---

## Verification

Once Firebase is configured, you should see debug output like:
```
I/flutter: [AuthProvider] Initializing auth...
I/flutter: [AuthService] Getting current user data...
I/flutter: [AuthService] Firebase Auth user: null
I/flutter: [AuthProvider] Init complete. isAuthenticated: false
```

Then the **login screen should appear** instead of a black screen!

---

## Next Steps After Configuration

1. **Create your first Super Admin user** in Firestore Console:
   - Collection: `users`
   - Document ID: (auto-generated)
   - Fields:
     ```
     email: "admin@example.com"
     fullName: "Super Admin"
     role: "superAdmin"
     isActive: true
     createdAt: (timestamp)
     ```

2. **Create auth account** in Authentication panel with same email

3. **Login** to the app with these credentials

---

## Still Having Issues?

Run with verbose logging to see exact errors:
```bash
flutter run -t lib/admin_main.dart --verbose
```

Or check Firebase connection:
```bash
flutterfire configure --platforms=android
```
