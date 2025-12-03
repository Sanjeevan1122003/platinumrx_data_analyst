-- Create Hotel Management Database
CREATE DATABASE IF NOT EXISTS hotel_management;
USE hotel_management;

-- Create users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- Create rooms table
CREATE TABLE rooms (
    room_id INT PRIMARY KEY,
    room_number VARCHAR(10),
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2)
);

-- Create bookings table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    room_id INT,
    check_in_date DATE,
    check_out_date DATE,
    booking_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- Create items table
CREATE TABLE items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    category VARCHAR(50)
);

-- Create booking_commercials table
CREATE TABLE booking_commercials (
    commercial_id INT PRIMARY KEY,
    booking_id INT,
    item_id INT,
    quantity INT,
    rate DECIMAL(10,2),
    date DATE,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Insert sample data
INSERT INTO users (user_id, name, email, phone) VALUES
(1, 'John Doe', 'john@email.com', '1234567890'),
(2, 'Jane Smith', 'jane@email.com', '9876543210'),
(3, 'Bob Johnson', 'bob@email.com', '5551234567'),
(4, 'Alice Brown', 'alice@email.com', '5559876543');

INSERT INTO rooms (room_id, room_number, room_type, price_per_night) VALUES
(101, '101', 'Deluxe', 150.00),
(102, '102', 'Standard', 100.00),
(103, '103', 'Suite', 250.00),
(104, '104', 'Deluxe', 150.00);

INSERT INTO bookings (booking_id, user_id, room_id, check_in_date, check_out_date, booking_date) VALUES
(1, 1, 101, '2021-11-15', '2021-11-20', '2021-11-10'),
(2, 2, 102, '2021-11-18', '2021-11-25', '2021-11-12'),
(3, 3, 103, '2021-12-01', '2021-12-05', '2021-11-25'),
(4, 1, 104, '2021-12-10', '2021-12-15', '2021-12-01'),
(5, 4, 101, '2021-11-20', '2021-11-22', '2021-11-18');

INSERT INTO items (item_id, item_name, category) VALUES
(1, 'Breakfast', 'Food'),
(2, 'Lunch', 'Food'),
(3, 'Dinner', 'Food'),
(4, 'Laundry', 'Service'),
(5, 'Spa', 'Service');

INSERT INTO booking_commercials (commercial_id, booking_id, item_id, quantity, rate, date) VALUES
(1, 1, 1, 5, 15.00, '2021-11-16'),
(2, 1, 4, 2, 25.00, '2021-11-17'),
(3, 2, 2, 3, 20.00, '2021-11-19'),
(4, 2, 3, 2, 30.00, '2021-11-20'),
(5, 2, 5, 1, 100.00, '2021-11-21'),
(6, 3, 1, 4, 15.00, '2021-12-02'),
(7, 3, 3, 3, 30.00, '2021-12-03'),
(8, 4, 1, 6, 15.00, '2021-12-11'),
(9, 4, 4, 3, 25.00, '2021-12-12'),
(10, 5, 2, 2, 20.00, '2021-11-21');