-- SQL Proficiency - Clinic Management System Schema Setup

-- 1. Create clinics table
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

-- 2. Create customer table
CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

-- 3. Create clinic_sales table (Revenue)
CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10, 2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- 4. Create expenses table
CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description TEXT,
    amount DECIMAL(10, 2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- *** Sample Data Insertion (Based on PDF Snippets for testing) ***

INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('CNC-001', 'City Central Clinic', 'New York', 'NY', 'USA'),
('CNC-002', 'Lakeside Health', 'Chicago', 'IL', 'USA');

INSERT INTO customer (uid, name, mobile) VALUES
('CST-001', 'Jon Doe', '97000000001'),
('CST-002', 'Jane Smith', '97000000002');

-- Data for September 2021 and October 2021
INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
-- September Sales - CNC-001
('ORD-001', 'CST-001', 'CNC-001', 5000.00, '2021-09-01 10:00:00', 'Direct'),
('ORD-002', 'CST-001', 'CNC-001', 2000.00, '2021-09-15 11:30:00', 'Referral'),
('ORD-003', 'CST-002', 'CNC-001', 1000.00, '2021-09-20 09:00:00', 'Direct'),
-- September Sales - CNC-002
('ORD-004', 'CST-002', 'CNC-002', 4000.00, '2021-09-05 14:00:00', 'Direct'),
-- October Sales
('ORD-005', 'CST-001', 'CNC-001', 3000.00, '2021-10-01 15:00:00', 'Referral');

INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
-- September Expenses
('EXP-001', 'CNC-001', 'Rent', 1000.00, '2021-09-01 09:00:00'),
('EXP-002', 'CNC-002', 'Supplies', 500.00, '2021-09-10 12:00:00'),
-- October Expenses
('EXP-003', 'CNC-001', 'Utilities', 800.00, '2021-10-05 10:00:00');