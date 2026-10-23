--Creating Aisles Table
CREATE TABLE Aisle_Table(
	Aisle_id INTEGER PRIMARY KEY,
	Aisle VARCHAR(30)
);

--Cashiers Table
CREATE TABLE Cashiers_Table(
	Cashier_id INTEGER PRIMARY KEY,
	Cashier_Name VARCHAR(50),
	Store_Location VARCHAR(20),
	Gender VARCHAR(2),
	Salary INTEGER
);

--Customer Table
CREATE TABLE Customers_Table(
	customer_id INTEGER PRIMARY KEY,
	First_Name VARCHAR(10),
	Last_Name VARCHAR(10),
	Email VARCHAR(30),
	Adress VARCHAR(30),
	Phone_Number INTEGER,
	Age INTEGER,
	Gender VARCHAR(5)
);

--Department Table
CREATE TABLE Department_Table(
	Department_id INTEGER PRIMARY KEY,
	Department VARCHAR(50)
	);
--Order Table
CREATE TABLE Order_Table(
    Order_id VARCHAR(50) PRIMARY KEY,
    Customer_id INTEGER,
    Order_date DATE,
    Order_time TIME,
    Product_id VARCHAR(20),
    Quantity INTEGER,
    Cashier_id VARCHAR(20),
    Payment_type VARCHAR(30),
    FOREIGN KEY (Customer_id) REFERENCES Customer_Table(Customer_id)
);

--Product Table
CREATE TABLE Product_table(
	Product_id VARCHAR(20) PRIMARY KEY,
	Product_name VARCHAR(30),
	Aisle_id INTEGER,
	Department_id INTEGER,
	unit_price INTEGER,
	Unit_cost NUMERIC(10,2),
	FOREIGN KEY (Department_id) REFERENCES Department_Table(Department_id),
	FOREIGN KEY (Aisle_id) REFERENCES Aisle_Table(Aisle_id)
);

ALTER TABLE Aisle_Table
ALTER COLUMN Aisle TYPE VARCHAR(30);

--View Table
SELECT *
FROM Cashiers_table	

ALTER TABLE Cashiers_Table
ALTER COLUMN Cashier_id TYPE VARCHAR(20);


ALTER TABLE Cashiers_Table
ALTER COLUMN Gender TYPE VARCHAR(1);


ALTER TABLE Cashiers_Table
ADD COLUMN Store_Location VARCHAR(20),
ADD COLUMN Gender VARCHAR(2),
ADD COLUMN Salary INTEGER;



