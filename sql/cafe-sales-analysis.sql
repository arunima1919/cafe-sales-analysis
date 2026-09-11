-- ============================================================
-- CAFE SALES ANALYSIS
-- Database Creation, Data Import, Validation & SQL Analysis
-- ============================================================


-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

CREATE DATABASE IF NOT EXISTS cafe_sales_db;

USE cafe_sales_db;


-- ============================================================
-- 2. CREATE CAFE SALES TABLE
-- ============================================================

CREATE TABLE cafe_sales (
    `Transaction ID` VARCHAR(20),
    Item VARCHAR(50),
    Quantity DECIMAL(10,2),
    `Price Per Unit` DECIMAL(10,2),
    `Total Spent` DECIMAL(10,2),
    `Payment Method` VARCHAR(50),
    Location VARCHAR(50),
    `Transaction Date` DATE
);


-- ============================================================
-- 3. CREATE STAGING TABLE
-- CSV data was first imported into this staging table.
-- VARCHAR columns are used to safely handle empty values.
-- ============================================================

CREATE TABLE cafe_sales_staging (
    `Transaction ID` VARCHAR(20),
    Item VARCHAR(50),
    Quantity VARCHAR(20),
    `Price Per Unit` VARCHAR(20),
    `Total Spent` VARCHAR(20),
    `Payment Method` VARCHAR(50),
    Location VARCHAR(50),
    `Transaction Date` VARCHAR(20)
);

-- ============================================================
-- 4. LOAD DATA FROM STAGING TABLE INTO FINAL TABLE
-- Empty strings are converted to NULL using NULLIF()
-- while loading the data into the final table.
-- ============================================================

INSERT INTO cafe_sales (
    `Transaction ID`,
    Item,
    Quantity,
    `Price Per Unit`,
    `Total Spent`,
    `Payment Method`,
    Location,
    `Transaction Date`
)
SELECT
    `Transaction ID`,
    NULLIF(Item, ''),
    NULLIF(Quantity, ''),
    NULLIF(`Price Per Unit`, ''),
    NULLIF(`Total Spent`, ''),
    NULLIF(`Payment Method`, ''),
    NULLIF(Location, ''),
    NULLIF(`Transaction Date`, '')
FROM cafe_sales_staging;


-- ============================================================
-- 5. DATA VALIDATION
-- ============================================================

-- Check total number of records

SELECT
    COUNT(*) AS Total_Rows
FROM cafe_sales;


-- Check missing values

SELECT
    COUNT(*) AS Total_Rows,
    SUM(Item IS NULL) AS Missing_Item,
    SUM(Quantity IS NULL) AS Missing_Quantity,
    SUM(`Price Per Unit` IS NULL) AS Missing_Price,
    SUM(`Total Spent` IS NULL) AS Missing_Total_Spent,
    SUM(`Payment Method` IS NULL) AS Missing_Payment_Method,
    SUM(Location IS NULL) AS Missing_Location,
    SUM(`Transaction Date` IS NULL) AS Missing_Date
FROM cafe_sales;


-- Preview the imported data

SELECT *
FROM cafe_sales
LIMIT 5;


-- Check table structure

DESCRIBE cafe_sales;


-- Check date range

SELECT
    MIN(`Transaction Date`) AS Earliest_Date,
    MAX(`Transaction Date`) AS Latest_Date
FROM cafe_sales;


-- ============================================================
-- 6. OVERALL BUSINESS METRICS
-- ============================================================

SELECT
    COUNT(*) AS Total_Transactions,
    SUM(`Total Spent`) AS Total_Revenue,
    AVG(`Total Spent`) AS Average_Transaction_Value,
    AVG(Quantity) AS Average_Quantity,
    AVG(`Price Per Unit`) AS Average_Price_Per_Unit,
    MIN(`Total Spent`) AS Minimum_Transaction_Value,
    MAX(`Total Spent`) AS Maximum_Transaction_Value
FROM cafe_sales;


-- ============================================================
-- 7. ITEM ANALYSIS
-- ============================================================

-- Item performance by transactions, quantity and revenue

SELECT
    Item,
    COUNT(*) AS Transaction_Count,
    SUM(Quantity) AS Total_Quantity_Sold,
    SUM(`Total Spent`) AS Total_Revenue,
    AVG(`Total Spent`) AS Average_Transaction_Value
FROM cafe_sales
WHERE Item IS NOT NULL
GROUP BY Item
ORDER BY Total_Revenue DESC;


-- Top 5 items by revenue

SELECT
    Item,
    SUM(`Total Spent`) AS Total_Revenue
FROM cafe_sales
WHERE Item IS NOT NULL
GROUP BY Item
ORDER BY Total_Revenue DESC
LIMIT 5;


