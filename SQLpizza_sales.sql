/*
Pizza Sales Data Exploration 
This project analyzes key indicators for pizza sales data to gain insights into business performance.
Skills used: aggregate functions, date and time functions, subqueries, performance optimization
*/

--------------------------------------------------------------------------------------------------------------------------
/*Total Revenue*/

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

--------------------------------------------------------------------------------------------------------------------------
/*Average Order Value*/

SELECT SUM(total_price)/ COUNT (DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales

--------------------------------------------------------------------------------------------------------------------------
/* Total Pizzas Sold*/

SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales

--------------------------------------------------------------------------------------------------------------------------
/* Total Orders*/

SELECT COUNT( DISTINCT order_id) AS Total_Orders FROM pizza_sales

--------------------------------------------------------------------------------------------------------------------------
/*Average Pizzas Per Order*/

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT( DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL (10,2)) AS Average_Pizzas_Per_Order FROM pizza_sales

--------------------------------------------------------------------------------------------------------------------------
/*Hourly Trend for Total Pizzas Sold*/

USE [Pizza DB]

SELECT DATEPART(HOUR, order_time) AS Order_Hour, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--------------------------------------------------------------------------------------------------------------------------
/*Weekly Trend for Total Orders*/

SELECT 
	DATEPART(ISO_WEEK, order_date) AS Week_Number, 
	YEAR(order_date) AS Year, 
	COUNT( DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY 
	DATEPART(ISO_WEEK, order_date), 
	YEAR(order_date)
ORDER BY Year, Week_Number

--------------------------------------------------------------------------------------------------------------------------
/*% of Sales by Pizza Category*/

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Sales, 
CAST(SUM(total_price) *100/ (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10,2)) AS Percent_of_Sales
FROM pizza_sales
GROUP BY pizza_category

--------------------------------------------------------------------------------------------------------------------------
/*% of Sales by Pizza Size*/

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Sales, 
CAST(SUM(total_price) *100/ (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10,2)) AS Percent_of_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY case when pizza_size  = 'S' then 1
              when pizza_size  = 'M' then 2
              when pizza_size  = 'L' then 3
              when pizza_size  = 'XL' then 4
			  when pizza_size  = 'XXL' then 5
             END
--------------------------------------------------------------------------------------------------------------------------
/*QUARTER 1 % of Sales by Pizza Size*/

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Sales, 
CAST(SUM(total_price) *100/ (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) =1) AS DECIMAL (10,2)) AS Percent_of_Sales
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) =1
GROUP BY pizza_size
ORDER BY case when pizza_size  = 'S' then 1
              when pizza_size  = 'M' then 2
              when pizza_size  = 'L' then 3
              when pizza_size  = 'XL' then 4
			  when pizza_size  = 'XXL' then 5
             END
--------------------------------------------------------------------------------------------------------------------------
/*Total Pizzas Sold by Pizza Category*/

SELECT pizza_category, COUNT(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--------------------------------------------------------------------------------------------------------------------------
/*Top and Bottom 5 Pizzas by Revenue, Total Quantity and Total Orders*/

--------------------------------------------------------------------------------------------------------------------------
/*Top 5 Best Selling Pizzas by Revenue*/

SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--------------------------------------------------------------------------------------------------------------------------
/*Bottom 5 Pizzas by Revenue*/

SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue 

--------------------------------------------------------------------------------------------------------------------------
/*Top 5 Pizzas by Total Quantity*/

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

--------------------------------------------------------------------------------------------------------------------------
/*Bottom 5 Pizzas by Total Quantity*/

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity

--------------------------------------------------------------------------------------------------------------------------
/*Top 5 Pizzas by Total Orders*/

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--------------------------------------------------------------------------------------------------------------------------
/*Bottom 5 Pizzas by Total Orders*/

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders