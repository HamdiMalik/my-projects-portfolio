# 📱 Flutter Mobile App Setup Guide

This guide will help you set up and build the SkinCheck Flutter mobile application.

## 🚀 Quick Start

### 1. Install Flutter

#### Windows
```bash
# Download Flutter SDK
# Extract to C:\flutter
# Add C:\flutter\bin to PATH

# Verify installation
flutter doctor
```

#### macOS
```bash
# Using Homebrew
brew install flutter

# Or download from flutter.dev
# Extract and add to PATH

# Verify installation
flutter doctor
```

#### Linux
```bash
# Download Flutter SDK
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz

# Extract
tar xf flutter_linux_3.16.0-stable.tar.xz

# Add to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verify installation
flutter doctor
```

### 2. Setup Development Environment

#### Android Studio
1. Download and install Android Studio
2. Install Flutter and Dart plugins
3. Configure Android SDK
4. Create Android Virtual Device (AVD)

#### VS Code (Alternative)
1. Install VS Code
2. Install Flutter extension
3. Install Dart extension

### 3. Clone and Setup Project

```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
flutter pub get

# Check for issues
flutter doctor

# Run the app
flutter run
```

## 🔧 Configuration

### 1. Update API Endpoint

Edit `lib/services/api_service.dart`:

```dart
class ApiService {
  // Replace with your backend server IP/domain
  static const String baseUrl = 'http://YOUR_SERVER_IP:5000/api/v1';
  
  // For local development
  // static const String baseUrl = 'http://10.0.2.2:5000/api/v1'; // Android emulator
  // static const String baseUrl = 'http://localhost:5000/api/v1'; // iOS simulator
}
```

### 2. Configure Permissions

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

#### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to scan skin conditions</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to save scan images</string>
```

## 📱 Building the App

### Debug Build (Development)

```bash
# Run on connected device/emulator
flutter run

# Run with hot reload
flutter run --hot

# Run on specific device
flutter devices
flutter run -d <device-id>
```

### Release Build (Production)

#### Android APK
```bash
# Build release APK
flutter build apk --release

# Build optimized APK (smaller size)
flutter build apk --release --split-per-abi

# Output location: build/app/outputs/flutter-apk/app-release.apk
```

#### Android App Bundle (Recommended for Play Store)
```bash
# Build app bundle
flutter build appbundle --release

# Output location: build/app/outputs/bundle/release/app-release.aab
```

#### iOS (macOS only)
```bash
# Build iOS app
flutter build ios --release

# Open in Xcode for signing and distribution
open ios/Runner.xcworkspace
```

## 🔐 App Signing

### Android Signing

1. **Generate keystore**
   ```bash
   keytool -genkey -v -keystore ~/skincheck-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias skincheck
   ```

2. **Configure signing in `android/app/build.gradle`**
   ```gradle
   android {
       signingConfigs {
           release {
               keyAlias 'skincheck'
               keyPassword 'your-key-password'
               storeFile file('/path/to/skincheck-key.jks')
               storePassword 'your-store-password'
           }
       }
       buildTypes {
           release {
               signingConfig signingConfigs.release
           }
       }
   }
   ```

3. **Build signed APK**
   ```bash
   flutter build apk --release
   ```

### iOS Signing

1. **Configure in Xcode**
   - Open `ios/Runner.xcworkspace`
   - Select Runner target
   - Go to Signing & Capabilities
   - Select your development team
   - Configure bundle identifier

2. **Build for distribution**
   - Product → Archive
   - Distribute App
   - Choose distribution method

## 🧪 Testing

### Unit Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/auth_test.dart

# Run with coverage
flutter test --coverage
```

