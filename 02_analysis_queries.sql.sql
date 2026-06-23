
-- ================================================
-- ECOMMERCE ANALYTICS 
-- Author: Tushita Singh
-- Tool: MySQL Workbench
-- ================================================

SELECT *
FROM categories;

SELECT *
FROM customers;

SELECT *
FROM order_items;

SELECT *
FROM orders;

SELECT *
FROM products;

SELECT *
FROM returns;

SELECT *
FROM reviews;

SELECT *
FROM suppliers;

-- =====================
-- 25 BUSINESS QUERIES
-- =====================

-- 1.Total Revenue
SELECT 
ROUND(SUM(quantity * unit_price * (1-discount_percent / 100)),2) As total_revenue
FROM order_items ;

-- 2. Top 10 Best Selling Products

SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS revenue_generated
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 10;

-- 3. Revenue by Product Category
 
 SELECT 
    c.category_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;

-- 4. Customer List with Total Spend
SELECT 
    c.customer_name,
    c.city,
    c.customer_segment,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS total_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name, c.city, c.customer_segment
ORDER BY total_spend DESC;

-- 5.  Monthly Revenue Trend
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

-- 6 Revenue by State (Geographic Analysis)
SELECT 
    c.state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.state
ORDER BY total_revenue DESC;

-- 7. Return Rate by Product

SELECT 
    p.product_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(DISTINCT r.return_id) AS total_returns,
    ROUND(COUNT(DISTINCT r.return_id) * 100.0 / COUNT(DISTINCT oi.order_id), 2) AS return_rate_percent
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN returns r ON oi.order_id = r.order_id AND oi.product_id = r.product_id
GROUP BY p.product_name
HAVING total_returns > 0
ORDER BY return_rate_percent DESC;

-- 8. Average Order Value by Customer Segment

SELECT 
    c.customer_segment,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS total_revenue,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_segment
ORDER BY avg_order_value DESC;

-- 9. Customer Purchase Frequency
SELECT 
    c.customer_name,
    c.customer_segment,
    COUNT(DISTINCT o.order_id) AS total_orders,
    MIN(o.order_date) AS first_order,
    MAX(o.order_date) AS last_order,
    DATEDIFF(MAX(o.order_date), MIN(o.order_date)) AS days_as_customer
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name, c.customer_segment
ORDER BY total_orders DESC;

-- 10. Product Profitability Analysis

SELECT 
    p.product_name,
    c.category_name,
    p.cost_price,
    p.selling_price,
    ROUND(((p.selling_price - p.cost_price) / p.cost_price) * 100, 2) AS markup_percent,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * (oi.unit_price - p.cost_price) * (1 - oi.discount_percent/100)), 2) AS total_profit
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name, p.cost_price, p.selling_price
ORDER BY total_profit DESC;

-- 11. Payment Method Preference

SELECT 
    o.payment_method,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS total_revenue,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.payment_method
ORDER BY total_orders DESC;

-- 12. Supplier Performance Analysis
SELECT 
    s.supplier_name,
    s.rating AS supplier_rating,
    COUNT(DISTINCT p.product_id) AS products_supplied,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS revenue_contributed
FROM suppliers s
JOIN products p ON s.supplier_id = p.supplier_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY s.supplier_name, s.rating
ORDER BY revenue_contributed DESC;

-- 13. Dead Inventory Detection
SELECT 
    p.product_name,
    c.category_name,
    p.stock_quantity,
    ROUND(p.stock_quantity * p.cost_price, 2) AS inventory_value_blocked,
    MAX(o.order_date) AS last_order_date,
    DATEDIFF(CURDATE(), MAX(o.order_date)) AS days_since_last_sale
FROM products p
JOIN categories c ON p.category_id = c.category_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id
GROUP BY p.product_name, c.category_name, p.stock_quantity, p.cost_price
HAVING days_since_last_sale > 90 OR last_order_date IS NULL
ORDER BY inventory_value_blocked DESC;

-- 14. Year over Year Revenue Comparison
SELECT 
    YEAR(o.order_date) AS year,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date)
ORDER BY year;

-- 15. Top Customers by Segment
SELECT 
    c.customer_segment,
    c.customer_name,
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS total_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_segment, c.customer_name, c.city
ORDER BY c.customer_segment, total_spend DESC;

-- 16. Running Revenue Total (Window Function)

SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS monthly_revenue,
    ROUND(SUM(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100))) 
        OVER (ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')), 2) AS running_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

-- 17.  Month over Month Revenue Growth

WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND((revenue - LAG(revenue) OVER (ORDER BY month)) / 
        LAG(revenue) OVER (ORDER BY month) * 100, 2) AS mom_growth_percent
FROM monthly_revenue
ORDER BY month;

-- 18. Customer RFM Scoring

WITH rfm AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        DATEDIFF(CURDATE(), MAX(o.order_date)) AS recency_days,
        COUNT(DISTINCT o.order_id) AS frequency,
        ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS monetary
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT 
    customer_name,
    recency_days,
    frequency,
    monetary,
    NTILE(3) OVER (ORDER BY recency_days ASC) AS recency_score,
    NTILE(3) OVER (ORDER BY frequency DESC) AS frequency_score,
    NTILE(3) OVER (ORDER BY monetary DESC) AS monetary_score
FROM rfm
ORDER BY monetary DESC;

-- 19. Customer Segmentation Using RFM

WITH rfm AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        DATEDIFF(CURDATE(), MAX(o.order_date)) AS recency_days,
        COUNT(DISTINCT o.order_id) AS frequency,
        ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS monetary
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
),
rfm_scored AS (
    SELECT *,
        NTILE(3) OVER (ORDER BY recency_days ASC) AS r_score,
        NTILE(3) OVER (ORDER BY frequency DESC) AS f_score,
        NTILE(3) OVER (ORDER BY monetary DESC) AS m_score
    FROM rfm
)
SELECT 
    customer_name,
    recency_days,
    frequency,
    monetary,
    CASE 
        WHEN r_score = 3 AND f_score = 3 AND m_score = 3 THEN 'Champion'
        WHEN r_score >= 2 AND f_score >= 2 THEN 'Loyal Customer'
        WHEN r_score = 3 AND f_score = 1 THEN 'New Customer'
        WHEN r_score = 1 AND f_score >= 2 THEN 'At Risk'
        WHEN r_score = 1 AND f_score = 1 THEN 'Lost'
        ELSE 'Potential'
    END AS customer_segment
FROM rfm_scored
ORDER BY monetary DESC;

-- 20. Cohort Retention Analysis

WITH first_order AS (
    SELECT 
        customer_id,
        DATE_FORMAT(MIN(order_date), '%Y-%m') AS cohort_month
    FROM orders
    GROUP BY customer_id
),
order_activity AS (
    SELECT 
        o.customer_id,
        f.cohort_month,
        DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
        PERIOD_DIFF(
            EXTRACT(YEAR_MONTH FROM o.order_date),
            EXTRACT(YEAR_MONTH FROM STR_TO_DATE(f.cohort_month, '%Y-%m'))
        ) AS month_number
    FROM orders o
    JOIN first_order f ON o.customer_id = f.customer_id
)
SELECT 
    cohort_month,
    month_number,
    COUNT(DISTINCT customer_id) AS active_customers
FROM order_activity
GROUP BY cohort_month, month_number
ORDER BY cohort_month, month_number;

-- 21.Product Affinity Analysis (Bought Together) 

SELECT 
    p1.product_name AS product_1,
    p2.product_name AS product_2,
    COUNT(*) AS times_bought_together
FROM order_items oi1
JOIN order_items oi2 ON oi1.order_id = oi2.order_id 
    AND oi1.product_id < oi2.product_id
JOIN products p1 ON oi1.product_id = p1.product_id
JOIN products p2 ON oi2.product_id = p2.product_id
GROUP BY p1.product_name, p2.product_name
ORDER BY times_bought_together DESC
LIMIT 15;

-- 22. Revenue Contribution Percentage by Product

SELECT 
    p.product_name,
    c.category_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS product_revenue,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) * 100 /
        SUM(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100))) OVER(), 2) AS revenue_percent,
    ROUND(SUM(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100))) 
        OVER (ORDER BY SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) DESC) * 100 /
        SUM(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100))) OVER(), 2) AS cumulative_percent
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name
ORDER BY product_revenue DESC;

-- 23. Churn Risk Detection

WITH order_with_lag AS (
    SELECT 
        customer_id,
        order_date,
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_order_date
    FROM orders
),
customer_activity AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.customer_segment,
        MAX(o.order_date) AS last_order_date,
        DATEDIFF(CURDATE(), MAX(o.order_date)) AS days_since_last_order,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(AVG(DATEDIFF(owl.order_date, owl.prev_order_date)), 0) AS avg_days_between_orders
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_with_lag owl ON c.customer_id = owl.customer_id
    GROUP BY c.customer_id, c.customer_name, c.customer_segment
)
SELECT 
    customer_name,
    customer_segment,
    last_order_date,
    days_since_last_order,
    avg_days_between_orders,
    CASE 
        WHEN days_since_last_order > 365 THEN 'High Risk'
        WHEN days_since_last_order > 180 THEN 'Medium Risk'
        WHEN days_since_last_order > 90 THEN 'Low Risk'
        ELSE 'Active'
    END AS churn_risk
FROM customer_activity
ORDER BY days_since_last_order DESC;

-- 24. Discount Impact on Profitability

SELECT 
    CASE 
        WHEN oi.discount_percent = 0 THEN 'No Discount'
        WHEN oi.discount_percent <= 5 THEN 'Low (1-5%)'
        WHEN oi.discount_percent <= 10 THEN 'Medium (6-10%)'
        ELSE 'High (11%+)'
    END AS discount_tier,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue_before_discount,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS revenue_after_discount,
    ROUND(SUM(oi.quantity * oi.unit_price * (oi.discount_percent/100)), 2) AS total_discount_given,
    ROUND(AVG(oi.discount_percent), 2) AS avg_discount_percent
FROM order_items oi
GROUP BY discount_tier
ORDER BY total_orders DESC;

-- 25. Executive Summary Query

SELECT 
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) / 
        COUNT(DISTINCT o.order_id), 2) AS avg_order_value,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) / 
        COUNT(DISTINCT o.customer_id), 2) AS avg_revenue_per_customer,
    COUNT(DISTINCT oi.product_id) AS total_products_sold,
    (SELECT COUNT(*) FROM returns) AS total_returns,
    ROUND((SELECT COUNT(*) FROM returns) * 100.0 / COUNT(DISTINCT o.order_id), 2) AS return_rate_percent
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id;










