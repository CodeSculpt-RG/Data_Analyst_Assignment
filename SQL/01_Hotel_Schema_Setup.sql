-- SQL Proficiency - Hotel Management System Schema Setup

-- DROP TABLE statements (Optional, for clean recreation)
-- DROP TABLE IF EXISTS booking_commercials;
-- DROP TABLE IF EXISTS items;
-- DROP TABLE IF EXISTS bookings;
-- DROP TABLE IF EXISTS users;

-- 1. Create users table
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

-- 2. Create items table
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10, 2)
);

-- 3. Create bookings table
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 4. Create booking_commercials table
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10, 2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- *** Sample Data Insertion (Based on PDF Snippets for testing) ***
-- Note: You should expand this data to test all queries (especially Q4 and Q5).

INSERT INTO users (user_id, name, phone_number, mail_id) VALUES 
('USR-001', 'John Doe', '9700000001', 'john.doe@example.co'),
('USR-002', 'Alice Smith', '9700000002', 'alice.smith@example.co');

INSERT INTO items (item_id, item_name, item_rate) VALUES 
('ITM-001', 'Tawa Paratha', 18.00),
('ITM-002', 'Coffee', 50.00),
('ITM-003', 'Mix Veg', 89.00),
('ITM-004', 'Mineral Water', 30.00);

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES 
('BK-001', '2021-09-23 07:36:48', 'RM-101', 'USR-001'),
('BK-002', '2021-11-05 15:00:00', 'RM-203', 'USR-001'), -- Nov 2021 booking
('BK-003', '2021-10-15 10:00:00', 'RM-105', 'USR-002'); -- Oct 2021 booking

INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES 
('BC-001', 'BK-001', 'BL-001', '2021-09-23 12:03:22', 'ITM-001', 3),
('BC-002', 'BK-001', 'BL-001', '2021-09-23 12:03:22', 'ITM-002', 2),
('BC-003', 'BK-003', 'BL-002', '2021-10-15 11:30:00', 'ITM-003', 10), -- Bill amount: 890 (October)
('BC-004', 'BK-002', 'BL-003', '2021-11-05 16:00:00', 'ITM-004', 50), -- Bill amount: 1500 (November)
('BC-005', 'BK-003', 'BL-004', '2021-10-16 18:00:00', 'ITM-001', 100); -- Bill amount: 1800 (October, > 1000)