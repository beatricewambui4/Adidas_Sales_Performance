CREATE DATABASE Adidas_Analytics;
USE  Adidas_Analytics;

CREATE TABLE Adidas_Analytics_Table(
OrderID VARCHAR(50), 
OrderDate DATE, 
Region TEXT, 
Category VARCHAR(100), 
SalesRep VARCHAR(100), 
UnitsSold DECIMAL(20,5),
UnitPrice DECIMAL(20,5), 
Discount DECIMAL(20,5), 
CustomerEmail VARCHAR(100)
);
SELECT*FROM adidas_analytics_table;

SHOW DATABASES;
#ANALYSIS
#total units sold
SELECT
SUM(Units_Sold) AS Total_Units_Sold
FROM adidas_analytics_table;

#total orders made
SELECT
COUNT(*) AS Total_Orders
FROM adidas_analytics_table;

#total revenue generated
SELECT
SUM(Total_Sales) AS Total_Revenue
FROM adidas_analytics_table;

#total profit 
SELECT
SUM(Operating_Profit) AS Total_Profit
FROM adidas_analytics_table;

#Total Cost of Goods
SELECT
SUM(Total_Sales)-SUM(Operating_Profit) AS Total_Cost
FROM adidas_analytics_table;

#Average Sales
SELECT
AVG(Total_Sales) AS Average_Revenue
FROM adidas_analytics_table;

#total retailes
SELECT
COUNT(DISTINCT Retailer) AS Total_Retailers
 FROM adidas_analytics_table;
 
 SELECT
count(DISTINCT Retailer)
 FROM adidas_analytics_table;
 
 
 #Are there retailers_id connected to  more than one retailers
SELECT
    Retailer_Id,
    COUNT(DISTINCT Retailer) AS Total_Retailers
FROM adidas_analytics_table
GROUP BY Retailer_Id
HAVING COUNT(DISTINCT Retailer) > 1;

#Average Order Value
SELECT
SUM(Total_Sales)/COUNT(*) AS Average_Order_Value
FROM adidas_analytics_table;
 
#most selling product
SELECT
SUM(Total_Sales) AS Total_Sales,
Product
FROM adidas_analytics_table
GROUP BY Product
ORDER BY Total_Sales DESC;

#repeating Retailers
SELECT
Retailer,
COUNT(*) AS Total_Orders
FROM adidas_analytics_table
GROUP BY Retailer
HAVING Total_Orders> 200;


#TOTAL PRODUCTS SOLD BY PRODUCT
SELECT
SUM(Units_Sold) AS Total_Items_Sold,
Product
FROM adidas_analytics_table
GROUP BY Product
ORDER BY Total_Items_Sold DESC;

#retailer generating the most revenue ranking
SELECT
SUM(Total_Sales) AS Total_Sales,
Retailer,
RANK() OVER(ORDER BY SUM(Total_Sales) DESC) AS Retailer_Rankings
FROM adidas_analytics_table
GROUP BY Retailer
ORDER BY Total_Sales DESC;

#running total
WITH Monthly_Sales AS(
		SELECT
        SUM(Total_Sales) AS Total_Revenue,
        Month_Name,
        Month_Num
        FROM adidas_analytics_table
        GROUP BY Month_Name,Month_Num
)

SELECT 
Month_Name,
Total_Revenue,
SUM(Total_Revenue) OVER(ORDER BY Month_Num) AS Running_Totals
FROM Monthly_Sales
ORDER BY Month_Num;

#RUNNING DAILY TOTALS
WITH Daily_Totals AS(
	SELECT
    Day_Num,
    Day_Name,
    SUM(Total_Sales) AS Daily_Running_Totals
    FROM adidas_analytics_table
    GROUP BY Day_Name,Day_Num
)
SELECT
Day_Name,
Daily_Running_Totals,
SUM(Daily_Running_Totals) OVER(ORDER BY Day_Num ) AS Running_Totals
FROM Daily_Totals
ORDER BY Day_Num;

#rolling totals 12 MONTHS REVENUE TREND
WITH 12_Months_Revenue AS(
	SELECT 
    Month_Num,
    Month_Name,
    SUM(Total_Sales) AS Total_Revenue
    FROM adidas_analytics_table
    GROUP BY Month_Name,Month_Num
)

SELECT
Month_Name,
Total_Revenue,
SUM(Total_Revenue) OVER(
		ORDER BY Month_Num
        ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
) AS 12Months_Rolling_Totals
FROM 12_Months_Revenue;

SELECT
Invoice_Date,
Total_Sales,
SUM(Total_Sales) OVER(
ORDER BY Invoice_Date
) RunningSales
FROM adidas_analytics_table;

#Retailer selling the most products 
SELECT
SUM(Units_Sold) AS Total_Items_Sold,
Retailer
FROM adidas_analytics_table
GROUP BY Retailer
ORDER BY Total_Items_Sold DESC;

#REGION GENERATING THE MOST REVENUE
SELECT
SUM(Total_Sales) AS Total_Revenue,
Region
FROM adidas_analytics_table
GROUP BY Region
ORDER BY Total_Revenue;

#region tha sells the most 
SELECT
SUM(Units_Sold) AS Total_Units_Sold,
Region
FROM adidas_analytics_table
GROUP BY Region
ORDER BY Total_Units_Sold;

#the states that generates the most revenue
SELECT
SUM(Total_Sales) AS Total_Revenue,
City
FROM adidas_analytics_table
GROUP BY City
ORDER BY Total_Revenue DESC;

#total items sold by state
SELECT
SUM(Units_Sold) AS Total_Items_Sold,
City
FROM adidas_analytics_table
GROUP BY City
ORDER BY Total_Items_Sold DESC;

#sales method that generates the most revenue
SELECT
SUM(Total_Sales) AS Total_Revenue,
Sales_Method
FROM adidas_analytics_table
GROUP BY Sales_Method 
ORDER BY Total_Revenue DESC;

#the year that generates the most revenue
SELECT
SUM(Total_Sales) AS Total_Revenue
,Year_Num
FROM adidas_analytics_table
GROUP BY Year_Num
ORDER BY Total_Revenue DESC;

#Month that generates the most revenue
SELECT
SUM(Total_Sales) AS Total_Revenue,
Month_Name
FROM adidas_analytics_table
GROUP BY Month_Num,Month_Name
ORDER BY Total_Revenue DESC;

#revenue by day
SELECT 
Day_Name,
SUM(Total_Sales) AS Total_Revenue
FROM adidas_analytics_table
GROUP BY Day_Name
ORDER BY Total_Revenue DESC;



























