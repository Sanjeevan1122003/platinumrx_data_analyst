-- Create Clinic Management Database
CREATE DATABASE IF NOT EXISTS clinic_management;
USE clinic_management;

-- Create clinic_sales table
CREATE TABLE clinic_sales (
    sale_id INT PRIMARY KEY,
    sales_channel VARCHAR(50),
    amount DECIMAL(10,2),
    sale_date DATE,
    clinic_id INT
);

-- Create expenses table
CREATE TABLE expenses (
    expense_id INT PRIMARY KEY,
    expense_type VARCHAR(50),
    amount DECIMAL(10,2),
    expense_date DATE,
    clinic_id INT
);

-- Insert sample data
INSERT INTO clinic_sales (sale_id, sales_channel, amount, sale_date, clinic_id) VALUES
(1, 'Online', 1500.00, '2023-01-15', 1),
(2, 'In-person', 2000.00, '2023-01-20', 1),
(3, 'Phone', 1200.00, '2023-01-25', 2),
(4, 'Online', 1800.00, '2023-02-10', 1),
(5, 'In-person', 2200.00, '2023-02-15', 2),
(6, 'Phone', 900.00, '2023-02-20', 1),
(7, 'Online', 1600.00, '2023-03-05', 2),
(8, 'In-person', 1900.00, '2023-03-10', 1);

INSERT INTO expenses (expense_id, expense_type, amount, expense_date, clinic_id) VALUES
(1, 'Staff Salary', 3000.00, '2023-01-30', 1),
(2, 'Medical Supplies', 1500.00, '2023-01-15', 1),
(3, 'Rent', 2000.00, '2023-01-01', 1),
(4, 'Utilities', 500.00, '2023-01-20', 2),
(5, 'Staff Salary', 3200.00, '2023-02-28', 1),
(6, 'Medical Supplies', 1200.00, '2023-02-10', 2),
(7, 'Marketing', 800.00, '2023-02-05', 1),
(8, 'Staff Salary', 3000.00, '2023-03-30', 1),
(9, 'Equipment', 2500.00, '2023-03-15', 2);