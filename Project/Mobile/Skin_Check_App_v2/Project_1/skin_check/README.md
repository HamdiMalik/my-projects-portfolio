# SkinCheck - AI-Powered Mobile Skin Health Monitor

A comprehensive mobile application for skin cancer detection and monitoring, featuring AI-powered analysis, offline functionality, and secure cloud synchronization.

## 📱 Mobile App Features

### Frontend (React → Mobile APK)
- **🤳 Native Camera**: Capture skin images directly in the mobile app
- **🤖 AI Analysis**: AI-powered skin condition detection
- **📱 Offline Support**: Works completely offline with local storage
- **☁️ Cloud Sync**: Automatic synchronization when connected
- **📊 Scan History**: Track and monitor skin changes over time
- **🔐 User Authentication**: Secure login and registration
- **🔔 Push Notifications**: Mobile notifications for reminders
- **📚 Education**: Comprehensive skin health information

### Backend (Flask + SQLAlchemy - Mobile Ready)
- **🛡️ JWT Authentication**: Extended sessions for mobile (30 days)
- **🗄️ MySQL Database**: Robust data persistence
- **📁 Large File Upload**: 50MB support for high-quality mobile images
- **🔄 Bulk Sync**: Efficient offline data synchronization
- **📱 Mobile API**: Dedicated mobile endpoints (v1)
- **🔒 Security**: CORS, rate limiting, input validation
- **📈 Scalable**: Docker containerized for easy deployment

## 🏗️ Mobile Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│                 │    │                 │    │                 │
│   Mobile App    │◄──►│   Backend API   │◄──►│   MySQL DB      │
│   (.apk file)   │    │   (Docker)      │    │   (Docker)      │
│                 │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🚀 Quick Start - Mobile Deployment

### 1. Deploy Backend to Server

```bash
# Clone the project
git clone <repository-url>
cd skincheck-app

# Deploy backend to your server
docker-compose up -d

# Your API will be available at: http://your-server:5000/api/v1
```

### 2. Convert Frontend to Mobile App

```bash
cd frontend

# Install Capacitor
npm install @capacitor/core @capacitor/cli
npm install @capacitor/android

# Initialize mobile app
npx cap init SkinCheck com.skincheck.app

# Build React app
npm run build

# Add Android platform
npx cap add android

# Open in Android Studio to build APK
npx cap open android
```

### 3. Build APK

In Android Studio:
1. Build → Generate Signed Bundle/APK
2. Choose APK
3. Create keystore (first time)
4. Build release APK

## 📱 Mobile-Specific API Endpoints

```
Base URL: https://your-server.com/api/v1

Mobile Features:
GET  /mobile/app-config     - Get mobile app configuration
POST /mobile/device-info    - Register device for push notifications
GET  /mobile/sync-status    - Get synchronization status
POST /mobile/bulk-sync      - Bulk sync offline data
GET  /mobile/offline-data   - Get essential data for offline mode

Authentication (Extended for Mobile):
POST /auth/login           - Login (30-day JWT tokens)
POST /auth/register        - Register new user
POST /auth/refresh         - Refresh access token

Scans:
GET  /scans               - Get scan history
POST /scans               - Create new scan
POST /scans/sync          - Sync offline scans

Users:
GET  /users/profile       - Get user profile
PUT  /users/profile       - Update user profile

Notifications:
GET  /notifications       - Get notifications
PUT  /notifications/{id}/read - Mark as read
```

## 🔧 Mobile Configuration

### Backend Configuration (Mobile-Ready)

The backend is pre-configured for mobile with:

- ✅ **CORS enabled** for mobile apps
- ✅ **Extended JWT tokens** (30 days)
- ✅ **Large file uploads** (50MB)
- ✅ **Bulk sync endpoints**
- ✅ **Device registration**
- ✅ **Mobile API versioning** (/api/v1)
- ✅ **Rate limiting** protection
- ✅ **Offline data support**

### Frontend Mobile Features

- ✅ **Capacitor integration** ready
- ✅ **Camera plugin** support
- ✅ **Offline storage** with sync
- ✅ **Network detection**
- ✅ **Push notifications** ready
- ✅ **Mobile-optimized UI**

## 📦 Project Structure

