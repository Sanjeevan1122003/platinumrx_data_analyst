USE clinic_management;

-- Q1: Total revenue by sales channel
SELECT 
    sales_channel,
    COUNT(*) as total_transactions,
    SUM(amount) as total_revenue,
    AVG(amount) as average_revenue_per_sale
FROM clinic_sales
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- Q2: Month-wise revenue growth
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') as month,
    SUM(amount) as monthly_revenue,
    LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m')) as previous_month_revenue,
    ROUND(
        ((SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m'))) / 
        LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m'))) * 100, 2
    ) as growth_percentage
FROM clinic_sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY month;

-- Q3: Month-wise profit/loss
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(sale_date, '%Y-%m') as month,
        SUM(amount) as total_revenue
    FROM clinic_sales
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
),
monthly_expenses AS (
    SELECT 
        DATE_FORMAT(expense_date, '%Y-%m') as month,
        SUM(amount) as total_expenses
    FROM expenses
    GROUP BY DATE_FORMAT(expense_date, '%Y-%m')
)
SELECT 
    COALESCE(r.month, e.month) as month,
    COALESCE(r.total_revenue, 0) as total_revenue,
    COALESCE(e.total_expenses, 0) as total_expenses,
    COALESCE(r.total_revenue, 0) - COALESCE(e.total_expenses, 0) as profit_loss
FROM monthly_revenue r
FULL OUTER JOIN monthly_expenses e ON r.month = e.month
ORDER BY month;

-- Q4: Top performing clinic based on sales
SELECT 
    clinic_id,
    COUNT(*) as total_sales,
    SUM(amount) as total_revenue,
    AVG(amount) as average_sale_amount
FROM clinic_sales
GROUP BY clinic_id
ORDER BY total_revenue DESC
LIMIT 1;

-- Q5: Sales channel performance by clinic
SELECT 
    clinic_id,
    sales_channel,
    COUNT(*) as transaction_count,
    SUM(amount) as total_revenue,
    ROUND(SUM(amount) * 100.0 / SUM(SUM(amount)) OVER (PARTITION BY clinic_id), 2) as revenue_percentage
FROM clinic_sales
GROUP BY clinic_id, sales_channel
ORDER BY clinic_id, total_revenue DESC;