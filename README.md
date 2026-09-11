# Cafe Sales Analysis

## Project Overview

This project analyzes cafe transaction data to understand sales performance, product performance, transaction patterns, and other business trends.

The project follows an end-to-end data analytics workflow, including data inspection, cleaning, missing-value recovery, validation, exploratory data analysis, visualization, and SQL analysis.

## Objectives

* Clean and prepare the cafe sales dataset.
* Handle missing and inconsistent values.
* Analyze product-level sales performance.
* Identify monthly and day-of-week sales patterns.
* Analyze payment method and location performance.
* Study transaction value and quantity patterns.
* Prepare the cleaned dataset for MySQL analysis.
* Generate business insights from the data.

## Dataset

The dataset contains **10,000 cafe transactions** with the following columns:

* Transaction ID
* Item
* Quantity
* Price Per Unit
* Total Spent
* Payment Method
* Location
* Transaction Date

The original dataset contained missing values and inconsistent entries such as `UNKNOWN` and `ERROR`, requiring data cleaning before analysis.

## Data Cleaning

The dataset was cleaned using Python, Pandas, and NumPy.

The cleaning process included:

* Replacing `UNKNOWN` and `ERROR` values with missing values.
* Converting numerical columns to appropriate numeric data types.
* Converting transaction dates to datetime format.
* Recovering missing price values using available item-level prices.
* Recovering remaining price values using total spent and quantity where possible.
* Recovering missing quantities using total spent and price where possible.
* Recovering missing total values using quantity and price where possible.
* Checking for duplicate transaction IDs.
* Validating calculated transaction totals.

Some values could not be reliably recovered because the required information was unavailable, so those values were retained as missing rather than being artificially filled.

## Exploratory Data Analysis

The analysis covered:

### Overall Sales

* Total revenue
* Average transaction value
* Average quantity per transaction
* Average price per unit
* Minimum and maximum transaction values

### Product Performance

* Revenue by item
* Quantity sold by item
* Average transaction value by item

### Monthly Analysis

* Monthly revenue
* Monthly transaction count
* Average transaction value by month

### Payment Method

* Transaction count by payment method
* Revenue by payment method
* Average transaction value by payment method

Payment-method analysis was performed using the available recorded payment information because a substantial portion of the dataset has missing payment-method values.

### Location Analysis

* Transaction count by location
* Revenue by location
* Average transaction value by location

Location analysis was also limited to recorded location values because many location values were missing.

### Transaction Value Analysis

Transactions were grouped into value ranges to understand the distribution of transaction sizes.

### Correlation Analysis

The relationship between:

* Quantity and Total Spent
* Price Per Unit and Total Spent
* Quantity and Price Per Unit

was examined using correlation analysis.

### Day-of-Week Analysis

Sales performance was analyzed by day of the week to identify differences in:

* Revenue
* Transaction count
* Average transaction value

## Visualizations

The project includes visualizations for:

* Revenue by Item
* Quantity Sold by Item
* Monthly Revenue
* Monthly Transaction Count
* Revenue by Payment Method
* Revenue by Location
* Distribution of Transaction Value
* Revenue by Day of Week

## Key Insights

* Salad generated the highest total revenue among the items.
* Coffee had the highest quantity sold.
* The product with the highest sales volume was not necessarily the product with the highest revenue.
* June recorded the highest monthly revenue.
* February recorded the lowest monthly revenue.
* October recorded the highest number of transactions.
* Credit Card had the highest recorded revenue among the available payment-method records.
* In-store transactions generated slightly higher recorded revenue than takeaway transactions.
* Most transactions were concentrated in the lower transaction-value ranges.
* The average transaction value was approximately 8.93.
* Quantity and Total Spent showed a positive relationship.
* Thursday recorded the highest revenue among the days of the week.
* Wednesday recorded the lowest revenue among the days of the week.

## SQL Analysis

The cleaned dataset was prepared for MySQL analysis.

The SQL workflow included:

* Creating a MySQL database.
* Creating a staging table for CSV import.
* Importing the cleaned data through MySQL Workbench.
* Transferring the data from the staging table into the final table.
* Validating the imported data.
* Analyzing overall sales metrics.
* Analyzing item performance.
* Analyzing monthly sales.
* Analyzing payment methods and locations.
* Identifying high-value transactions.
* Analyzing quantity and transaction value.
* Analyzing day-of-week performance.
* Finding the most popular item by day.
* Identifying the top revenue-generating days.

## Tools & Technologies

* Python
* Pandas
* NumPy
* Matplotlib
* MySQL
* Jupyter Notebook

## Project Structure

```text
cafe-sales-analysis/
│
├── data/
│   └── cafe_sales_cleaned.csv
│
├── notebooks/
│   └── cafe_sales_analysis.ipynb
│
├── sql/
│   └── cafe_sales_analysis.sql
│
├── README.md
├── requirements.txt
└── .gitignore
```

## Conclusion

This project demonstrates an end-to-end data analytics workflow using Python and SQL. It covers data cleaning, missing-value handling, validation, exploratory analysis, visualization, SQL data preparation, and business insight generation.

The project provided practical experience in transforming a messy transactional dataset into a cleaner and more structured dataset suitable for analysis using both Python and MySQL.
