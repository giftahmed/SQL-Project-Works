CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    rep_id INT,
    region VARCHAR(50),
    sales DECIMAL(10, 2)
);
INSERT INTO sales_data (sale_id, rep_id, region, sales) VALUES
(1, 101, 'East', 1000.00),
(2, 102, 'East', 1500.50),
(3, 103, 'West', 2000.00),
(4, 104, 'West', 2500.75),
(5, NULL, 'West', 3000.00);

CREATE TABLE representatives (
    rep_id INT PRIMARY KEY,
    sales_rep VARCHAR(100),
    region VARCHAR(50)
);
INSERT INTO representatives (rep_id, sales_rep, region) VALUES
(101, 'John Doe', 'East'),
(102, 'Jane Smith', 'East'),
(105, 'Jim Beam', 'North'),
(106, 'Jill Jackson', 'North'),
(107, 'Jack Johnson', 'South');

-- 1. Joins

-- Inner Join: Fetch sales data along with the names of the representatives where there is a match in both tables.
SELECT s.sales, r.sales_rep
FROM sales_data s
INNER JOIN representatives r
ON s.rep_id = r.rep_id
WHERE s.region = 'East';

-- Left Join: Fetch all sales data in the West region, including those without a corresponding sales representative.
SELECT s.sales, r.sales_rep
FROM sales_data s
LEFT JOIN representatives r
ON s.rep_id = r.rep_id
WHERE s.region = 'West';

-- Right Join: Fetch all representatives and their sales data in the North region, even if they don't have any sales.
SELECT s.sales, r.sales_rep
FROM sales_data s
RIGHT JOIN representatives r
ON s.rep_id = r.rep_id
WHERE r.region = 'North';

-- Full Join: Fetch all sales data and representative names, regardless of matches between them.
SELECT s.sales, r.sales_rep
FROM sales_data s
FULL OUTER JOIN representatives r
ON s.rep_id = r.rep_id;


-- 2. Aggregate Functions

-- Total sales across all regions.
SELECT SUM(sales) AS total_sales
FROM sales_data;

-- Count the number of sales records.
SELECT COUNT(*) AS total_sales_records
FROM sales_data;

-- Average sales amount.
SELECT AVG(sales) AS average_sales
FROM sales_data;

-- Maximum sales amount.
SELECT MAX(sales) AS max_sales
FROM sales_data;


-- 3. String Functions

-- Concatenate the first name and last name of the representatives.
SELECT CONCAT(SUBSTRING(sales_rep, 1, CHARINDEX(' ', sales_rep)-1), ' ', SUBSTRING(sales_rep, CHARINDEX(' ', sales_rep)+1, LEN(sales_rep))) AS full_name
FROM representatives;

select  CONCAT(sales_rep,' ', region)  as  fullname from  representatives

-- Find the length of the sales_rep name.
SELECT sales_rep, LEN(sales_rep) AS name_length
FROM representatives;


-- Convert the sales_rep name to lowercase.
SELECT LOWER(sales_rep) AS lowercase_name
FROM representatives;

-- Trim extra spaces from the region name.
SELECT TRIM(region) AS trimmed_region
FROM representatives;



--Create  a  table called sales with  the  following  
CREATE TABLE sales ( sale_id INT PRIMARY KEY, rep_id INT, sale_date DATE, amount DECIMAL(10, 2) );
INSERT INTO sales (sale_id, rep_id, sale_date, amount) 
VALUES (1, 101, '2024-09-15', 1000.00), 
(2, 102, '2024-09-16', 1500.50), 
(3, 103, '2024-09-17', 2000.00);

select  *  from  sales

-- 4. Date Functions

-- Get the current date.
SELECT GETDATE();

-- Add 7 days to the sale_date.
SELECT  DATEADD(DAY, 7, sale_date) AS new_date 
FROM sales

SELECT 
    sales.*, 
    DATEADD(DAY, 7, sales.sale_date) AS new_date
FROM 
    sales;

-- Format the sale_date as YYYY-MM-DD.
SELECT CONVERT(VARCHAR, sale_date, 23) AS formatted_date
FROM sales;

select   sales.*,
CONVERT(VARCHAR, sale_date, 23) AS formatted_date
FROM sales;

-- 5. Data Cleaning Functions

-- Replace NULL values in sales_data.rep_id with the text 'No Representative'.
SELECT COALESCE(CAST(rep_id AS VARCHAR), 'No Representative') AS representative
FROM sales_data;

-- Trim extra spaces in the sales_rep column.
SELECT LTRIM(RTRIM(sales_rep)) AS trimmed_sales_rep
FROM representatives;

-- Replace occurrences of 'Doe' in sales_rep with 'Johnson'.
SELECT REPLACE(sales_rep, 'Doe', 'Johnson') AS replaced_sales_rep
FROM representatives;

-- Replace occurrences of 'Doe' in sales_rep with 'Johnson'.
SELECT representatives.*, 
REPLACE(sales_rep, 'Doe', 'Johnson') AS replaced_sales_rep
FROM representatives;
-- 6. Data Sorting and Filtering

-- Sort sales data in descending order based on the sales amount.
SELECT *
FROM sales_data
ORDER BY sales DESC;

-- Filter and fetch sales data where sales amount is greater than 1500.
SELECT *
FROM sales_data
WHERE sales > 1500;

-- Fetch only unique regions from the sales_data table.
SELECT DISTINCT region
FROM sales_data;


-- 7. Constraints

-- Create a new customers table with customer_id as a PRIMARY KEY and email that is UNIQUE.
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

-- Create a FOREIGN KEY between customers and sales tables.
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    sale_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

