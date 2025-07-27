-- zepto_analysis.sql

-- Create table 
CREATE TABLE zepto (
  sku_id INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(120),
  name VARCHAR(150) NOT NULL,
  mrp DECIMAL(8,2),
  discountPercent DECIMAL(5,2),
  availableQuantity INT,
  discountedSellingPrice DECIMAL(8,2),
  weightInGms INT,
  outOfStock BOOLEAN,	
  quantity INT
);

-- Data Exploration

-- 1. Count of rows
SELECT COUNT(*) FROM zepto;

-- 2. Sample data
SELECT * FROM zepto
LIMIT 10;

-- 3. Null value check
SELECT * FROM zepto
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR availableQuantity IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;

-- 4. Distinct product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

-- 5. In-stock vs out-of-stock products
SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

-- 6. Product names that appear multiple times (multiple SKUs)
SELECT name, COUNT(sku_id) AS Number_of_SKUs
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY Number_of_SKUs DESC;

-- Data Cleaning

-- 7. Products with zero price
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- 8. Delete products with MRP = 0
DELETE FROM zepto
WHERE mrp = 0;

-- 9. Convert paise to rupees
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

-- 10. Check price updates
SELECT mrp, discountedSellingPrice FROM zepto;

-- Data Analysis

-- Q1. Top 10 best-value products by discount
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2. High MRP products that are out of stock
SELECT DISTINCT name, mrp
FROM zepto
WHERE outOfStock = TRUE AND mrp > 300
ORDER BY mrp DESC;

-- Q3. Estimated revenue per category
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;

-- Q4. Expensive products with low discount
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Top 5 categories with highest average discount
SELECT category,
       ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Price per gram (products >= 100g)
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;

-- Q7. Categorize products by weight
SELECT DISTINCT name, weightInGms,
  CASE 
    WHEN weightInGms < 1000 THEN 'Low'
    WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
  END AS weight_category
FROM zepto;

-- Q8. Total inventory weight per category
SELECT category,
       SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight DESC;

-- Q9. Top 10 products by total quantity sold
SELECT name, SUM(availableQuantity) AS total_sold
FROM zepto
GROUP BY name
ORDER BY total_sold DESC
LIMIT 10;

-- Q10. Average selling price per category
SELECT category, ROUND(AVG(discountedSellingPrice), 2) AS avg_selling_price
FROM zepto
GROUP BY category
ORDER BY avg_selling_price DESC;

-- Q11. Top 10 products by stock value
SELECT name, (discountedSellingPrice * availableQuantity) AS stock_value
FROM zepto
ORDER BY stock_value DESC
LIMIT 10;

-- Q12. Out of stock products count per category
SELECT category, COUNT(*) AS out_of_stock_count
FROM zepto
WHERE outOfStock = TRUE
GROUP BY category
ORDER BY out_of_stock_count DESC;

-- Q13. Top 10 heaviest products
SELECT name, weightInGms
FROM zepto
ORDER BY weightInGms DESC
LIMIT 10;
