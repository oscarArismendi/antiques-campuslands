DROP DATABASE IF EXISTS antiqueShop;
CREATE DATABASE antiqueShop;
\c antiqueShop;

-- Create Users Table
CREATE TABLE IF NOT EXISTS Users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,  
    password TEXT NOT NULL
);

-- Create Roles Table
CREATE TABLE IF NOT EXISTS Roles (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL  -- Role names usually short, restricting to 30 characters
);

-- Create Users_Roles Table (Intermediary between Users and Roles)
CREATE TABLE IF NOT EXISTS Users_Roles (
    user_id BIGINT REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    role_id BIGINT REFERENCES Roles(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

-- Create Permissions Table
CREATE TABLE IF NOT EXISTS Permissions (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL  -- Permissions names can vary but should generally be concise
);

-- Create Roles_Permissions Table (Intermediary between Roles and Permissions)
CREATE TABLE IF NOT EXISTS Roles_Permissions (
    role_id BIGINT REFERENCES Roles(id) ON DELETE CASCADE ON UPDATE CASCADE,
    permission_id BIGINT REFERENCES Permissions(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (role_id, permission_id)
);

-- Create People Table
CREATE TABLE IF NOT EXISTS People (
    id BIGSERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL, 
    lastname VARCHAR(50) NOT NULL, 
    cellphone VARCHAR(15)  -- Restricting to 15 characters for common cellphone numbers
);

-- Create Employees Table with Foreign Key to Users and People
CREATE TABLE IF NOT EXISTS Employees (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES Users(id)  ON DELETE CASCADE ON UPDATE CASCADE,
    person_id BIGINT REFERENCES People(id)  ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Clients Table with Foreign Key to Users and People
CREATE TABLE IF NOT EXISTS Clients (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES Users(id)  ON DELETE CASCADE ON UPDATE CASCADE,
    person_id BIGINT REFERENCES People(id)  ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Conditions Table
CREATE TABLE IF NOT EXISTS Conditions (
    id BIGSERIAL PRIMARY KEY,
    state VARCHAR(30) NOT NULL  -- Short descriptions like "New", "Used", etc.
);

-- Create Availabilities Table
CREATE TABLE IF NOT EXISTS Availabilities (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL  -- Availability status like "In Stock", "Out of Stock", etc.
);

-- Create Antiques Table
CREATE TABLE IF NOT EXISTS Antiques (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,  -- Antiques might have descriptive names, so allowing up to 100 characters
    description TEXT, 
    category VARCHAR(50),  -- Categories like "Furniture", "Art", etc.
    era VARCHAR(50),  -- Restricting to 50 characters for eras like "Victorian" or "1920s"
    origin VARCHAR(50),  -- Country or origin-related description
    condition_id BIGINT REFERENCES Conditions(id) ON DELETE SET NULL ON UPDATE CASCADE,
    price NUMERIC NOT NULL,
    availability_id BIGINT REFERENCES Availabilities(id) ON DELETE SET NULL ON UPDATE CASCADE,
    seller_id BIGINT REFERENCES Users(id) ON DELETE SET NULL ON UPDATE CASCADE,
    added_date TIMESTAMP DEFAULT NOW()
);

-- Create AntiquePhotos Table
CREATE TABLE IF NOT EXISTS AntiquePhotos (
    id BIGSERIAL PRIMARY KEY,
    antique_id BIGINT REFERENCES Antiques(id) ON DELETE CASCADE ON UPDATE CASCADE,
    photo_url TEXT NOT NULL  -- URLs can vary in length, no restriction applied here
);

-- Create Delivery_Status Table
CREATE TABLE IF NOT EXISTS Delivery_Status (
    id BIGSERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL  -- Delivery status names like "Shipped", "Delivered", etc.
);

-- Create Transactions Table
CREATE TABLE IF NOT EXISTS Transactions (
    id BIGSERIAL PRIMARY KEY,
    buyer_id BIGINT REFERENCES Users(id) ON DELETE SET NULL ON UPDATE CASCADE,
    antique_id BIGINT REFERENCES Antiques(id) ON DELETE CASCADE ON UPDATE CASCADE,
    sale_price NUMERIC NOT NULL,
    transaction_date TIMESTAMP DEFAULT NOW(),
    delivery_status_id BIGINT REFERENCES Delivery_Status(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Create PriceHistory Table
CREATE TABLE IF NOT EXISTS PriceHistory (
    id BIGSERIAL PRIMARY KEY,
    antique_id BIGINT REFERENCES Antiques(id) ON DELETE CASCADE ON UPDATE CASCADE,
    previous_price NUMERIC NOT NULL,
    change_date TIMESTAMP DEFAULT NOW()
);

-- Create Notification_Status Table
CREATE TABLE IF NOT EXISTS Notification_Status (
    id BIGSERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL  -- Notification status like "Sent", "Pending", etc.
);

-- Create Inventory Table
CREATE TABLE IF NOT EXISTS Inventory (
    id BIGSERIAL PRIMARY KEY,
    antique_id BIGINT REFERENCES Antiques(id) ON DELETE CASCADE ON UPDATE CASCADE,
    available_quantity INT NOT NULL,
    notification_status_id BIGINT REFERENCES Notification_Status(id) ON DELETE SET NULL ON UPDATE CASCADE
);