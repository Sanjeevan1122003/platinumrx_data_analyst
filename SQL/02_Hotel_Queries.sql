USE hotel_management;

-- Q1: Which room was booked last and by which user?
SELECT 
    r.room_number,
    r.room_type,
    u.name as user_name,
    b.booking_date as last_booking_date
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
JOIN users u ON b.user_id = u.user_id
WHERE b.booking_date = (SELECT MAX(booking_date) FROM bookings)
ORDER BY b.booking_date DESC
LIMIT 1;

-- Q2: Total billing amount for bookings made in November 2021
SELECT 
    b.booking_id,
    u.name as user_name,
    r.room_number,
    SUM(bc.quantity * bc.rate) as total_billing_amount
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN rooms r ON b.room_id = r.room_id
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
WHERE MONTH(b.booking_date) = 11 AND YEAR(b.booking_date) = 2021
GROUP BY b.booking_id, u.name, r.room_number;

-- Q3: Which users have total billing amount > 1000?
SELECT 
    u.user_id,
    u.name as user_name,
    u.email,
    SUM(bc.quantity * bc.rate) as total_billing_amount
FROM users u
JOIN bookings b ON u.user_id = b.user_id
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
GROUP BY u.user_id, u.name, u.email
HAVING SUM(bc.quantity * bc.rate) > 1000;

-- Q4: Most and least ordered item month-wise
WITH monthly_item_orders AS (
    SELECT 
        DATE_FORMAT(bc.date, '%Y-%m') as month,
        i.item_name,
        SUM(bc.quantity) as total_quantity,
        ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(bc.date, '%Y-%m') ORDER BY SUM(bc.quantity) DESC) as rank_desc,
        ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(bc.date, '%Y-%m') ORDER BY SUM(bc.quantity) ASC) as rank_asc
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY DATE_FORMAT(bc.date, '%Y-%m'), i.item_name
)
SELECT 
    month,
    MAX(CASE WHEN rank_desc = 1 THEN CONCAT(item_name, ' (', total_quantity, ')') END) as most_ordered_item,
    MAX(CASE WHEN rank_asc = 1 THEN CONCAT(item_name, ' (', total_quantity, ')') END) as least_ordered_item
FROM monthly_item_orders
GROUP BY month;

-- Q5: 2nd highest billing amount and corresponding user
WITH billing_rank AS (
    SELECT 
        u.name as user_name,
        SUM(bc.quantity * bc.rate) as total_billing_amount,
        DENSE_RANK() OVER (ORDER BY SUM(bc.quantity * bc.rate) DESC) as billing_rank
    FROM users u
    JOIN bookings b ON u.user_id = b.user_id
    JOIN booking_commercials bc ON b.booking_id = bc.booking_id
    GROUP BY u.user_id, u.name
)
SELECT 
    user_name,
    total_billing_amount
FROM billing_rank
WHERE billing_rank = 2;