INSERT INTO Cashiers_Table
(Cashier_id, Cashier_Name, Store_Location, Gender, Salary)
VALUES
('CAS01', 'Olivia Parker', 'USA', 'F', 700),
('CAS02', 'Ethan Carter', 'Brazil', 'M', 850),
('CAS03', 'Ava Morgan', 'USA', 'F', 800),
('CAS04', 'Emma Brooks', 'USA', 'F', 750),
('CAS05', 'Liam Bennett', 'Canada', 'M', 700),
('CAS06', 'Sophia Reed', 'Canada', 'F', 850),
('CAS07', 'Noah Reed', 'Nigeria', 'M', 800),
('CAS08', 'Mia Collins', 'France', 'F', 750),
('CAS09', 'Isabella Hayes', 'Australia', 'F', 800),
('CAS10', 'Aiden Scott', 'UAE', 'M', 900),
('CAS11', 'Amelia Bennett', 'Nigeria', 'F', 500),
('CAS12', 'Mason Hayes', 'Brazil', 'M', 650),
('CAS13', 'Harper Scott', 'Ghana', 'F', 600),
('CAS14', 'Evelyn Carter', 'UK', 'F', 550),
('CAS15', 'Abigail Turner', 'USA', 'F', 700),
('CAS16', 'Emily Cooper', 'Sweden', 'F', 850),
('CAS17', 'Lily Hughes', 'Nigeria', 'F', 800),
('CAS18', 'James Foster', 'Germany', 'M', 750),
('CAS19', 'Chloe Bryant', 'Japan', 'F', 700),
('CAS20', 'Lucas Parker', 'Switzerland', 'M', 700),
('CAS21', 'Scarlett Bailey', 'UAE', 'F', 850),
('CAS22', 'Zoe Price', 'Japan', 'F', 800),
('CAS23', 'Grace Powell', 'Japan', 'F', 750),
('CAS24', 'Alexander Brooks', 'France', 'M', 700),
('CAS25', 'Ellie Foster', 'UK', 'F', 850),
('CAS26', 'Elijah Morgan', 'Japan', 'M', 800),
('CAS27', 'Mila James', 'Germany', 'F', 750),
('CAS28', 'Benjamin Cooper', 'Australia', 'M', 800),
('CAS29', 'Aria Mitchell', 'France', 'F', 900),
('CAS30', 'Hannah Clark', 'Japan', 'F', 500),
('CAS31', 'Riley Simmons', 'Ghana', 'F', 700),
('CAS32', 'Henry Bailey', 'Japan', 'M', 850),
('CAS33', 'Bella King', 'Nigeria', 'F', 800),
('CAS34', 'Nora Kelly', 'UAE', 'F', 750),
('CAS35', 'Layla Ross', 'USA', 'F', 700),
('CAS36', 'Jackson Turner', 'Germany', 'M', 850),
('CAS37', 'Victoria Barnes', 'UK', 'F', 800),
('CAS38', 'Zoey Rivera', 'Germany', 'F', 700),
('CAS39', 'Addison Cox', 'UAE', 'F', 850),
('CAS40', 'Owen Bryant', 'Germany', 'M', 800),
('CAS41', 'Willow Richardson', 'Switzerland', 'F', 750),
('CAS42', 'Paisley Long', 'UAE', 'F', 700),
('CAS43', 'Audrey Stewart', 'UAE', 'F', 850),
('CAS44', 'Maya Evans', 'USA', 'F', 800),
('CAS45', 'Piper Myers', 'UAE', 'F', 750);





ALTER TABLE Customer_table
ALTER COLUMN Phone_number TYPE VARCHAR(50);

ALTER TABLE Customer_table
ALTER COLUMN Gender TYPE VARCHAR(50);


ALTER TABLE Customer_table
ALTER COLUMN First_name TYPE VARCHAR(20);


ALTER TABLE Customer_table
ALTER COLUMN Last_name TYPE VARCHAR(20);


ALTER TABLE Customer_table
ALTER COLUMN Email TYPE VARCHAR(50);

ALTER TABLE Product_table
ALTER COLUMN Product_name TYPE VARCHAR(500);






--QUESTION 1

/*What are the top-selling products by revenue, and how much revenue have they
generated?*/



SELECT
	product_name,
	SUM(unit_price * quantity) AS Revenue
FROM Product_table AS p
INNER JOIN Order_table AS o
ON o.product_id = p.product_id
GROUP BY product_name
ORDER BY Revenue DESC
LIMIT 10


--QUESTION 2

/*On which day of the week are chocolates mostly sold?*/

SELECT
    TO_CHAR(o.Order_date, 'Day') AS day_of_week,
    COUNT(*) AS chocolate_sales
FROM Order_Table AS o
JOIN Product_table AS p
    ON o.Product_id = p.Product_id
WHERE LOWER(p.Product_Name) LIKE '%chocolate%'
GROUP BY TO_CHAR(o.Order_date, 'Day'), EXTRACT(DOW FROM o.Order_date)
ORDER BY chocolate_sales DESC;
--On Saturdays, Chocolate are mostly sold 


--QUESTION 3

/*Do we have any department that generated more than $15 million in revenue?
If so, what was the profit generated by that department?*/

SELECT 
	department,
	SUM(p.unit_price * quantity) AS Revenue
FROM Order_table AS o
LEFT JOIN Product_table AS p
ON p.product_id = o.product_id
LEFT JOIN Department_table AS d
ON d.department_id = p.department_id
GROUP BY department 
ORDER BY department DESC

--pantry,snacks and personal care
/* Formula for calculating Profit is, Toatal Revenue - Total Cost.
Now we want to find the total cost*/

--Calculating the total cost
SELECT
	SUM(unit_cost * quantity) AS Total_cost
FROM product_table AS p
JOIN order_table AS o
ON o.product_id = p.product_id

--Calculating the Profit

SELECT
	department,
    SUM((p.unit_price - p.unit_cost) * o.quantity) AS Profit