```
skincheck-app/
├── frontend/                 # React app (converts to mobile)
│   ├── src/
│   ├── capacitor.config.ts   # Mobile configuration
│   └── android/              # Generated Android project
├── backend/                  # Flask API (mobile-ready)
│   ├── app/
│   │   ├── routes/mobile_routes.py    # Mobile-specific endpoints
│   │   ├── controllers/mobile_controller.py
│   │   └── models/device.py           # Device registration
│   ├── config.py             # Mobile configuration
│   └── Dockerfile
├── mobile/                   # Mobile conversion guide
│   └── README.md
├── steps/                    # Deployment guides
│   └── mobile_deployment_guide.md
├── nginx/                    # Reverse proxy for mobile API
│   └── nginx.conf
└── docker-compose.yml        # Mobile-ready containers
```

## 🔒 Mobile Security Features

- **JWT Authentication**: Extended 30-day sessions for mobile
- **Device Registration**: Track and manage user devices
- **Rate Limiting**: API protection against abuse
- **CORS Configuration**: Secure cross-origin requests
- **Input Validation**: Comprehensive data validation
- **File Upload Security**: Secure image processing
- **HTTPS Support**: SSL/TLS encryption ready

## 🌐 Deployment Options

### Cloud Platforms
- **DigitalOcean**: $5/month droplet
- **AWS EC2**: Free tier available
- **Google Cloud**: $300 free credits
- **Heroku**: Easy deployment with addons
- **Railway**: Git-based deployment

### Mobile Distribution
- **Google Play Store**: Official Android distribution
- **Direct APK**: Host on your website
- **Firebase App Distribution**: Beta testing
- **Amazon Appstore**: Alternative distribution

## 🧪 Testing Mobile App

### Backend Testing
```bash
# Test API health
curl https://your-server.com/api/health

# Test mobile config
curl https://your-server.com/api/v1/mobile/app-config

# Test authentication
curl -X POST https://your-server.com/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{"fullName":"Test User","email":"test@example.com","password":"TestPassword123","confirmPassword":"TestPassword123"}'
```

### Mobile App Testing
1. Install APK on Android device
2. Test camera functionality
3. Test offline mode
4. Test sync when online
5. Test push notifications

## 📊 Mobile App Features

### Core Features
- ✅ **Skin Scanning**: Camera-based skin analysis
- ✅ **AI Analysis**: Condition detection with confidence scores
- ✅ **Offline Mode**: Full functionality without internet
- ✅ **Sync**: Automatic cloud synchronization
- ✅ **History**: Track scans over time
- ✅ **Education**: Skin health information

### Mobile-Specific Features
- ✅ **Native Camera**: Direct camera access
- ✅ **Local Storage**: Offline data persistence
- ✅ **Push Notifications**: Health reminders
- ✅ **Biometric Auth**: Fingerprint/face unlock (ready)
- ✅ **Background Sync**: Sync when app is closed
- ✅ **Network Detection**: Smart online/offline handling

## 🔧 Development

### Local Development
```bash
# Backend
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python run.py

# Frontend (for web testing)
cd frontend
npm install
npm run dev

# Mobile development
npx cap run android --livereload
```

### Building for Production
```bash
# Build backend
docker build -t skincheck-backend ./backend

# Build mobile app
cd frontend
npm run build
npx cap sync android
npx cap open android  # Build APK in Android Studio
```

## 📝 Documentation

- **[Mobile Deployment Guide](steps/mobile_deployment_guide.md)** - Complete mobile deployment
- **[Mobile Conversion Guide](mobile/README.md)** - Convert React to APK
- **[API Documentation](backend/README.md)** - Backend API reference
- **[Setup Instructions](steps/setup_instructions.md)** - Local development setup

## 🎯 Mobile App Success Metrics

Your mobile app is ready when:
- ✅ APK installs and runs on Android devices
- ✅ Camera captures and analyzes skin images
- ✅ Offline mode works without internet
- ✅ Data syncs when connected to internet
- ✅ User authentication works smoothly
- ✅ Push notifications are received
- ✅ App passes Google Play Store requirements

## 🚀 Next Steps

1. **Deploy Backend**: Choose a cloud platform and deploy
2. **Build APK**: Use Capacitor + Android Studio
3. **Test Thoroughly**: Test on multiple devices
4. **Submit to Store**: Prepare for Google Play Store
5. **Monitor**: Set up analytics and crash reporting

---

**📱 Ready for Mobile!** Your SkinCheck app is now configured for mobile deployment. Follow the guides in the `mobile/` and `steps/` folders to build your APK and deploy to production!