-- ============================================================
-- 8. MONTHLY ANALYSIS
-- ============================================================

SELECT
    YEAR(`Transaction Date`) AS Year,
    MONTH(`Transaction Date`) AS Month,
    COUNT(*) AS Transaction_Count,
    SUM(`Total Spent`) AS Total_Revenue,
    AVG(`Total Spent`) AS Average_Transaction_Value
FROM cafe_sales
WHERE `Transaction Date` IS NOT NULL
GROUP BY
    YEAR(`Transaction Date`),
    MONTH(`Transaction Date`)
ORDER BY
    Year,
    Month;


-- ============================================================
-- 9. PAYMENT METHOD ANALYSIS
-- ============================================================

SELECT
    `Payment Method`,
    COUNT(*) AS Transaction_Count,
    SUM(`Total Spent`) AS Total_Revenue,
    AVG(`Total Spent`) AS Average_Transaction_Value
FROM cafe_sales
WHERE `Payment Method` IS NOT NULL
GROUP BY `Payment Method`
ORDER BY Total_Revenue DESC;


-- ============================================================
-- 10. LOCATION ANALYSIS
-- ============================================================

SELECT
    Location,
    COUNT(*) AS Transaction_Count,
    SUM(`Total Spent`) AS Total_Revenue,
    AVG(`Total Spent`) AS Average_Transaction_Value
FROM cafe_sales
WHERE Location IS NOT NULL
GROUP BY Location
ORDER BY Total_Revenue DESC;


-- ============================================================
-- 11. HIGH-VALUE TRANSACTION ANALYSIS
-- ============================================================

-- Count high-value transactions

SELECT
    COUNT(*) AS High_Value_Transactions
FROM cafe_sales
WHERE `Total Spent` >= 20;


-- High-value transactions by item

SELECT
    Item,
    COUNT(*) AS High_Value_Transactions,
    SUM(`Total Spent`) AS High_Value_Revenue
FROM cafe_sales
WHERE `Total Spent` >= 20
  AND Item IS NOT NULL
GROUP BY Item
ORDER BY High_Value_Transactions DESC;


-- ============================================================
-- 12. QUANTITY VS TRANSACTION VALUE
-- ============================================================

SELECT
    Quantity,
    COUNT(*) AS Transaction_Count,
    AVG(`Total Spent`) AS Average_Transaction_Value
FROM cafe_sales
WHERE Quantity IS NOT NULL
GROUP BY Quantity
ORDER BY Quantity;


-- ============================================================
-- 13. DAY-OF-WEEK ANALYSIS
-- ============================================================

SELECT
    DAYNAME(`Transaction Date`) AS Day_Name,
    COUNT(*) AS Transaction_Count,
    SUM(`Total Spent`) AS Total_Revenue,
    AVG(`Total Spent`) AS Average_Transaction_Value
FROM cafe_sales
WHERE `Transaction Date` IS NOT NULL
GROUP BY
    DAYOFWEEK(`Transaction Date`),
    DAYNAME(`Transaction Date`)
ORDER BY DAYOFWEEK(`Transaction Date`);


-- ============================================================
-- 14. MOST POPULAR ITEM BY DAY
-- Uses ROW_NUMBER() to identify the top-selling item
-- for each day of the week.
-- ============================================================

WITH item_day_sales AS (
    SELECT
        DAYNAME(`Transaction Date`) AS Day_Name,
        DAYOFWEEK(`Transaction Date`) AS Day_Number,
        Item,
        COUNT(*) AS Transaction_Count
    FROM cafe_sales
    WHERE `Transaction Date` IS NOT NULL
      AND Item IS NOT NULL
    GROUP BY
        DAYOFWEEK(`Transaction Date`),
        DAYNAME(`Transaction Date`),
        Item
),
ranked_items AS (
    SELECT
        Day_Name,
        Day_Number,
        Item,
        Transaction_Count,
        ROW_NUMBER() OVER (
            PARTITION BY Day_Number
            ORDER BY Transaction_Count DESC
        ) AS Rank_Number
    FROM item_day_sales
)
SELECT
    Day_Name,
    Item,
    Transaction_Count
FROM ranked_items
WHERE Rank_Number = 1
ORDER BY Day_Number;


-- ============================================================
-- 15. TOP 5 HIGHEST-REVENUE DAYS
-- ============================================================

SELECT
    `Transaction Date`,
    COUNT(*) AS Transaction_Count,
    SUM(`Total Spent`) AS Total_Revenue,
    AVG(`Total Spent`) AS Average_Transaction_Value
FROM cafe_sales
WHERE `Transaction Date` IS NOT NULL
GROUP BY `Transaction Date`
ORDER BY Total_Revenue DESC
LIMIT 5;