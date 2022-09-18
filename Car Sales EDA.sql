-- Project Description
-- This project is mainly focused on EDA (Exploratory Data Analysis) from car sales dataset that obtain from Kaggle. There are 6 query shown in below SQL code to assist decision making process from the dataset.

-- Dataset Link: https://www.kaggle.com/datasets/gagandeep16/car-sales

-- Data preprocessing SQL syntax is after the EDA query to make the reader easily read the main section of the project


-- EDA SECTION
-- 1. What is the top 2 most sold model from each car manufacturer?
SELECT manufacturer, model, sales_in_thousands
FROM (
	SELECT
		manufacturer,
		model,
		sales_in_thousands,
		DENSE_RANK() OVER(PARTITION BY manufacturer ORDER BY sales_in_thousands DESC) AS rnk
	FROM car_sales
) a
WHERE a.rnk < 3;

-- 2. What is the most sold type of car between passenger and non-passenger type?
SELECT
	vehicle_type,
	SUM(sales_in_thousands) AS total_sold_in_thousands
FROM car_sales
GROUP BY vehicle_type
ORDER BY total_sold_in_thousands DESC;

-- 3. Which manufacturer gain the most number of car sales, and what is the total sales they make?
SELECT
	manufacturer,
	SUM(sales_in_thousands) AS total_sales_in_thousands
FROM car_sales
GROUP BY manufacturer
ORDER BY total_sales_in_thousands DESC;

-- 4. Which car from each brand has the highest year resale value?
SELECT manufacturer, model, year_resale_value
FROM (
	SELECT
		manufacturer,
		model,
		year_resale_value,
		DENSE_RANK() OVER(PARTITION BY manufacturer ORDER BY year_resale_value DESC) AS rnk
	FROM car_sales
) a
WHERE a.rnk = 1
ORDER BY a.year_resale_value DESC;

-- 5. Do fuel efficiency feature correlates with people buying car or not?
SELECT
	fuel_efficiency,
	SUM(sales_in_thousands) AS sales_in_thousands
FROM car_sales
GROUP BY fuel_efficiency
ORDER BY fuel_efficiency;
-- Answer: There's no correlation between fuel efficiency and people buying car or not, because, based on the data, vehicle with efficient fuel not always get a higher total sales, and vehicle with inefficient fuel not always get a low total sales

-- 6. Do low-priced car has a higher sales compared to a car with higher prices?
SELECT
	'1 - 10' AS price_category_in_thousands,
	SUM(sales_in_thousands) AS sales_in_thousands
FROM car_sales
WHERE price_in_thousands >= 1 AND price_in_thousands <= 10;

SELECT
	'11 - 30' AS price_category_in_thousands,
	SUM(sales_in_thousands) AS sales_in_thousands
FROM car_sales
WHERE price_in_thousands >= 11 AND price_in_thousands <= 30;

SELECT
	'31 - 50' AS price_category_in_thousands,
	SUM(sales_in_thousands) AS sales_in_thousands
FROM car_sales
WHERE price_in_thousands >= 31 AND price_in_thousands <= 50;

SELECT
	'51 - 70' AS price_category_in_thousands,
	SUM(sales_in_thousands) AS sales_in_thousands
FROM car_sales
WHERE price_in_thousands >= 51 AND price_in_thousands <= 70;

SELECT
	'> 70' AS price_category_in_thousands,
	SUM(sales_in_thousands) AS sales_in_thousands
FROM car_sales
WHERE price_in_thousands >= 71;
-- Answer: There's a correlation between car price and total sales, because, based on the data that already grouped by price category, the higher the price, the lower the car total sales, and the lower the price, the higher the total sales


-- DATA PREPROCESSING SECTION
-- Dataset Overview
SELECT TOP 5 * FROM car_sales;

-- Handling Missing Value For "__year_resale_value" column
UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'BMW'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'BMW';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Cadillac'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Cadillac';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Chevrolet'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Chevrolet';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Chrysler';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Dodge'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Dodge';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Ford'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Ford';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Lexus'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Lexus';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Lincoln'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Lincoln';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Mercedes-B'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Mercedes-B';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Nissan'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Nissan';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Oldsmobile'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Oldsmobile';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Plymouth'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Plymouth';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Pontiac'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Pontiac';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Saturn'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Saturn';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Toyota'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Toyota';

UPDATE car_sales
SET __year_resale_value = (
	SELECT AVG(__year_resale_value) FROM car_sales
	WHERE Manufacturer = 'Volkswagen'
) WHERE __year_resale_value IS NULL AND Manufacturer = 'Volkswagen';

UPDATE car_sales
SET __year_resale_value = 0
WHERE __year_resale_value IS NULL AND Manufacturer = 'Jaguar';

UPDATE car_sales
SET __year_resale_value = 0
WHERE __year_resale_value IS NULL AND Manufacturer = 'Saab';

UPDATE car_sales
SET __year_resale_value = 0
WHERE __year_resale_value IS NULL AND Manufacturer = 'Subaru';

UPDATE car_sales
SET __year_resale_value = 0
WHERE __year_resale_value IS NULL AND Manufacturer = 'Volvo';

-- Handling Missing Value For "Price_in_thousands" column
UPDATE car_sales
SET Price_in_thousands = (
	SELECT AVG(Price_in_thousands) FROM car_sales
	WHERE Manufacturer = 'Acura'
) WHERE Price_in_thousands IS NULL AND Manufacturer = 'Acura';

