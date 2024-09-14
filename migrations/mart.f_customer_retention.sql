WITH customer_calculations AS (
    SELECT uol.customer_id AS customer_id,
        uol.item_id AS item_id,
        substr(dc.week_of_year_iso, 1, 8) AS year_with_week,
        count(
            CASE
                WHEN uol.status = 'shipped' THEN 1
            END
        ) AS orders_count,
        sum(
            CASE
                WHEN uol.status = 'shipped' THEN uol.payment_amount
                ELSE 0
            END
        ) customer_revenue,
        count(
            CASE
                WHEN uol.status = 'refunded' THEN 1
            END
        ) AS refunds_count,
        sum(
            CASE
                WHEN uol.status = 'refunded' THEN uol.quantity
                ELSE 0
            END
        ) AS refunds_quantity
    FROM staging.user_order_log uol
        JOIN mart.d_calendar dc ON uol.date_time::date = dc.date_actual
    GROUP BY customer_id,
        item_id,
        year_with_week
)
INSERT INTO mart.f_customer_retention (
        new_customers_count,
        returning_customers_count,
        refunded_customer_count,
        period_name,
        period_id,
        item_id,
        new_customers_revenue,
        returning_customers_revenue,
        customers_refunded
    )
SELECT count(
        CASE
            WHEN orders_count = 1 THEN 1
        END
    ),
    count(
        CASE
            WHEN orders_count > 1 THEN 1
        END
    ),
    count(
        CASE
            WHEN refunds_count > 0 THEN 1
        END
    ),
    'weekly',
    year_with_week,
    item_id,
    sum(
        CASE
            WHEN orders_count = 1 THEN customer_revenue
            ELSE 0
        END
    ),
    sum(
        CASE
            WHEN orders_count > 1 THEN customer_revenue
            ELSE 0
        END
    ),
    sum(
        CASE
            WHEN refunds_count > 0 THEN refunds_quantity
            ELSE 0
        END
    )
FROM customer_calculations
GROUP BY item_id,
    year_with_week