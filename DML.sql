-- Insert into Users Table
INSERT INTO Users (username, password) VALUES
('john_doe', 'password123'),
('jane_smith', 'securepass'),
('alice_jones', 'alicepass'),
('bob_brown', 'bobbypass'),
('charlie_black', 'charliepass'),
('david_white', 'davidpass'),
('emily_green', 'emilypass'),
('frank_yellow', 'frankpass'),
('george_blue', 'georgepass'),
('hannah_red', 'hannahpass');

-- Insert into Roles Table
INSERT INTO Roles (name) VALUES
('Admin'),
('Seller'),
('Buyer'),
('Manager'),
('Support'),
('Guest'),
('Editor'),
('Viewer'),
('Contributor'),
('Moderator');

-- Insert into Users_Roles Table
INSERT INTO Users_Roles (user_id, role_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert into Permissions Table
INSERT INTO Permissions (name) VALUES
('View Dashboard'),
('Edit Profile'),
('Manage Users'),
('Access Reports'),
('Delete Records'),
('Create Content'),
('Approve Requests'),
('View Logs'),
('Export Data'),
('Import Data');

-- Insert into Roles_Permissions Table
INSERT INTO Roles_Permissions (role_id, permission_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(4, 8),
(5, 9),
(6, 10);

-- Insert into People Table
INSERT INTO People (firstname, lastname, cellphone) VALUES
('John', 'Doe', '1234567890'),
('Jane', 'Smith', '0987654321'),
('Alice', 'Jones', '5551234567'),
('Bob', 'Brown', '5559876543'),
('Charlie', 'Black', '5556789012'),
('David', 'White', '5553456789'),
('Emily', 'Green', '5552345678'),
('Frank', 'Yellow', '5558765432'),
('George', 'Blue', '5557654321'),
('Hannah', 'Red', '5556543210');

-- Insert into Employees Table
INSERT INTO Employees (user_id, person_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert into Clients Table
INSERT INTO Clients (user_id, person_id) VALUES
(1, 10),
(2, 9),
(3, 8),
(4, 7),
(5, 6),
(6, 5),
(7, 4),
(8, 3),
(9, 2),
(10, 1);

-- Insert into Conditions Table
INSERT INTO Conditions (state) VALUES
('New'),
('Used'),
('Refurbished'),
('Antique'),
('Damaged'),
('Mint'),
('Good'),
('Fair'),
('Poor'),
('Excellent');

-- Insert into Availabilities Table
INSERT INTO Availabilities (name) VALUES
('In Stock'),
('Out of Stock'),
('Pre-Order'),
('Discontinued'),
('Limited Edition'),
('Backordered'),
('Available Soon'),
('Sold Out'),
('Coming Soon'),
('Exclusive');

-- Insert into Antiques Table
INSERT INTO Antiques (name, description, category, era, origin, condition_id, price, availability_id, seller_id) VALUES
('Victorian Chair', 'A beautiful Victorian-era chair.', 'Furniture', 'Victorian', 'England', 1, 150.00, 1, 1),
('Art Deco Lamp', 'An elegant Art Deco lamp.', 'Lighting', '1920s', 'France', 2, 200.00, 2, 2),
('Renaissance Painting', 'A stunning Renaissance painting.', 'Art', 'Renaissance', 'Italy', 3, 5000.00, 3, 3),
('Ming Vase', 'A rare Ming dynasty vase.', 'Ceramics', 'Ming Dynasty', 'China', 4, 10000.00, 4, 4),
('Vintage Clock', 'A charming vintage clock.', 'Clocks', '1950s', 'USA', 5, 300.00, 5, 5),
('Roman Coin', 'An ancient Roman coin.', 'Coins', 'Ancient Rome', 'Italy', 6, 100.00, 6, 6),
('Medieval Sword', 'A medieval sword from the 14th century.', 'Weapons', 'Medieval', 'Germany', 7, 1200.00, 7, 7),
('Baroque Mirror', 'An ornate Baroque mirror.', 'Decor', 'Baroque', 'France', 8, 800.00, 8, 8),
('Colonial Desk', 'A sturdy colonial-era desk.', 'Furniture', 'Colonial', 'USA', 9, 600.00, 9, 9),
('Egyptian Amulet', 'An ancient Egyptian amulet.', 'Jewelry', 'Ancient Egypt', 'Egypt', 10, 250.00, 10, 10);

-- Insert into AntiquePhotos Table
INSERT INTO AntiquePhotos (antique_id, photo_url) VALUES
(1, 'http://example.com/photos/victorian_chair.jpg'),
(2, 'http://example.com/photos/art_deco_lamp.jpg'),
(3, 'http://example.com/photos/renaissance_painting.jpg'),
(4, 'http://example.com/photos/ming_vase.jpg'),
(5, 'http://example.com/photos/vintage_clock.jpg'),
(6, 'http://example.com/photos/roman_coin.jpg'),
(7, 'http://example.com/photos/medieval_sword.jpg'),
(8, 'http://example.com/photos/baroque_mirror.jpg'),
(9, 'http://example.com/photos/colonial_desk.jpg'),
(10, 'http://example.com/photos/egyptian_amulet.jpg');

-- Insert into Delivery_Status Table
INSERT INTO Delivery_Status (status) VALUES
('Pending'),
('Shipped'),
('Delivered'),
('Returned'),
('Cancelled'),
('In Transit'),
('Out for Delivery'),
('Awaiting Pickup'),
('Delayed'),
('Lost');

-- Insert into Transactions Table
INSERT INTO Transactions (buyer_id, antique_id, sale_price, delivery_status_id) VALUES
(1, 1, 150.00, 1),
(2, 2, 200.00, 2),
(3, 3, 5000.00, 3),
(4, 4, 10000.00, 4),
(5, 5, 300.00, 5),
(6, 6, 100.00, 6),
(7, 7, 1200.00, 7),
(8, 8, 800.00, 8),
(9, 9, 600.00, 9),
(10, 10, 250.00, 10);

-- Insert into PriceHistory Table
INSERT INTO PriceHistory (antique_id, previous_price) VALUES
(1, 140.00),
(2, 190.00),
(3, 4800.00),
(4, 9500.00),
(5, 280.00),
(6, 90.00),
(7, 1100.00),
(8, 750.00),
(9, 580.00),
(10, 230.00);

-- Insert into Notification_Status Table
INSERT INTO Notification_Status (status) VALUES
('Sent'),
('Pending'),
('Failed'),
('Delivered'),
('Read'),
('Unopened'),
('Bounced'),
('Queued'),
('Expired'),
('Cancelled');

-- Insert into Inventory Table
INSERT INTO Inventory (antique_id, available_quantity, notification_status_id) VALUES
(1, 5, 1),
(2, 3, 2),
(3, 1, 3),
(4, 2, 4),
(5, 4, 5),
(6, 10, 6),
(7, 0, 7),
(8, 6, 8),
(9, 7, 9),
(10, 8, 10);