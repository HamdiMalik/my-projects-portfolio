# SkinCheck Flutter Mobile App

A Flutter-based mobile application for AI-powered skin health monitoring with offline functionality and cloud synchronization.

## 🚀 Features

- **📱 Native Mobile App**: Built with Flutter for Android and iOS
- **🤳 Camera Integration**: Native camera access for skin scanning
- **🤖 AI Analysis**: Mock AI-powered skin condition detection
- **📱 Offline Support**: Full functionality without internet connection
- **☁️ Cloud Sync**: Automatic synchronization when connected
- **🔐 Secure Authentication**: JWT-based user authentication
- **📊 Scan History**: Local and cloud-based scan tracking
- **🔔 Notifications**: In-app notification system
- **📚 Educational Content**: Comprehensive skin health information

## 🏗️ Architecture

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user.dart
│   ├── scan.dart
│   └── notification.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   ├── scan_provider.dart
│   └── notification_provider.dart
├── services/                 # External services
│   ├── api_service.dart
│   └── storage_service.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── main_screen.dart
│   ├── home_screen.dart
│   ├── scan_screen.dart
│   ├── camera_screen.dart
│   ├── profile_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── history_screen.dart
│   └── notification_screen.dart
├── widgets/                  # Reusable widgets
│   ├── top_navigation.dart
│   └── bottom_navigation.dart
└── utils/                    # Utilities
    └── theme.dart
```

## 📱 Getting Started

### Prerequisites

- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd frontend
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API endpoint**
   
   Update the API base URL in `lib/services/api_service.dart`:
   ```dart
   static const String baseUrl = 'http://YOUR_SERVER_IP:5000/api/v1';
   ```

4. **Run the app**
   ```bash
   # Debug mode
   flutter run
   
   # Release mode
   flutter run --release
   ```

## 🔧 Building for Production

### Android APK

1. **Build APK**
   ```bash
   flutter build apk --release
   ```

2. **Build App Bundle (recommended for Play Store)**
   ```bash
   flutter build appbundle --release
   ```

3. **Generated files location**
   - APK: `build/app/outputs/flutter-apk/app-release.apk`
   - Bundle: `build/app/outputs/bundle/release/app-release.aab`

### iOS (macOS only)

1. **Build iOS app**
   ```bash
   flutter build ios --release
   ```

2. **Open in Xcode for distribution**
   ```bash
   open ios/Runner.xcworkspace
   ```

## 📦 Dependencies

### Core Dependencies
- `flutter`: SDK
- `provider`: State management
- `http` & `dio`: HTTP client
- `shared_preferences`: Local storage
- `flutter_secure_storage`: Secure token storage
- `sqflite`: Local database

### Camera & Media
- `camera`: Camera access
- `image_picker`: Image selection
- `image`: Image processing
- `permission_handler`: Permissions

### UI & Utils
- `cached_network_image`: Image caching
- `intl`: Internationalization
- `uuid`: Unique identifiers
- `connectivity_plus`: Network status

## 🔐 Permissions

The app requires the following permissions:

### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to scan skin conditions</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to save scan images</string>
```

## 🌐 API Integration

The app connects to a Flask backend API with the following endpoints:

### Authentication
- `POST /auth/login` - User login
- `POST /auth/register` - User registration
- `POST /auth/refresh` - Token refresh
- `POST /auth/forgot-password` - Password reset

### User Management
- `GET /users/profile` - Get user profile
- `PUT /users/profile` - Update user profile

### Scans
- `GET /scans` - Get scan history
- `POST /scans` - Create new scan
- `POST /scans/sync` - Sync offline scans

### Notifications
- `GET /notifications` - Get notifications
- `PUT /notifications/{id}/read` - Mark as read

### Mobile-Specific
- `GET /mobile/app-config` - Get app configuration
- `POST /mobile/device-info` - Register device

## 💾 Offline Functionality

The app works completely offline with the following features:

1. **Local Storage**: All scan data is stored locally using SQLite
2. **Offline Scanning**: Camera and AI analysis work without internet
3. **Automatic Sync**: Data syncs to cloud when connection is restored
4. **Conflict Resolution**: Smart merging of local and cloud data