### Integration Tests
```bash
# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Widget Tests
```bash
# Test specific widgets
flutter test test/widget/login_screen_test.dart
```

## 📊 Performance Optimization

### App Size Optimization

1. **Enable ProGuard/R8**
   ```gradle
   // android/app/build.gradle
   buildTypes {
       release {
           minifyEnabled true
           shrinkResources true
           proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
       }
   }
   ```

2. **Split APKs by ABI**
   ```bash
   flutter build apk --release --split-per-abi
   ```

3. **Analyze app size**
   ```bash
   flutter build apk --analyze-size
   ```

### Runtime Performance

1. **Profile mode**
   ```bash
   flutter run --profile
   ```

2. **Performance monitoring**
   ```bash
   flutter run --trace-startup
   ```

## 🚀 Deployment

### Google Play Store

1. **Prepare app listing**
   - App name: SkinCheck
   - Package name: com.skincheck.app
   - App icon: 512x512 PNG
   - Screenshots: Various device sizes
   - Feature graphic: 1024x500 PNG

2. **Upload to Play Console**
   - Create new app
   - Upload app bundle (.aab file)
   - Fill app information
   - Set up store listing
   - Submit for review

3. **Release management**
   - Internal testing
   - Closed testing (alpha/beta)
   - Open testing
   - Production release

### Apple App Store

1. **Prepare app listing**
   - App name: SkinCheck
   - Bundle ID: com.skincheck.app
   - App icon: 1024x1024 PNG
   - Screenshots: iPhone and iPad
   - App preview videos (optional)

2. **Upload to App Store Connect**
   - Create app record
   - Upload build via Xcode
   - Fill app information
   - Set pricing and availability
   - Submit for review

## 🔧 Troubleshooting

### Common Issues

1. **Flutter doctor issues**
   ```bash
   # Fix Android license issues
   flutter doctor --android-licenses
   
   # Update Flutter
   flutter upgrade
   
   # Clean and rebuild
   flutter clean
   flutter pub get
   ```

2. **Build failures**
   ```bash
   # Clear build cache
   flutter clean
   
   # Reset pub cache
   flutter pub cache repair
   
   # Rebuild
   flutter pub get
   flutter build apk
   ```

3. **Camera not working**
   - Test on physical device (not emulator)
   - Check permissions in manifest
   - Verify camera plugin installation

4. **API connection issues**
   - Check network permissions
   - Verify API endpoint URL
   - Test API with curl/Postman
   - Check CORS settings on backend

### Debug Commands

```bash
# Verbose output
flutter run -v

# Debug specific device
flutter run -d <device-id> --debug

# Check connected devices
flutter devices

# Flutter inspector
flutter inspector

# Performance profiling
flutter run --profile --trace-startup
```

## 📱 Device Testing

### Android Testing

1. **Enable Developer Options**
   - Go to Settings → About Phone
   - Tap Build Number 7 times
   - Enable USB Debugging

2. **Connect device**
   ```bash
   # Check if device is detected
   adb devices
   
   # Run on device
   flutter run
   ```

### iOS Testing

1. **Enable Developer Mode**
   - Connect device to Mac
   - Trust computer on device
   - Enable Developer Mode in Settings

2. **Run on device**
   ```bash
   # List iOS devices
   flutter devices
   
   # Run on iOS device
   flutter run -d <ios-device-id>
   ```

## 🔒 Security Checklist

- [ ] API endpoints use HTTPS in production
- [ ] Sensitive data stored securely (FlutterSecureStorage)
- [ ] Input validation implemented
- [ ] Network security config configured
- [ ] App signing certificates secured
- [ ] ProGuard/R8 enabled for release builds
- [ ] Debug information removed from release builds

## 📈 Monitoring & Analytics

### Crash Reporting
```yaml
# pubspec.yaml
dependencies:
  firebase_crashlytics: ^3.4.8
```

### Performance Monitoring
```yaml
# pubspec.yaml
dependencies:
  firebase_performance: ^0.9.3+8
```

### User Analytics
```yaml
# pubspec.yaml
dependencies:
  firebase_analytics: ^10.7.4
```

## 🎯 Next Steps

1. **Test thoroughly**
   - Test on multiple devices
   - Test offline functionality
   - Test camera features
   - Test API integration

2. **Optimize performance**
   - Profile app performance
   - Optimize images and assets
   - Implement lazy loading
   - Monitor memory usage

3. **Prepare for store submission**
   - Create store listings
   - Prepare marketing materials
   - Set up app analytics
   - Plan release strategy

4. **Post-launch**
   - Monitor crash reports
   - Gather user feedback
   - Plan feature updates
   - Maintain backend compatibility

---

**🎉 Success!** Your SkinCheck Flutter mobile app is now ready for development, testing, and deployment to app stores!