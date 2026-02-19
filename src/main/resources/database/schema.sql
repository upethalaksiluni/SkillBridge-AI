-- 1. Create the Database User
-- Run this as a superuser (postgres) if the user doesn't exist
CREATE USER skillbridge_user WITH PASSWORD 'SkillBridge@123';

-- 2. Create the Database
CREATE DATABASE skillbridge_db OWNER skillbridge_user;

-- Connect to skillbridge_db before running the next commands
-- \c skillbridge_db;

-- 3. Create the Users Table
CREATE TABLE users (
    user_id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    role VARCHAR(50) NOT NULL, -- STUDENT, RECRUITER, ADMIN, LECTURER
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Initial Admin User (Optional - Password is 'admin123' hashed)
-- INSERT INTO users (email, password, full_name, role)
-- VALUES ('admin@skillbridge.com', '$2a$10$8.UnVuG9HHgffUDAlk8Kn.2ndfJGfUwK6W.H5WfHk6.6y4LwJ5H6W', 'System Admin', 'ADMIN');