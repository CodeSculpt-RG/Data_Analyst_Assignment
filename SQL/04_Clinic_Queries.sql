-- SQL Proficiency - Clinic Management System Queries (Part B)
-- FINAL REVISION: Minimal syntax. Avoids CTEs, Window Functions, and complex aliasing.

-- 1. Find the revenue we got from each sales channel in a given year
-- (Assuming year '2021')
SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM
    clinic_sales
WHERE
    YEAR(datetime) = 2021
GROUP BY
    sales_channel
ORDER BY
    total_revenue DESC;


-- 2. Find top 10 the most valuable customers for a given year
-- (Assuming year '2021')
SELECT
    cs.uid,
    c.name AS customer_name,
    SUM(cs.amount) AS total_sales_amount
FROM
    clinic_sales cs
JOIN
    customer c ON cs.uid = c.uid
WHERE
    YEAR(cs.datetime) = 2021
GROUP BY
    cs.uid, c.name
ORDER BY
    total_sales_amount DESC
LIMIT 10;


-- 3. Find month wise revenue, expense, profit, status (profitable / not-profitable) for a given year
-- Using simple subqueries and UNION. Removing subquery aliases.
SELECT
    COALESCE(R.month, E.month) AS month,
    COALESCE(R.total_revenue, 0) AS revenue,
    COALESCE(E.total_expense, 0) AS expense,
    (COALESCE(R.total_revenue, 0) - COALESCE(E.total_expense, 0)) AS profit,
    CASE
        WHEN (COALESCE(R.total_revenue, 0) - COALESCE(E.total_expense, 0)) > 0 THEN 'profitable'
        ELSE 'not-profitable'
    END AS status
FROM
    ( -- MonthlyRevenue Subquery
        SELECT DATE_FORMAT(datetime, '%Y-%m') AS month, SUM(amount) AS total_revenue
        FROM clinic_sales WHERE YEAR(datetime) = 2021 
        GROUP BY DATE_FORMAT(datetime, '%Y-%m')
    ) R
LEFT JOIN
    ( -- MonthlyExpense Subquery
        SELECT DATE_FORMAT(datetime, '%Y-%m') AS month, SUM(amount) AS total_expense
        FROM expenses WHERE YEAR(datetime) = 2021 
        GROUP BY DATE_FORMAT(datetime, '%Y-%m')
    ) E ON R.month = E.month
UNION
SELECT
    E.month,
    COALESCE(R.total_revenue, 0),
    E.total_expense,
    (COALESCE(R.total_revenue, 0) - E.total_expense),
    CASE
        WHEN (COALESCE(R.total_revenue, 0) - E.total_expense) > 0 THEN 'profitable'
        ELSE 'not-profitable'
    END
FROM
    ( -- MonthlyExpense Subquery
        SELECT DATE_FORMAT(datetime, '%Y-%m') AS month, SUM(amount) AS total_expense
        FROM expenses WHERE YEAR(datetime) = 2021 
        GROUP BY DATE_FORMAT(datetime, '%Y-%m')
    ) E
LEFT JOIN
    ( -- MonthlyRevenue Subquery
        SELECT DATE_FORMAT(datetime, '%Y-%m') AS month, SUM(amount) AS total_revenue
        FROM clinic_sales WHERE YEAR(datetime) = 2021 
        GROUP BY DATE_FORMAT(datetime, '%Y-%m')
    ) R ON R.month = E.month
WHERE R.month IS NULL
ORDER BY
    month;


-- 4. For each city find the most profitable clinic for a given month
-- Replaced Window Functions with Subquery and MAX() aggregation.
SELECT
    T1.city,
    T1.cid AS most_profitable_clinic_id,
    T1.clinic_name,
    T1.profit
FROM (
    SELECT
        c.cid, c.city, c.clinic_name,
        (COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(e.amount), 0)) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs ON c.cid = cs.cid AND DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-09'
    LEFT JOIN expenses e ON c.cid = e.cid AND DATE_FORMAT(e.datetime, '%Y-%m') = '2021-09'
    GROUP BY c.cid, c.city, c.clinic_name
) AS T1
INNER JOIN (
    -- Find MAX Profit for each city (Max aggregation is widely supported)
    SELECT
        c.city,
        MAX(COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(e.amount), 0)) AS max_profit
    FROM clinics c
    LEFT JOIN clinic_sales cs ON c.cid = cs.cid AND DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-09'
    LEFT JOIN expenses e ON c.cid = e.cid AND DATE_FORMAT(e.datetime, '%Y-%m') = '2021-09'
    GROUP BY c.city
) AS T2 ON T1.city = T2.city AND T1.profit = T2.max_profit
ORDER BY T1.city;


-- 5. For each state find the second least profitable clinic for a given month
-- WARNING: This query relies on a subquery with LIMIT/OFFSET, which can still be problematic.
-- If this fails, the only remaining option is to run this in a supported client (MySQL 8+, PostgreSQL, etc.).
SELECT
    T1.state,
    T1.cid AS second_least_profitable_clinic_id,
    T1.clinic_name,
    T1.profit
FROM (
    -- Calculate Profit for every clinic
    SELECT
        c.cid, c.state, c.clinic_name,
        (COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(e.amount), 0)) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs ON c.cid = cs.cid AND DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-09'
    LEFT JOIN expenses e ON c.cid = e.cid AND DATE_FORMAT(e.datetime, '%Y-%m') = '2021-09'
    GROUP BY c.cid, c.state, c.clinic_name
) AS T1
INNER JOIN (
    -- Finds the exact value of the second lowest profit for the state
    SELECT
        T2.state,
        MIN(T2.profit) AS second_min_profit
    FROM (
        -- Get all unique profits for the state
        SELECT
            c.state,
            (COALESCE(SUM(cs.amount), 0) - COALESCE(SUM(e.amount), 0)) AS profit
        FROM clinics c
        LEFT JOIN clinic_sales cs ON c.cid = cs.cid AND DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-09'
        LEFT JOIN expenses e ON c.cid = e.cid AND DATE_FORMAT(e.datetime, '%Y-%m') = '2021-09'
        GROUP BY c.cid, c.state
        ORDER BY profit ASC
        LIMIT 2 -- Get the 1st and 2nd lowest profit values
    ) AS T2
    GROUP BY T2.state
    ORDER BY T2.profit DESC
    LIMIT 1 -- Take the second (the highest of the two lowest)
) AS T3 ON T1.state = T3.state AND T1.profit = T3.second_min_profit
ORDER BY T1.state;