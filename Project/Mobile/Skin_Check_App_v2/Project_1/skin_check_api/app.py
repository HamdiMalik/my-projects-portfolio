from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_jwt_extended import JWTManager
from flask_cors import CORS
import logging

from config import Config
from models import db
from routes.auth import auth_bp
from routes.users import users_bp
from routes.scans import scans_bp
from routes.notifications import notifications_bp
from routes.mobile import mobile_bp

# Inisialisasi global instance
jwt = JWTManager()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Inisialisasi ekstensi
    db.init_app(app)
    Migrate(app, db)
    jwt.init_app(app)
    CORS(app, origins=["*"])  # Boleh diatur lebih spesifik jika dibutuhkan

    # Register blueprint endpoint
    app.register_blueprint(auth_bp, url_prefix='/api/v1/auth')
    app.register_blueprint(users_bp, url_prefix='/api/v1/users')
    app.register_blueprint(scans_bp, url_prefix='/api/v1/scans')
    app.register_blueprint(notifications_bp, url_prefix='/api/v1/notifications')
    app.register_blueprint(mobile_bp, url_prefix='/api/v1/mobile')

    # Health check endpoint
    @app.route('/api/v1/health')
    def health_check():
        return jsonify({'status': 'healthy', 'service': 'skincheck-api'}), 200

    # Error handlers
    @app.errorhandler(404)
    def not_found(error):
        return jsonify({'error': 'Endpoint not found'}), 404

    @app.errorhandler(500)
    def internal_error(error):
        return jsonify({'error': 'Internal server error'}), 500

    # Logging (opsional)
    app.logger.setLevel(logging.INFO)
    app.logger.info("✅ SkinCheck API started and running")

    return app

# JWT error handlers
@jwt.expired_token_loader
def expired_token_callback(jwt_header, jwt_payload):
    return jsonify({'error': 'Token has expired'}), 401

@jwt.invalid_token_loader
def invalid_token_callback(error):
    return jsonify({'error': 'Invalid token'}), 401

@jwt.unauthorized_loader
def missing_token_callback(error):
    return jsonify({'error': 'Authorization token is required'}), 401

# Gunicorn akan menggunakan ini
app = create_app()

# Untuk development lokal
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

# Scan endpoint sudah dipindah ke routes/scans.py dengan endpoint /api/v1/scan
