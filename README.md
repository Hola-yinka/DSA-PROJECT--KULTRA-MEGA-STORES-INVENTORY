# DSA-PROJECT--KULTRA-MEGA-STORES-INVENTORY
This is a project given by DSA to analyze a transactional dataset from Kultra Mega Stores, a company that sells office supplies and furniture across Lagos, Nigeria. The focus is on their Abuja division, with data covering orders from 2009 to 2012.

##  Company Overview

Kultra Mega Stores (KMS), headquartered in Lagos, Nigeria, specializes in the sale of office supplies and furniture. Its diverse customer base includes individual consumers, small retail businesses, and large corporate clients.

You have been engaged as a **Business Intelligence Analyst** to support the operations of the **Abuja division**. The Business Manager provided an Excel file containing historical order data spanning from **2009 to 2012**, and requested that you analyze the dataset and present key insights and actionable recommendations to support strategic decision-making.

## Data Source

The data was downloaded from **Canvas**, as provided by **DSA** (DigitalSkillUpAfrica) for the Business Intelligence project.

## 🧾 Dataset Description

The dataset contains historical order records from **Kultra Mega Stores – Abuja division** between **2009 and 2012**. Each row represents a single order transaction with various attributes describing the customer, product, sales details, and shipping.

Below are the key columns included in the dataset:

- **Row_ID** – Unique identifier for each transaction row
- **Order_ID** – Unique identifier for each order
- **Order_Date** – The date the order was placed
- **Ship_Date** – The date the order was shipped
- **Customer_Name** – Name of the customer who placed the order
- **Segment** – Customer segment (Consumer, Small Business, Corporate)
- **Province** – Specific state within the region (e.g., Abuja, Kano)
- **Region** – Broader region classification (e.g., North, South)
- **Product_Category** – High-level category of the product (e.g., Furniture, Office Supplies)
- **Product_Sub_Category** – Subdivision of the product category
- **Product_Name** – Full name or description of the product
- **Sales** – Total sales value for the product ordered
- **Quantity** – Number of units ordered
- **Discount** – Discount applied to the sale (in decimal form)
- **Profit** – Profit made from the sale
- **Shipping_Cost** – Cost incurred for shipping the order
- **Ship_Mode** – Shipping method used (e.g., Express Air, Delivery Truck)
- **Order_Priority** – Priority level of the order (e.g., Low, Medium, High, Critical)
### Here is the overview of the dataset before cleaning 
<img width="925" height="372" alt="sql" src="https://github.com/user-attachments/assets/33e130f3-0109-4522-b99c-104ab1e5db69" />

## 🛠️ Tools & Skills Used

- [**Microsoft SQL Server (SSMS)**](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)  
  Used for querying, filtering, and analyzing data with T-SQL

- [**Excel**](https://www.microsoft.com/en-us/microsoft-365/excel)  
  Used for initial data cleaning, formatting, and converting to CSV

- **SQL (T-SQL)**  
  Used for filtering, aggregation, joins, groupings, and business queries

- **Business Intelligence (BI)**  
  Applied to extract insights from transactional data and support decision-making

- **Problem Solving & Interpretation**  
  Translating business questions into technical solutions using SQL

  ## 📘 Business Analysis & SQL Solutions
### 1: Which product category had the highest total sales?
- Selecting the top 1 product category with the highest sum of sales
~~~
 SELECT TOP 1
    Product_Category,
    SUM(Sales) AS Total_Sales
FROM
    KMS_Orders
GROUP BY
    Product_Category
ORDER BY
    Total_Sales DESC;
~~~

### 2:What are the Top 3 and Bottom 3 regions based on total sales?
 - Get total sales by region
~~~
SELECT
    Region,
    SUM(Sales) AS Total_Sales
FROM
    KMS_Orders
GROUP BY
    Region
ORDER BY
    Total_Sales DESC;
~~~

### 3: What is the total sales of 'Appliances' in the 'Ontario' province?
- 🧮 Steps Taken:
1. We filter the dataset for rows where:
2. Product_Category is 'Appliances'
3.Province is 'Ontario'
4.Then we sum the Sales values

~~~
SELECT
    SUM(Sales) AS Total_Appliances_Sales_Ontario
FROM
    kms_Orders
WHERE
    Product_Category = 'Appliances'
    AND Province = 'Ontario';
~~~

 ### 4: Who are the bottom 10 customers based on total sales?
 - 🧮 Steps Taken:
  1. Grouping by Customer_Name and summing their total sales
  2. Sorting in ascending order to get the lowest revenue customers
~~~
SELECT TOP 10
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM
    KMS_Orders
GROUP BY
    Customer_Name
ORDER BY
    Total_Sales ASC;
~~~
### 5: Which shipping method incurred the highest total shipping cost?
  - 🧮 Steps Taken:
   1. Grouping data by Ship_Mode
   2. Summing the Shipping_Cost for each method
   3. Sorting in descending order to see the most expensive on top
   4. Using TOP 1 to return only the highest one
~~~
SELECT TOP 1
    Ship_Mode,
    SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM
    KMS_Orders
GROUP BY
    Ship_Mode
ORDER BY
    Total_Shipping_Cost DESC;
~~~

### 6:Who are the top 5 most valuable customers by total sales?
~~~
SELECT TOP 5
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM
    KMS_Orders
GROUP BY
    Customer_Name
ORDER BY
    Total_Sales DESC;
~~~

### 7:Which customer in the 'Small Business' segment generated the highest total sales?
  - 🧮 Steps Taken:
1. Filter only 'Small Business' customers
2. Group by Customer_Name to calculate total sales
3. Sort by total sales in descending order
4. Use TOP 1 to return the highest

~~~
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
~~~

### 8: Which Corporate segment customer made the most orders between 2009 and 2012?
   - 🧮 Steps Taken:
   1. Filter customers in the 'Corporate' segment
   2. Filter orders between 2009 and 2012 using Order_Date
   3. Group by Customer_Name and count how many times each customer appears
   4. Sort in descending order to get the highest
   5. Use TOP 1 to get the customer with the most orders
~~~
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
~~~

 ### 9:Who is the most profitable customer in the 'Consumer' segment?
  - 🧮 Steps Taken:
  1. Filter customers in the 'Consumer' segment
  2. Group by Customer_Name
  3. Sum their total profit
  4. Sort by profit in descending order
~~~
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
~~~

### 10. Is the company using the correct shipping methods based on order priority?
   - 🧮 Steps Taken:
   1. Count how many orders used each shipping method by order priority  
   2. This helps spot any mismatch (e.g. High priority orders using slow or cheap shipping methods like Delivery Truck)

~~~
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
~~~
## 🧠 Insights & Recommendations

Based on the SQL analysis, here are some key insights:

- **Office Supplies** generated the highest sales, but **Furniture** yielded higher profit margins.
- **Western and Northern regions** performed better in terms of sales, while **South-East** lagged behind.
- **High-priority orders** were sometimes shipped using slower or cheaper methods like *Delivery Truck*, which may affect customer satisfaction.
- **The top 10 customers** significantly contributed to overall revenue — offering loyalty rewards could boost retention.
- **The bottom 10 customers** spent the least — targeted marketing or bundle discounts may increase their order volume.
- **Appliances in Ontario** showed lower sales compared to other categories, indicating room for promotion or improved distribution.
- The most valuable customers typically ordered **high-volume office supplies** — KMS can upsell related products to them.

These findings can help KMS optimize product focus, improve shipping logistics, and maximize revenue from both top and low-performing customer groups.