UPDATE car_sales
SET Price_in_thousands = (
	SELECT AVG(Price_in_thousands) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE Price_in_thousands IS NULL AND Manufacturer = 'Chrysler';

-- Handling Missing Value For "Engine_size" column
UPDATE car_sales
SET Engine_size = (
	SELECT AVG(Engine_size) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE Engine_size IS NULL AND Manufacturer = 'Chrysler';

-- Handling Missing Value For "Horsepower" column
UPDATE car_sales
SET Horsepower = (
	SELECT AVG(Horsepower) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE Horsepower IS NULL AND Manufacturer = 'Chrysler';

-- Handling Missing Value For "Wheelbase" column
UPDATE car_sales
SET Wheelbase = (
	SELECT AVG(Wheelbase) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE Wheelbase IS NULL AND Manufacturer = 'Chrysler';

-- Handling Missing Value For "Width" column
UPDATE car_sales
SET Width = (
	SELECT AVG(Width) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE Width IS NULL AND Manufacturer = 'Chrysler';

-- Handling Missing Value For "Length" column
UPDATE car_sales
SET Length = (
	SELECT AVG(Length) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE Length IS NULL AND Manufacturer = 'Chrysler';

-- Handling Missing Value For "Curb_weight" column
UPDATE car_sales
SET Curb_weight = (
	SELECT AVG(Curb_weight) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE Curb_weight IS NULL AND Manufacturer = 'Chrysler';

UPDATE car_sales
SET Curb_weight = (
	SELECT AVG(Curb_weight) FROM car_sales
	WHERE Manufacturer = 'Cadillac'
) WHERE Curb_weight IS NULL AND Manufacturer = 'Cadillac';

-- Handling Missing Value For "Fuel_capacity" column
UPDATE car_sales
SET Fuel_capacity = (
	SELECT AVG(Fuel_capacity) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE Fuel_capacity IS NULL AND Manufacturer = 'Chrysler';

-- Handling Missing Value For "Fuel_efficiency" column
UPDATE car_sales
SET Fuel_efficiency = (
	SELECT AVG(Fuel_efficiency) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE Fuel_efficiency IS NULL AND Manufacturer = 'Chrysler';

UPDATE car_sales
SET Fuel_efficiency = (
	SELECT AVG(Fuel_efficiency) FROM car_sales
	WHERE Manufacturer = 'Dodge'
) WHERE Fuel_efficiency IS NULL AND Manufacturer = 'Dodge';

UPDATE car_sales
SET Fuel_efficiency = (
	SELECT AVG(Fuel_efficiency) FROM car_sales
	WHERE Manufacturer = 'Oldsmobile'
) WHERE Fuel_efficiency IS NULL AND Manufacturer = 'Oldsmobile';

-- Handling Missing Value For "Power_perf_factor" column
UPDATE car_sales
SET Power_perf_factor = (
	SELECT AVG(Power_perf_factor) FROM car_sales
	WHERE Manufacturer = 'Chrysler'
) WHERE Power_perf_factor IS NULL AND Manufacturer = 'Chrysler';

UPDATE car_sales
SET Power_perf_factor = (
	SELECT AVG(Power_perf_factor) FROM car_sales
	WHERE Manufacturer = 'Acura'
) WHERE Power_perf_factor IS NULL AND Manufacturer = 'Acura';

-- Remove Unused Time At latest_launch Column
ALTER TABLE car_sales
ALTER COLUMN Latest_Launch DATE;

UPDATE car_sales
SET Latest_Launch = CAST(Latest_Launch AS DATE);

-- Generalized Number To 1 Decimal Point
UPDATE car_sales
SET Sales_in_thousands = ROUND(Sales_in_thousands, 1);

UPDATE car_sales
SET __year_resale_value = ROUND(__year_resale_value, 1);

UPDATE car_sales
SET Price_in_thousands = ROUND(Price_in_thousands, 1);

UPDATE car_sales
SET Engine_size = ROUND(Engine_size, 1);

UPDATE car_sales
SET Horsepower = ROUND(Horsepower, 0);

UPDATE car_sales
SET Wheelbase = ROUND(Wheelbase, 1);

UPDATE car_sales
SET Width = ROUND(Width, 1);

UPDATE car_sales
SET Length = ROUND(Length, 1);

UPDATE car_sales
SET Curb_weight = ROUND(Curb_weight, 1);

UPDATE car_sales
SET Fuel_capacity = ROUND(Fuel_capacity, 1);

UPDATE car_sales
SET Power_perf_factor = ROUND(Power_perf_factor, 1);

-- Lowercased And Remove Unwanted Character From Column Name
EXEC sp_rename 'car_sales.Manufacturer', 'manufacturer';
EXEC sp_rename 'car_sales.Model', 'model';
EXEC sp_rename 'car_sales.Sales_in_thousands', 'sales_in_thousands';
EXEC sp_rename 'car_sales.__year_resale_value', 'year_resale_value';
EXEC sp_rename 'car_sales.Vehicle_type', 'vehicle_type';
EXEC sp_rename 'car_sales.Price_in_thousands', 'price_in_thousands';
EXEC sp_rename 'car_sales.Engine_size', 'engine_size';
EXEC sp_rename 'car_sales.Horsepower', 'horsepower';
EXEC sp_rename 'car_sales.Wheelbase', 'wheelbase';
EXEC sp_rename 'car_sales.Width', 'width';
EXEC sp_rename 'car_sales.Length', 'length';
EXEC sp_rename 'car_sales.Curb_weight', 'curb_weight';
EXEC sp_rename 'car_sales.Fuel_capacity', 'fuel_capacity';
EXEC sp_rename 'car_sales.Fuel_efficiency', 'fuel_efficiency';
EXEC sp_rename 'car_sales.Latest_Launch', 'latest_launch';
EXEC sp_rename 'car_sales.Power_perf_factor', 'power_perf_factor';