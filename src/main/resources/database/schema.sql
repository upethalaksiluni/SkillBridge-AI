-- =============================================================================
-- SkillBridge AI - Master Database Schema
-- Author: Delivery Team
-- Scope: Authentication, Session Management, Account Security
-- =============================================================================

-- 1. Create the Database User (Run as superuser if not exists)
-- CREATE USER skillbridge_user WITH PASSWORD 'SkillBridge@123';

-- 2. Create the Database
-- CREATE DATABASE skillbridge_db OWNER skillbridge_user;

-- Connect to the database before running the table creation
-- \c skillbridge_db;

-- -----------------------------------------------------
-- Table: users
-- Core table for all platform roles
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    user_id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    role VARCHAR(50) NOT NULL, -- STUDENT, RECRUITER, ADMIN, LECTURER

    -- Security & Account Lockout Fields
    failed_attempt INT DEFAULT 0,
    account_non_locked BOOLEAN DEFAULT true,
    lock_time TIMESTAMP,

    -- Audit Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Table: refresh_tokens
-- Handles 60-day session rotation
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS refresh_tokens (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL UNIQUE,
    token VARCHAR(255) NOT NULL UNIQUE,
    expiry_date TIMESTAMP NOT NULL,

    CONSTRAINT fk_user_refresh
        FOREIGN KEY(user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Initial Data (Optional)
-- Note: Password is 'Admin@123' BCrypt hashed
-- -----------------------------------------------------
-- INSERT INTO users (email, password, full_name, role, account_non_locked)
-- VALUES ('admin@skillbridge.ai', '$2a$10$8.UnVuG9HHgffUDAlk8Kn.2ndfJGfUwK6W.H5WfHk6.6y4LwJ5H6W', 'System Administrator', 'ADMIN', true)
-- ON CONFLICT (email) DO NOTHING;