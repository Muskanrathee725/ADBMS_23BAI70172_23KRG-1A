
------------------------------Medium----------------------------------------------
----------------------------------------------------------------------------------
CREATE TABLE transaction_data (
    id INT,
    value INT
);
-- For id = 1
INSERT INTO transaction_data (id, value)
SELECT 1, (random() * 1000)::INT
FROM generate_series(1, 1000000);
-- For id = 2
INSERT INTO transaction_data (id, value)
SELECT 2, (random() * 1000)::INT
FROM generate_series(1, 1000000);

----------------------------------------------------------------------------------


---------------------------------Normal view--------------------------------------
CREATE OR REPLACE VIEW sales_summary_view AS
SELECT
    id,
    COUNT(*) AS total_orders,
    SUM(value) AS total_sales,
    AVG(value) AS avg_transaction
FROM transaction_data
GROUP BY id;


EXPLAIN ANALYZE SELECT * FROM sales_summary_view;

------------------------------ Materialized view------------------------------------
CREATE MATERIALIZED VIEW sales_summary_mv AS
SELECT
    id,
    COUNT(*) AS total_orders,
    SUM(value) AS total_sales,
    AVG(value) AS avg_transaction
FROM transaction_data
GROUP BY id;

EXPLAIN ANALYZE SELECT * FROM sales_summary_mv;





-------------------------------------------------------------------------------------

----------------------------- hard --------------------------------------------------
-- Create table
CREATE TABLE random_tabl (
    id INT,
    val DOUBLE PRECISION
);

-- Insert 1M rows for id = 1
INSERT INTO random_tabl 
SELECT 1, random()
FROM generate_series(1, 1000000);

-- Insert 1M rows for id = 2
INSERT INTO random_tabl 
SELECT 2, random()
FROM generate_series(1, 1000000);

------------------------ Normal execution (aggregation on base table)-----------------


SELECT 
    id, 
    AVG(val) AS avg_val, 
    COUNT(*) AS total_rows
FROM random_tabl
GROUP BY id;

----------------------- Execution with Materialized View-------------------------------
DROP MATERIALIZED VIEW IF EXISTS mv_random_tabl;

CREATE MATERIALIZED VIEW mv_random_tabl AS
SELECT 
    id, 
    AVG(val) AS avg_val, 
    COUNT(*) AS total_rows
FROM random_tabl
GROUP BY id;

----------------------- Query materialized view (fast, precomputed)---------------------
SELECT * 
FROM mv_random_tabl;

------------------------ If data in base table changes → refresh MV---------------------

REFRESH MATERIALIZED VIEW mv_random_tabl;
