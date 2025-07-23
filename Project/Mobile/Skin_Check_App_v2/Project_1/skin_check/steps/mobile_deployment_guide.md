# 📱 SkinCheck Mobile App Deployment Guide

This guide covers deploying the SkinCheck backend for mobile apps and converting the frontend to an APK.

## 🏗️ Architecture Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│                 │    │                 │    │                 │
│   Mobile App    │◄──►│   Backend API   │◄──►│   MySQL DB      │
│   (.apk file)   │    │   (Docker)      │    │   (Docker)      │
│                 │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🚀 Step 1: Deploy Backend to Server

### Option A: Deploy to VPS/Cloud Server

1. **Get a server** (DigitalOcean, AWS, Google Cloud, etc.)

2. **Install Docker on server**:
   ```bash
   # Ubuntu/Debian
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   sudo usermod -aG docker $USER
   ```

3. **Upload your code**:
   ```bash
   # From your local machine
   scp -r skincheck-app/ user@your-server-ip:/home/user/
   ```

4. **Deploy on server**:
   ```bash
   ssh user@your-server-ip
   cd skincheck-app
   
   # Update environment variables
   nano backend/.env
   # Set production values
   
   # Start services
   docker-compose up -d
   ```

### Option B: Deploy to Cloud Platform

#### Heroku Deployment

1. **Install Heroku CLI**
2. **Create Heroku app**:
   ```bash
   heroku create skincheck-api
   heroku addons:create cleardb:ignite  # MySQL addon
   ```

3. **Deploy**:
   ```bash
   git subtree push --prefix backend heroku main
   ```

#### Railway Deployment

1. **Connect GitHub repo to Railway**
2. **Add MySQL database**
3. **Set environment variables**
4. **Deploy automatically**

## 🔧 Step 2: Configure Backend for Mobile

Your backend is already mobile-ready with these features:

### ✅ Mobile API Features

- **CORS enabled** for mobile apps
- **Longer JWT tokens** (30 days for mobile)
- **Bulk sync endpoints** for offline data
- **Device registration** for push notifications
- **Mobile-specific configuration** endpoints
- **Large file upload** support (50MB)

### 🔗 API Endpoints

```
Base URL: https://your-server.com/api/v1

Authentication:
POST /auth/login
POST /auth/register
POST /auth/refresh

Mobile Specific:
GET  /mobile/app-config
POST /mobile/device-info
GET  /mobile/sync-status
POST /mobile/bulk-sync
GET  /mobile/offline-data

Scans:
GET  /scans
POST /scans
POST /scans/sync

Users:
GET  /users/profile
PUT  /users/profile

Notifications:
GET  /notifications
PUT  /notifications/{id}/read
```

## 📱 Step 3: Convert Frontend to Mobile App

### Method 1: Capacitor (Recommended)

Capacitor wraps your React app in a native container.

#### 3.1 Install Capacitor

```bash
cd frontend
npm install @capacitor/core @capacitor/cli
npm install @capacitor/android @capacitor/ios
```

#### 3.2 Initialize Capacitor

```bash
npx cap init SkinCheck com.skincheck.app
```

#### 3.3 Configure for Mobile

Create `frontend/capacitor.config.ts`:

```typescript
import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.skincheck.app',
  appName: 'SkinCheck',
  webDir: 'dist',
  server: {
    androidScheme: 'https',
    url: 'https://your-server.com',  // Your backend URL
    cleartext: true
  },
  plugins: {
    Camera: {
      permissions: ['camera', 'photos']
    }
  }
};

export default config;
```

#### 3.4 Update API Configuration

Create `frontend/src/config/api.ts`:

```typescript
export const API_CONFIG = {
  BASE_URL: 'https://your-server.com/api/v1',  // Your deployed backend
  TIMEOUT: 30000,
  RETRY_ATTEMPTS: 3
};
```

Update `frontend/src/utils/api.ts`:

```typescript
import { API_CONFIG } from '../config/api';

const API_BASE_URL = API_CONFIG.BASE_URL;
// ... rest of your API code
```

#### 3.5 Install Mobile Plugins

```bash
npm install @capacitor/camera
npm install @capacitor/device
npm install @capacitor/network
npm install @capacitor/preferences
npm install @capacitor/push-notifications
```

#### 3.6 Build and Add Platforms

```bash
# Build React app
npm run build

# Add Android platform
npx cap add android

# Sync changes
npx cap sync
```

#### 3.7 Build APK

