# pizza_sale
# 🍕 Pizza Sales Analysis :-

📊 Analyzing pizza sales data to uncover customer preferences, sales trends, and insights using SQL & data visualization tools. Sales Analysis with SQL :-

## 📌 Project Overview

This project explores retail sales data using SQL to uncover insights such as :

- Best - selling products
- Seasonal trends in sales
- Customer purchasing behavior
- Store - level performance
-  Level: Beginner

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze pizza sales data. The project involves setting up a pizza sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.
The goal is to demonstrate SQL querying, data analysis, and business intelligence skills by analyzing real-world  sales patterns.



## 📂 Dataset :-
The dataset used is:
📄 SQL - "pizza_sales"

## It includes fields like:
- pizza_type_id  – Unique type_id reference
- Date  – Transaction date
- Revenue  – revenue sales
- category  – Classic , Supreme , Veggie
- Quantity  – Units sold
- Price  – Price per unit
- TotalAmount  – Transaction amount

## 🛠️ Tools & Technologies
- SQL (MySQL ) For querying the dataset
- GitHub – For version control & collaboration


## Objectives:-
   Set up a pizza_hut sales database: Create and populate a retail sales database with the provided sales data.

### 📑Data Cleaning:   
  Identify and remove any records with missing or null values.

   
### Exploratory Data Analysis (EDA):
Perform basic exploratory data analysis to understand the dataset.

   
### 📈 Business Analysis:

Use SQL to answer specific business questions and derive insights from the sales data.


# 💻 Project Structure
1. Database Setup
Database Creation: The project starts by creating a database named pizza_hut.
Table Creation: A table named orders , order_details , pizza_types , pizzas is created to store the sales data.
The table structure includes columns for order_id, sale date, sale time, pizza_type_id, qunatity, category, quantity sold, price per unit and total sale amount.
       
2. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

 1.Retrieve the total number of orders placed.
   ```sql
            select count(*)  as 'Total_orders' 
            from orders;

   ```
2.Calculate the total revenue generated from pizza sales.:
```sql
       SELECT 
       ROUND(SUM((quantity * price)), 2) AS 'Total_revenue'
   FROM
       order_details AS o
   JOIN   
        pizzas AS p 
   ON o.pizza_id = p.pizza_id;

```
 3.Identify the highest-priced pizza.

```sql
   SELECT 
    name, price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY price DESC
LIMIT 1;
```


 4.Identify the most common pizza size ordered.
```sql
    SELECT 
    size, COUNT(order_id) AS 'Order_count'
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size
ORDER BY order_count DESC;
```


5.List the top 5 most ordered pizza types along with their quantities.
```sql    
    SELECT 
        category,
        gender,
        COUNT(*) as total_trans
    FROM retail_sales
    GROUP 
        BY 
        category,
        gender
    ORDER BY 1
```

6.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
```sql
   SELECT 
    name, SUM(quantity) AS 'Quantity'
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY quantity DESC
LIMIT 5;

```

## INTERMEDIATE :-
1.Join the necessary tables to find the total quantity of each pizza category ordered.
 
```sql   
   SELECT DISTINCT
    category, SUM(quantity) AS 'Total_quantity'
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY total_quantity DESC;

-- 2.Determine the distribution of orders by hour of the day.
-- Orders by hour of the day
-- Step1-  extract hours from order_time
SELECT 
    HOUR(time) AS hours, COUNT(order_id) AS 'Order_count'
FROM
    orders
GROUP BY hours;
```

## Findings:-

- Customer Demographics:
  The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- High-Value Transactions:
 Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- Sales Trends:
 Monthly analysis shows variations in sales, helping identify peak seasons.
- Customer Insights:
  The analysis identifies the top-spending customers and the most popular product categories.
  Reports
- Sales Summary:
  A detailed report summarizing total sales, revenue demographics, and category performance.
- Trend Analysis:
  Insights into sales trends across different months and shifts.
- Customer Insights:
  Reports on top customers and unique customer counts per category.

## 🎯 Project Highlights

✔️ Practical pizza_sale dataset

✔️ SQL for business insights

✔️ Beginner-friendly but expandable for advanced analysis



## 🚀 How to Run the Project- 

- 1.Clone the Repository:  Clone this project repository from GitHub.

      git clone https://github.com/kavitakamat21/sql_sales_p1.git
2. Import the dataset into your SQL database.

3. Run the queries from queries.sql file.


## 📬 Contact

👩‍💻 Author: Kavita Kamat

📧 Email: kavitakamat22@gmail.com










