## 🎨 Theming

The app uses a custom theme defined in `lib/utils/theme.dart`:

- **Primary Colors**: Blue gradient (#3B82F6 to #1D4ED8)
- **Secondary Colors**: Green, Orange, Red, Purple
- **Typography**: Inter font family
- **Components**: Material Design 3 with custom styling

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

## 📱 Platform-Specific Features

### Android
- **Adaptive Icons**: Supports Android adaptive icons
- **Permissions**: Runtime permission handling
- **Background Sync**: Background data synchronization
- **Deep Links**: Support for app deep linking

### iOS
- **App Transport Security**: HTTPS enforcement
- **Background App Refresh**: Background sync capabilities
- **Universal Links**: iOS universal link support
- **Privacy**: iOS 14+ privacy compliance

## 🔧 Configuration

### Environment Variables

Create different configurations for development and production:

```dart
// lib/config/environment.dart
class Environment {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:5000/api/v1',
  );
  
  static const bool isProduction = bool.fromEnvironment('PRODUCTION');
}
```

### Build Flavors

Configure different app flavors:

```bash
# Development
flutter run --flavor dev --dart-define=API_BASE_URL=http://localhost:5000/api/v1

# Production
flutter run --flavor prod --dart-define=API_BASE_URL=https://api.skincheck.com/v1 --dart-define=PRODUCTION=true
```

## 🚀 Deployment

### Google Play Store

1. **Prepare for release**
   - Update version in `pubspec.yaml`
   - Generate signed APK/Bundle
   - Test on multiple devices

2. **Store listing requirements**
   - App icon (512x512 PNG)
   - Screenshots (phone, tablet)
   - Feature graphic (1024x500)
   - Privacy policy URL
   - App description

3. **Upload to Play Console**
   - Create app listing
   - Upload app bundle
   - Set up release management
   - Submit for review

### Apple App Store

1. **Prepare for release**
   - Update version in `ios/Runner/Info.plist`
   - Build with Xcode
   - Test on physical devices

2. **App Store Connect**
   - Create app record
   - Upload build via Xcode
   - Fill app information
   - Submit for review

## 🔍 Debugging

### Common Issues

1. **Camera not working**
   - Check permissions in AndroidManifest.xml
   - Test on physical device (not emulator)
   - Verify camera plugin installation

2. **API connection issues**
   - Check network permissions
   - Verify API endpoint URL
   - Test with HTTP client tools

3. **Build failures**
   - Clean build: `flutter clean && flutter pub get`
   - Check dependency versions
   - Verify platform-specific configurations

### Debug Tools

```bash
# Flutter inspector
flutter inspector

# Performance profiling
flutter run --profile

# Debug APK analysis
flutter build apk --analyze-size

# Verbose logging
flutter run -v
```

## 📊 Performance Optimization

### App Size Optimization
- Use `--split-per-abi` for smaller APKs
- Enable ProGuard/R8 for code shrinking
- Optimize images and assets
- Remove unused dependencies

### Runtime Performance
- Use `const` constructors where possible
- Implement lazy loading for large lists
- Optimize image loading and caching
- Use efficient state management

### Memory Management
- Dispose controllers and streams
- Use weak references for callbacks
- Monitor memory usage with DevTools
- Implement proper lifecycle management

## 🔒 Security

### Data Protection
- Secure token storage with FlutterSecureStorage
- Local database encryption
- Network certificate pinning
- Input validation and sanitization

### Privacy Compliance
- GDPR compliance for EU users
- CCPA compliance for California users
- Clear privacy policy
- User consent management

## 📈 Analytics & Monitoring

### Crash Reporting
```dart
// Add Firebase Crashlytics
dependencies:
  firebase_crashlytics: ^3.4.8
```

### Performance Monitoring
```dart
// Add Firebase Performance
dependencies:
  firebase_performance: ^0.9.3+8
```

### User Analytics
```dart
// Add Firebase Analytics
dependencies:
  firebase_analytics: ^10.7.4
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**📱 Ready for Mobile!** Your SkinCheck Flutter app is now ready for development and deployment to app stores.