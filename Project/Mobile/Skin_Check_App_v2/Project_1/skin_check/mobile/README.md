# SkinCheck Mobile App

This guide will help you convert the React frontend into a mobile APK using Capacitor.

## 🚀 Quick Start - Convert to Mobile App

### Option 1: Using Capacitor (Recommended)

Capacitor allows you to convert your React app into a native mobile app.

#### Step 1: Install Capacitor

```bash
cd frontend
npm install @capacitor/core @capacitor/cli
npm install @capacitor/android @capacitor/ios
```

#### Step 2: Initialize Capacitor

```bash
npx cap init SkinCheck com.skincheck.app
```

#### Step 3: Build the React App

```bash
npm run build
```

#### Step 4: Add Mobile Platforms

```bash
# Add Android
npx cap add android

# Add iOS (Mac only)
npx cap add ios
```

#### Step 5: Configure for Mobile

Create `capacitor.config.ts`:

```typescript
import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.skincheck.app',
  appName: 'SkinCheck',
  webDir: 'dist',
  server: {
    androidScheme: 'https',
    // Point to your backend server
    url: 'http://YOUR_SERVER_IP:5000',
    cleartext: true
  },
  plugins: {
    Camera: {
      permissions: ['camera', 'photos']
    },
    PushNotifications: {
      presentationOptions: ['badge', 'sound', 'alert']
    }
  }
};

export default config;
```

#### Step 6: Install Mobile Plugins

```bash
# Camera plugin
npm install @capacitor/camera

# Device info
npm install @capacitor/device

# Network status
npm install @capacitor/network

# Push notifications
npm install @capacitor/push-notifications

# Local storage
npm install @capacitor/preferences
```

#### Step 7: Update API Configuration

Create `frontend/src/config/mobile.ts`:

```typescript
import { Capacitor } from '@capacitor/core';

export const API_CONFIG = {
  // Replace with your server IP/domain
  BASE_URL: Capacitor.isNativePlatform() 
    ? 'http://YOUR_SERVER_IP:5000/api/v1'
    : 'http://localhost:5000/api/v1',
  
  TIMEOUT: 30000,
  RETRY_ATTEMPTS: 3
};
```

#### Step 8: Build and Run

```bash
# Sync changes
npx cap sync

# Open in Android Studio
npx cap open android

# Open in Xcode (Mac only)
npx cap open ios
```

### Option 2: Using React Native (Alternative)

If you prefer React Native, you can migrate the components:

#### Step 1: Create React Native Project

```bash
npx react-native init SkinCheckMobile
cd SkinCheckMobile
```

#### Step 2: Install Dependencies

```bash
npm install @react-navigation/native
npm install react-native-screens react-native-safe-area-context
npm install @react-navigation/bottom-tabs
npm install react-native-vector-icons
npm install react-native-image-picker
npm install @react-native-async-storage/async-storage
```

#### Step 3: Migrate Components

Convert your React components to React Native components:
- `View` instead of `div`
- `Text` instead of `p`, `h1`, etc.
- `TouchableOpacity` instead of `button`
- `Image` instead of `img`

## 📱 Mobile-Specific Features

### Camera Integration

```typescript
import { Camera, CameraResultType } from '@capacitor/camera';

const takePicture = async () => {
  const image = await Camera.getPhoto({
    quality: 90,
    allowEditing: false,
    resultType: CameraResultType.DataUrl
  });
  
  return image.dataUrl;
};
```

### Offline Storage

```typescript
import { Preferences } from '@capacitor/preferences';

// Store data
await Preferences.set({
  key: 'scanResults',
  value: JSON.stringify(scanData)
});

// Retrieve data
const { value } = await Preferences.get({ key: 'scanResults' });
const scanData = JSON.parse(value || '[]');
```

### Network Status

```typescript
import { Network } from '@capacitor/network';

const checkNetworkStatus = async () => {
  const status = await Network.getStatus();
  return status.connected;
};
```

## 🔧 Backend Configuration for Mobile

Your backend is already configured for mobile with:

- ✅ CORS enabled for mobile apps
- ✅ Longer JWT token expiration
- ✅ Mobile-specific API endpoints
- ✅ Bulk sync capabilities
- ✅ Device registration
- ✅ Offline data support

### API Endpoints for Mobile

```
GET  /api/v1/mobile/app-config     - Get app configuration
POST /api/v1/mobile/device-info    - Register device
GET  /api/v1/mobile/sync-status    - Get sync status
POST /api/v1/mobile/bulk-sync      - Bulk sync offline data
GET  /api/v1/mobile/offline-data   - Get data for offline mode
```

## 📦 Building APK

### Using Capacitor + Android Studio

1. Open Android Studio
2. Open the `android` folder from your project
3. Build → Generate Signed Bundle/APK
4. Choose APK
5. Create or use existing keystore
6. Build release APK

### Using Command Line

```bash
# Build release APK
cd android
./gradlew assembleRelease

# APK will be in: android/app/build/outputs/apk/release/
```

## 🚀 Deployment

### Backend Deployment

Deploy your backend to a cloud server:

```bash
# Build and push to server
docker build -t skincheck-backend ./backend
docker run -d -p 5000:5000 --name skincheck-api skincheck-backend
```

### Update Mobile App Configuration

Update the API URL in your mobile app to point to your deployed backend:

```typescript
const API_BASE_URL = 'https://your-server.com/api/v1';
```

## 📋 Checklist

- [ ] Backend deployed and accessible
- [ ] Mobile app built with Capacitor
- [ ] API URLs updated to production
- [ ] Camera permissions configured
- [ ] Offline storage implemented
- [ ] APK signed and ready for distribution
- [ ] Tested on physical devices

## 🔍 Testing

1. **Test offline functionality**
2. **Test camera integration**
3. **Test API connectivity**
4. **Test on different devices**
5. **Test app store compliance**

Your SkinCheck mobile app is now ready for distribution! 📱✨