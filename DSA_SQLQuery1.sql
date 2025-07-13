CREATE DATABASE KMS_DB;

--To confirm that the data was sucessfully imported using the import wizard

SELECT TOP 10 * FROM dbo.kms_orders;


--BUSINESS QUESTION:
-- Which product category had the highest total sales?

-- Selecting the top 1 product category with the highest sum of sales
SELECT TOP 1
    Product_Category,
    SUM(Sales) AS Total_Sales
FROM
    KMS_Orders
GROUP BY
    Product_Category
ORDER BY
    Total_Sales DESC;


	--  BUSINESS QUESTION 2:
-- What are the Top 3 and Bottom 3 regions based on total sales?

-- Step 1: Get total sales by region
SELECT
    Region,
    SUM(Sales) AS Total_Sales
FROM
    KMS_Orders
GROUP BY
    Region
ORDER BY
    Total_Sales DESC;


	--  BUSINESS QUESTION 3:
-- What is the total sales of 'Appliances' in the 'Ontario' province?

-- We filter the dataset for rows where:
--   - Product_Category is 'Appliances'
--   - Province is 'Ontario'
-- Then we sum the Sales values

SELECT
    SUM(Sales) AS Total_Appliances_Sales_Ontario
FROM
    kms_Orders
WHERE
    Product_Category = 'Appliances'
    AND Province = 'Ontario';


	-- BUSINESS QUESTION 4:
-- Who are the bottom 10 customers based on total sales?

-- Grouping by Customer_Name and summing their total sales
-- Sorting in ascending order to get the lowest revenue customers

SELECT TOP 10
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM
    KMS_Orders
GROUP BY
    Customer_Name
ORDER BY
    Total_Sales ASC;


	--  BUSINESS QUESTION 5:
-- Which shipping method incurred the highest total shipping cost?

-- Grouping data by Ship_Mode
-- Summing the Shipping_Cost for each method
-- Sorting in descending order to see the most expensive on top
-- Using TOP 1 to return only the highest one

SELECT TOP 1
    Ship_Mode,
    SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM
    KMS_Orders
GROUP BY
    Ship_Mode
ORDER BY
    Total_Shipping_Cost DESC;


	--  BUSINESS QUESTION 6:
-- Who are the top 5 most valuable customers by total sales?

SELECT TOP 5
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM
    KMS_Orders
GROUP BY
    Customer_Name
ORDER BY
    Total_Sales DESC;

	--  BUSINESS QUESTION 7:
-- Which customer in the 'Small Business' segment generated the highest total sales?

-- Filtering only 'Small Business' customers
-- Grouping by Customer_Name to get total sales per customer
-- Sorting in descending order to find the top one
-- Using TOP 1 to return only the highest

SELECT TOP 1
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM
    KMS_Orders
WHERE
    Customer_Segment = 'Small Business'
GROUP BY
    Customer_Name
ORDER BY
    Total_Sales DESC;


	-- BUSINESS QUESTION 8:
-- Which Corporate segment customer made the most orders between 2009 and 2012?

-- Step 1: Filter customers in the 'Corporate' segment
-- Step 2: Filter orders between 2009 and 2012 using Order_Date
-- Step 3: Group by Customer_Name and count how many times each customer appears
-- Step 4: Sort in descending order to get the highest
-- Step 5: Use TOP 1 to get the customer with the most orders

SELECT TOP 1
    Customer_Name,
    COUNT(Order_ID) AS Number_of_Orders
FROM
    KMS_Orders
WHERE
   Customer_Segment = 'Corporate'
    AND Order_Date BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY
    Customer_Name
ORDER BY
    Number_of_Orders DESC;



	--  BUSINESS QUESTION 9:
-- Who is the most profitable customer in the 'Consumer' segment?

-- Step 1: Filter customers in the 'Consumer' segment
-- Step 2: Group by Customer_Name
-- Step 3: Sum their total profit
-- Step 4: Sort by profit in descending order
-- Step 5: Use TOP 1 to get the most profitable consumer

SELECT TOP 1
    Customer_Name,
    SUM(Profit) AS Total_Profit
FROM
    KMS_Orders
WHERE
   Customer_Segment = 'Consumer'
GROUP BY
    Customer_Name
ORDER BY
    Total_Profit DESC;

	-- BUSINESS QUESTION 10:
-- Which customers returned items and what segment do they belong to?

-- This query assumes there's a column named 'Return_Status' 
-- that shows which orders were returned

SELECT DISTINCT
    Customer_Name,
    Customer_Segment
FROM
    KMS_Orders
WHERE
    Return_Status = 'Returned';



	-- BUSINESS QUESTION 11:
-- Is the company using the correct shipping methods based on order priority?

-- Step 1: Count how many orders used each shipping method by order priority
-- This helps us spot any mismatch (e.g. High priority using cheap/delayed methods)

SELECT
    Order_Priority,
    Ship_Mode,
    COUNT(*) AS Num_Orders,
    SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM
    KMS_Orders
GROUP BY
    Order_Priority,
    Ship_Mode
ORDER BY
    Order_Priority, Ship_Mode;

