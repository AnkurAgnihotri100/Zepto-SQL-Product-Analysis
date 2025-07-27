# Zepto-SQL-Product-Analysis


This project involves analyzing a dataset of Zepto products using SQL. The dataset was imported from a CSV file into a structured SQL database. The main goal was to practice writing SQL queries to explore product details like pricing, discounts, stock status, and category-wise summaries.

## Dataset Details

The dataset includes the following fields:
- `sku_id`
- `category`
- `name`
- `mrp`
- `discountPercent`
- `availableQuantity`
- `discountedSellingPrice`
- `weightInGms`
- `outOfStock`
- `quantity`

## What I Did

- Created a SQL table and imported the CSV data
- Cleaned the data (e.g., removed invalid entries, converted prices from paise to rupees)
- Wrote multiple SQL queries to:
  - Check available vs out-of-stock items
  - Find products with highest discounts
  - Calculate estimated revenue by category
  - Group products by weight

## Files

- `zepto_dataset.csv` – Raw product data
- `zepto_analysis.sql` – All SQL queries used for analysis

