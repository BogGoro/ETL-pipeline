INSERT INTO mart.f_sales (
        date_id,
        item_id,
        customer_id,
        city_id,
        quantity,
        payment_amount,
        refunded
    )
SELECT dc.date_id,
    item_id,
    customer_id,
    city_id,
    quantity * (
        CASE
            WHEN uol.status = 'refunded' THEN -1
            ELSE 1
        END
    ) AS quantity,
    payment_amount * (
        CASE
            WHEN uol.status = 'refunded' THEN -1
            ELSE 1
        END
    ) AS payment_amount,
    (uol.status = 'refunded')
FROM staging.user_order_log uol
    LEFT JOIN mart.d_calendar AS dc ON uol.date_time::date = dc.date_actual
WHERE uol.date_time::date = '{{ds}}';