ALTER TABLE staging.user_order_log
ADD COLUMN status varchar(10) DEFAULT 'shipped' NOT NULL;