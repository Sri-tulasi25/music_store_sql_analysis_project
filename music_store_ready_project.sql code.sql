-- ==============================================
-- MUSIC STORE PROJECT : 
-- ==============================================

CREATE DATABASE IF NOT EXISTS music_store;
USE music_store;

SET GLOBAL local_infile = 1;

DROP TABLE IF EXISTS sales_data;

CREATE TABLE sales_data (
    InvoiceId INT,
    InvoiceDate DATETIME,
    CustomerId INT,
    CustomerName VARCHAR(100),
    Country VARCHAR(50),
    TrackName VARCHAR(200),
    Artist VARCHAR(150),
    AlbumTitle VARCHAR(200),
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    LineTotal DECIMAL(10,2),
    Year INT,
    Month INT
);

LOAD DATA LOCAL INFILE 'C:/Users/TULASIGIRISH/Downloads/music_store_cleaned.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_rows FROM sales_data;

SELECT * FROM sales_data LIMIT 10;

SELECT 
    COUNT(DISTINCT InvoiceId) AS total_invoices,
    SUM(LineTotal) AS total_sales,
    SUM(Quantity) AS total_quantity
FROM sales_data;

SELECT Artist, SUM(LineTotal) AS total_sales
FROM sales_data
GROUP BY Artist
ORDER BY total_sales DESC
LIMIT 5;

SELECT Year, SUM(LineTotal) AS yearly_sales
FROM sales_data
GROUP BY Year
ORDER BY Year;

SELECT Country, SUM(LineTotal) AS total_sales
FROM sales_data
GROUP BY Country
ORDER BY total_sales DESC;

SELECT CONCAT(Year,'-',LPAD(Month,2,'0')) AS YearMonth,
       SUM(LineTotal) AS monthly_sales
FROM sales_data
GROUP BY Year, Month
ORDER BY Year, Month;

SELECT TrackName, SUM(LineTotal) AS total_revenue
FROM sales_data
GROUP BY TrackName
ORDER BY total_revenue DESC
LIMIT 10;

SELECT Artist, AVG(UnitPrice) AS avg_price
FROM sales_data
GROUP BY Artist
ORDER BY avg_price DESC;

SELECT Country, COUNT(DISTINCT CustomerId) AS total_customers
FROM sales_data
GROUP BY Country
ORDER BY total_customers DESC;

SELECT Year, COUNT(DISTINCT InvoiceId) AS invoices
FROM sales_data
GROUP BY Year
ORDER BY Year;
