-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS skincheck_db;
USE skincheck_db;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(120) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_active (is_active)
);

-- Create scans table
CREATE TABLE IF NOT EXISTS scans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    image_path VARCHAR(255) NOT NULL,
    result_data TEXT,
    confidence_score FLOAT,
    condition VARCHAR(100),
    recommendations TEXT,
    is_synced BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_created_at (created_at),
    INDEX idx_synced (is_synced)
);

-- Create notifications table
CREATE TABLE IF NOT EXISTS notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    type VARCHAR(50) NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_is_read (is_read),
    INDEX idx_type (type),
    INDEX idx_created_at (created_at)
);

-- Insert default admin user (password: AdminPassword123)
INSERT IGNORE INTO users (email, name, password_hash, is_active) VALUES 
('admin@skincheck.com', 'Admin User', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewVpTZ1EeUHy8R9u', TRUE);

-- Insert sample notifications
INSERT IGNORE INTO notifications (user_id, title, message, type, is_read) VALUES
(1, 'Welcome to SkinCheck', 'Welcome to SkinCheck! Your AI-powered skin health companion is ready to help you monitor your skin condition.', 'tip', FALSE),
(1, 'Monthly Skin Check Reminder', 'Time for your monthly skin self-examination. Regular checks can help detect changes early.', 'reminder', FALSE),
(1, 'New Feature: Enhanced AI Analysis', 'Our AI has been updated with improved accuracy for skin condition detection.', 'update', TRUE);