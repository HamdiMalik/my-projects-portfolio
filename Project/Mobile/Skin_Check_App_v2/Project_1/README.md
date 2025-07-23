# SkinCheck - AI-Powered Skin Health Monitoring App

A comprehensive mobile application for skin health monitoring with AI-powered analysis, built with Flutter frontend and Flask backend.

## 🏗️ Project Structure

```
Project_1/
├── skin_check/                 # Flutter Frontend
│   └── frontend/
│       ├── lib/
│       │   ├── main.dart
│       │   ├── models/
│       │   ├── providers/
│       │   ├── screens/
│       │   ├── services/
│       │   ├── utils/
│       │   └── widgets/
│       └── pubspec.yaml
└── skin_check_api/            # Flask Backend
    ├── app.py
    ├── config.py
    ├── models/
    ├── routes/
    ├── services/
    └── requirements.txt
```

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK** (>=3.10.0)
- **Python** (>=3.8)
- **MySQL** (>=8.0)
- **Android Studio** / **VS Code**
- **Android Emulator** or **Physical Device**

### Backend Setup (Flask API)

1. **Navigate to backend directory:**
   ```bash
   cd skin_check_api
   ```

2. **Create virtual environment:**
   ```bash
   python -m venv venv
   ```

3. **Activate virtual environment:**
   ```bash
   # Windows
   venv\Scripts\activate
   
   # macOS/Linux
   source venv/bin/activate
   ```

4. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

5. **Set up environment variables:**
   Create a `.env` file in `skin_check_api/` directory:
   ```env
   # Database Configuration
   MYSQL_USER=skincheck_user
   MYSQL_PASSWORD=skincheck_password
   MYSQL_HOST=localhost
   MYSQL_PORT=3306
   MYSQL_DATABASE=skincheck_db

   # JWT Configuration
   JWT_SECRET_KEY=your-super-secret-jwt-key-change-this-in-production
   SECRET_KEY=your-flask-secret-key-change-this-in-production

   # Flask Configuration
   FLASK_ENV=development
   FLASK_DEBUG=True
   ```

6. **Set up MySQL database:**
   ```sql
   CREATE DATABASE skincheck_db;
   CREATE USER 'skincheck_user'@'localhost' IDENTIFIED BY 'skincheck_password';
   GRANT ALL PRIVILEGES ON skincheck_db.* TO 'skincheck_user'@'localhost';
   FLUSH PRIVILEGES;
   ```

7. **Run database migrations:**
   ```bash
   flask db init
   flask db migrate
   flask db upgrade
   ```

8. **Start the Flask server:**
   ```bash
   python app.py
   ```
   
   The API will be available at: `http://localhost:5000/api/v1`

### Frontend Setup (Flutter)

1. **Navigate to frontend directory:**
   ```bash
   cd skin_check/frontend
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### API Base URL

The app is configured to connect to `http://10.0.2.2:5000/api/v1` (localhost for Android emulator).

To change the API URL, edit `lib/services/api_service.dart`:
```dart
static const String baseUrl = 'http://10.0.2.2:5000/api/v1';
```

### Database Configuration

Edit `skin_check_api/config.py` or set environment variables:
```python
MYSQL_USER = os.environ.get('MYSQL_USER', 'skincheck_user')
MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD', 'skincheck_password')
MYSQL_HOST = os.environ.get('MYSQL_HOST', 'localhost')
MYSQL_PORT = os.environ.get('MYSQL_PORT', '3306')
MYSQL_DATABASE = os.environ.get('MYSQL_DATABASE', 'skincheck_db')
```

## 📱 Features

### Authentication
- ✅ User registration with email validation
- ✅ Secure login with JWT tokens
- ✅ Token refresh mechanism
- ✅ Password reset functionality
- ✅ Offline authentication state

### Scan Management
- ✅ Camera integration for skin photos
- ✅ AI-powered skin analysis
- ✅ Scan history with results
- ✅ Offline scan storage
- ✅ Automatic sync when online

