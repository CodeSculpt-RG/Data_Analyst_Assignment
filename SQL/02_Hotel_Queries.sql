-- 4. Determine the most ordered and least ordered item of each month of year 2021
WITH MonthlyItemQuantity AS (
    SELECT
        -- Use standard YEAR() and MONTH() functions for date formatting
        DATE_FORMAT(bill_date, '%Y-%m') AS month,
        item_id,
        SUM(item_quantity) AS total_quantity
    FROM
        booking_commercials
    WHERE
        YEAR(bill_date) = 2021
    GROUP BY 1, 2
),
RankedItems AS (
    SELECT
        miq.month, i.item_name, miq.total_quantity,
        RANK() OVER (PARTITION BY miq.month ORDER BY miq.total_quantity DESC) AS most_ordered_rank,
        RANK() OVER (PARTITION BY miq.month ORDER BY miq.total_quantity ASC) AS least_ordered_rank
    FROM
        MonthlyItemQuantity miq
    JOIN
        items i ON miq.item_id = i.item_id
)
SELECT
    month,
    -- Use CONCAT() instead of || for string concatenation
    MAX(CASE WHEN most_ordered_rank = 1 THEN CONCAT(item_name, ' (', total_quantity, ')') END) AS most_ordered_item,
    MAX(CASE WHEN least_ordered_rank = 1 THEN CONCAT(item_name, ' (', total_quantity, ')') END) AS least_ordered_item
FROM
    RankedItems
WHERE
    most_ordered_rank = 1 OR least_ordered_rank = 1
GROUP BY
    month
ORDER BY
    month;