DROP TABLE IF EXISTS mart.f_customer_retention;
CREATE TABLE IF NOT EXISTS mart.f_customer_retention (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    new_customers_count INT,
    returning_customers_count INT,
    refunded_customer_count INT,
    period_name varchar(10),
    period_id varchar(10),
    item_id INT,
    new_customers_revenue NUMERIC(12, 2),
    returning_customers_revenue NUMERIC(12, 2),
    customers_refunded NUMERIC(12, 2),
    CONSTRAINT f_customer_retention_item_id_fkey FOREIGN KEY (item_id) REFERENCES mart.d_item (item_id)
);
CREATE INDEX fcr1 ON mart.f_customer_retention USING btree (period_id);
CREATE INDEX fcr2 ON mart.f_customer_retention USING btree (item_id);
COMMENT ON COLUMN mart.f_customer_retention.new_customers_count IS 'кол-во новых клиентов (тех, которые сделали только один заказ за рассматриваемый промежуток времени)';
COMMENT ON COLUMN mart.f_customer_retention.returning_customers_count IS 'кол-во вернувшихся клиентов (тех, которые сделали только несколько заказов за рассматриваемый промежуток времени).';
COMMENT ON COLUMN mart.f_customer_retention.refunded_customer_count IS 'кол-во клиентов, оформивших возврат за рассматриваемый промежуток времени.';
COMMENT ON COLUMN mart.f_customer_retention.period_name IS 'weekly';
COMMENT ON COLUMN mart.f_customer_retention.period_id IS 'идентификатор периода (номер недели или номер месяца).';
COMMENT ON COLUMN mart.f_customer_retention.item_id IS 'идентификатор категории товара.';
COMMENT ON COLUMN mart.f_customer_retention.new_customers_revenue IS 'доход с новых клиентов';
COMMENT ON COLUMN mart.f_customer_retention.returning_customers_revenue IS 'доход с вернувшихся клиентов';
COMMENT ON COLUMN mart.f_customer_retention.customers_refunded IS 'количество возвратов клиентов';