### User Interface
- ✅ Modern Material Design UI
- ✅ Responsive layout
- ✅ Dark/Light theme support
- ✅ Intuitive navigation
- ✅ Real-time status indicators

## 🔌 API Endpoints

### Authentication
- `POST /api/v1/auth/register` - User registration
- `POST /api/v1/auth/login` - User login
- `POST /api/v1/auth/refresh` - Token refresh
- `POST /api/v1/auth/forgot-password` - Password reset

### Scans
- `GET /api/v1/scans` - Get user scans
- `POST /api/v1/scans` - Create new scan
- `POST /api/v1/scans/sync` - Sync offline scans
- `GET /api/v1/scans/{id}` - Get specific scan
- `DELETE /api/v1/scans/{id}` - Delete scan

### Users
- `GET /api/v1/users/profile` - Get user profile
- `PUT /api/v1/users/profile` - Update profile

## 🧪 Testing

### API Testing with curl

1. **Register a new user:**
   ```bash
   curl -X POST http://localhost:5000/api/v1/auth/register \
     -H "Content-Type: application/json" \
     -d '{
       "email": "test@example.com",
       "fullName": "Test User",
       "password": "TestPass123",
       "confirmPassword": "TestPass123"
     }'
   ```

2. **Login:**
   ```bash
   curl -X POST http://localhost:5000/api/v1/auth/login \
     -H "Content-Type: application/json" \
     -d '{
       "email": "test@example.com",
       "password": "TestPass123"
     }'
   ```

3. **Get scans (with token):**
   ```bash
   curl -X GET http://localhost:5000/api/v1/scans \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
   ```

### Flutter Testing

```bash
cd skin_check/frontend
flutter test
```

## 🔒 Security Features

- **JWT Authentication** with access and refresh tokens
- **Password Hashing** using Werkzeug security
- **Input Validation** on both frontend and backend
- **CORS Configuration** for cross-origin requests
- **Secure Token Storage** using Flutter Secure Storage
- **Offline Data Protection** with local encryption

## 📊 Database Schema

### Users Table
```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(120) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    preferences TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### Scans Table
```sql
CREATE TABLE scans (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    image_path TEXT NOT NULL,
    result_condition VARCHAR(100),
    result_confidence FLOAT,
    result_recommendations TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

## 🚨 Troubleshooting

### Common Issues

1. **Connection refused error:**
   - Ensure Flask server is running on port 5000
   - Check if MySQL service is running
   - Verify database credentials in `.env` file

2. **Token authentication errors:**
   - Clear app data and re-login
   - Check JWT_SECRET_KEY in backend
   - Verify token expiration settings

3. **Flutter build errors:**
   - Run `flutter clean` and `flutter pub get`
   - Check Flutter SDK version compatibility
   - Verify all dependencies in `pubspec.yaml`

4. **Database connection issues:**
   - Verify MySQL is running and accessible
   - Check user permissions and database existence
   - Ensure correct connection string format

### Debug Mode

Enable debug logging in Flutter:
```dart
// In main.dart
void main() {
  runApp(const SkinCheckApp());
  debugPrint('Debug mode enabled');
}
```

Enable Flask debug mode:
```python
# In app.py
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
```

## 📝 Development Notes

### Token Handling
- Access tokens expire after 24 hours
- Refresh tokens expire after 30 days
- Automatic token refresh on 401 errors
- Secure token storage using Flutter Secure Storage

### Offline Support
- Scans are stored locally when offline
- Automatic sync when connection is restored
- Conflict resolution for duplicate scans
- Data integrity checks

### Performance
- Image compression before upload
- Pagination for scan history
- Lazy loading for large datasets
- Caching for frequently accessed data

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions:
- Create an issue in the repository
- Check the troubleshooting section
- Review the API documentation

---

**Note:** This is a development setup. For production deployment, ensure proper security configurations, environment variables, and SSL certificates are in place. #   S k i n _ C h e c k _ A p p  
 