```bash
# Open in Android Studio
npx cap open android

# In Android Studio:
# 1. Build → Generate Signed Bundle/APK
# 2. Choose APK
# 3. Create keystore (first time)
# 4. Build release APK
```

### Method 2: React Native (Alternative)

If you prefer React Native, migrate your components:

```bash
npx react-native init SkinCheckMobile
cd SkinCheckMobile

# Install dependencies
npm install @react-navigation/native
npm install react-native-screens react-native-safe-area-context
npm install @react-navigation/bottom-tabs
npm install react-native-vector-icons
npm install react-native-image-picker
npm install @react-native-async-storage/async-storage
```

## 🔐 Step 4: Security Configuration

### Backend Security

1. **Environment Variables**:
   ```bash
   # backend/.env
   SECRET_KEY=your-super-secure-secret-key
   JWT_SECRET_KEY=your-jwt-secret-key
   DB_PASSWORD=your-secure-db-password
   ```

2. **HTTPS Setup** (using Let's Encrypt):
   ```bash
   # On your server
   sudo apt install certbot
   sudo certbot --nginx -d your-domain.com
   ```

3. **Firewall Configuration**:
   ```bash
   sudo ufw allow 22    # SSH
   sudo ufw allow 80    # HTTP
   sudo ufw allow 443   # HTTPS
   sudo ufw enable
   ```

### Mobile App Security

1. **API Key Protection**: Store sensitive keys in environment variables
2. **Certificate Pinning**: Pin your server's SSL certificate
3. **Obfuscation**: Obfuscate your APK before release

## 📊 Step 5: Testing

### Backend Testing

```bash
# Test API health
curl https://your-server.com/api/health

# Test authentication
curl -X POST https://your-server.com/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{"fullName":"Test User","email":"test@example.com","password":"TestPassword123","confirmPassword":"TestPassword123"}'
```

### Mobile App Testing

1. **Install APK on device**
2. **Test offline functionality**
3. **Test camera integration**
4. **Test API connectivity**
5. **Test sync functionality**

## 🚀 Step 6: Distribution

### Google Play Store

1. **Create Developer Account** ($25 one-time fee)
2. **Prepare Store Listing**:
   - App name: SkinCheck
   - Description: AI-powered skin health monitoring
   - Screenshots: Take from your app
   - Privacy Policy: Required for health apps

3. **Upload APK**:
   - Use signed release APK
   - Set target API level
   - Add app permissions explanation

4. **Review Process**: Usually 1-3 days

### Alternative Distribution

- **Direct APK Download**: Host APK on your website
- **Firebase App Distribution**: For beta testing
- **Amazon Appstore**: Alternative to Google Play

## 📋 Deployment Checklist

### Backend Deployment
- [ ] Server/cloud platform ready
- [ ] Docker containers running
- [ ] Database connected and initialized
- [ ] HTTPS/SSL configured
- [ ] Environment variables set
- [ ] API endpoints tested
- [ ] CORS configured for mobile

### Mobile App
- [ ] Capacitor configured
- [ ] API URLs updated to production
- [ ] Mobile plugins installed
- [ ] Camera permissions configured
- [ ] Offline storage implemented
- [ ] APK built and signed
- [ ] Tested on physical devices
- [ ] Store listing prepared

### Security
- [ ] Secrets properly configured
- [ ] HTTPS enabled
- [ ] Firewall configured
- [ ] API rate limiting enabled
- [ ] Input validation implemented

## 🔧 Troubleshooting

### Common Issues

1. **CORS Errors**:
   - Check backend CORS configuration
   - Verify API URLs in mobile app

2. **Network Errors**:
   - Test API endpoints manually
   - Check server firewall settings
   - Verify HTTPS configuration

3. **Build Errors**:
   - Clear node_modules and reinstall
   - Check Capacitor configuration
   - Verify Android SDK setup

4. **Camera Not Working**:
   - Check permissions in AndroidManifest.xml
   - Test on physical device (not emulator)

### Support Commands

```bash
# Check backend logs
docker-compose logs backend

# Rebuild mobile app
npx cap sync android

# Clean build
cd android && ./gradlew clean

# Check API connectivity
curl -I https://your-server.com/api/health
```

## 🎉 Success!

Your SkinCheck mobile app is now:
- ✅ Deployed as a native mobile app (.apk)
- ✅ Connected to a cloud-hosted backend
- ✅ Ready for distribution
- ✅ Fully functional offline and online

Users can now download and install your SkinCheck app on their Android devices! 📱✨