FROM product_table AS p
JOIN order_table AS o
    ON o.product_id = p.product_id
JOIN department_table AS d
ON d.department_id = p.department_id
WHERE department = 'pantry'
GROUP BY department





--QUESTION 4

--Is it true that customers buy more alcoholic products on Christmas Day 2019?
SELECT
	order_date,
	COUNT(product_name) AS Product_name
FROM product_table AS p
LEFT JOIN Order_table AS o
ON o.product_id = p.product_id
WHERE product_name ILIKE '%Alcohol%'
AND order_date = '2019-12-25'
GROUP BY order_date
--No. Customers do not buy alcohol at all on Christmas day.



--Question 5
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
	SUM((p.unit_price - p.unit_cost) * o.quantity) AS Profit
FROM product_table AS p
JOIN order_table AS o
ON p.product_id =o.product_id
WHERE EXTRACT(YEAR FROM order_date) BETWEEN 2015 AND 2023
GROUP BY year

--In the year 2020, we generated the most profit


--Question 6


SELECT
    COUNT(*) AS atm_transactions
FROM order_table AS o
WHERE payment_type = 'ATM'
AND EXTRACT(YEAR FROM order_date) = 2023;
--No. Instead, it decreased.



--Question 7

--Morning
SELECT 
	product_name,
	order_time
FROM order_table AS o
JOIN product_table AS p
ON p.product_id = o.product_id
WHERE product_name ILIKE '%Alcohol%'
AND Order_time BETWEEN '00:00:00' AND '11:59:59'


--Afternoon
SELECT 
	product_name,
	order_time
FROM order_table AS o
JOIN product_table AS p
ON p.product_id = o.product_id
WHERE product_name ILIKE '%Alcohol%'
AND Order_time BETWEEN '12:00:00' AND '15:59:59'


--Evening
SELECT 
	product_name,
	order_time
FROM order_table AS o
JOIN product_table AS p
ON p.product_id = o.product_id
WHERE product_name ILIKE '%Alcohol%'
AND Order_time BETWEEN '16:00:00' AND '23:59:59'

/*
Morning = 288
Afternoon = 429
Evening = 540

So in the evening is when people usually buy alcohol the most*/


--Question 8

--Qrt 1
SELECT
    EXTRACT(YEAR FROM o.order_date) AS Year,
    SUM(p.unit_price * o.quantity) AS total_revenue
FROM order_table AS o
JOIN product_table AS p
    ON p.product_id = o.product_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2016
  AND EXTRACT(MONTH FROM o.order_date) IN (4, 5, 6)
  AND p.product_name ILIKE '%Bread%'
GROUP BY EXTRACT(YEAR FROM o.order_date);





--Qrt 2
SELECT
    EXTRACT(YEAR FROM o.order_date) AS Year,
    SUM(p.unit_price * o.quantity) AS total_revenue
FROM order_table AS o
JOIN product_table AS p
    ON p.product_id = o.product_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2016
  AND EXTRACT(MONTH FROM o.order_date) IN (7, 8, 9)
  AND p.product_name ILIKE '%Bread%'
GROUP BY EXTRACT(YEAR FROM o.order_date);



--Question 9

SELECT
    p.product_name,
    COUNT(*) AS total_purchases
FROM product_table AS p
JOIN order_table AS o
    ON o.product_id = p.product_id
WHERE (
    o.order_time >= '21:00'
    OR o.order_time <= '04:00'
)
AND o.order_date >= '2020-01-01'
AND o.order_date < '2023-01-01'
GROUP BY p.product_name
ORDER BY total_purchases DESC
LIMIT 3;



--Question 10


SELECT
    SUM(p.unit_price * o.quantity) AS juice_revenue,
    ROUND(
        SUM(p.unit_price * o.quantity) * 100.0 /
        NULLIF((
            SELECT SUM(p2.unit_price * o2.quantity)
            FROM product_table AS p2
            JOIN order_table AS o2
                ON p2.product_id = o2.product_id
        ), 0),
        2
    ) AS revenue_percentage
FROM product_table AS p
JOIN order_table AS o
    ON p.product_id = o.product_id
WHERE p.product_name ILIKE '%Juice%';
	
