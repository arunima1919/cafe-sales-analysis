# Cafe Sales Analysis

## Project Overview

This project analyzes cafe transaction data to understand sales performance, product performance, transaction patterns, and business trends.

The project follows an end-to-end data analytics workflow, including data cleaning, validation, exploratory data analysis, SQL analysis, and Excel-based business reporting.

## Objectives

- Clean and prepare the cafe sales dataset.
- Handle missing and inconsistent values.
- Analyze product-level sales performance.
- Identify monthly and day-of-week sales patterns.
- Analyze payment method and location performance.
- Study transaction value and quantity patterns.
- Perform SQL-based analysis using MySQL.
- Build an Excel dashboard to summarize key performance indicators and business insights.

## Dataset

The dataset contains **10,000 cafe transactions** with the following columns:

- Transaction ID
- Item
- Quantity
- Price Per Unit
- Total Spent
- Payment Method
- Location
- Transaction Date

The original dataset contained missing values and inconsistent entries such as `UNKNOWN` and `ERROR`, requiring data cleaning before analysis.

## Data Cleaning

The dataset was cleaned using Python, Pandas, and NumPy.

The cleaning process included:

- Replacing `UNKNOWN` and `ERROR` values with missing values.
- Converting numerical columns to appropriate numeric data types.
- Converting transaction dates to datetime format.
- Recovering missing price values using available item-level prices.
- Recovering remaining price values using total spent and quantity where possible.
- Recovering missing quantities using total spent and price where possible.
- Recovering missing total values using quantity and price where possible.
- Checking for duplicate transaction IDs.
- Validating calculated transaction totals.

Values that could not be reliably recovered were retained as missing rather than being artificially filled.

## Exploratory Data Analysis

Exploratory data analysis was performed using Python, Pandas, NumPy, and Matplotlib.

### Overall Sales

- Total revenue
- Average transaction value
- Average quantity per transaction
- Average price per unit
- Minimum and maximum transaction values

### Product Performance

- Revenue by item
- Quantity sold by item
- Average transaction value by item

### Monthly Analysis

- Monthly revenue
- Monthly transaction count
- Average transaction value by month

### Payment Method Analysis

- Transaction count by payment method
- Revenue by payment method
- Average transaction value by payment method

Payment-method analysis was limited to available recorded payment information because many payment-method values were missing.

### Location Analysis

- Transaction count by location
- Revenue by location
- Average transaction value by location

Location analysis was limited to recorded location values because many location values were missing.

### Transaction Value Analysis

Transactions were grouped into value ranges to understand the distribution of transaction sizes.

### Correlation Analysis

The relationships between the following variables were examined:

- Quantity and Total Spent
- Price Per Unit and Total Spent
- Quantity and Price Per Unit

### Day-of-Week Analysis

Sales performance was analyzed by day of the week using:

- Revenue
- Transaction count
- Average transaction value

## Visualizations

Python visualizations include:

- Revenue by Item
- Quantity Sold by Item
- Monthly Revenue
- Monthly Transaction Count
- Revenue by Payment Method
- Revenue by Location
- Distribution of Transaction Value
- Revenue by Day of Week

## SQL Analysis

The cleaned dataset was prepared for MySQL analysis.

The SQL workflow included:

- Creating a MySQL database.
- Creating a staging table for CSV import.
- Importing the cleaned data through MySQL Workbench.
- Transferring data from the staging table into the final table.
- Validating the imported data.
- Analyzing overall sales metrics.
- Analyzing item performance.
- Analyzing monthly sales.
- Analyzing payment methods and locations.
- Identifying high-value transactions.
- Analyzing quantity and transaction value.
- Analyzing day-of-week performance.
- Finding the most popular item by day.
- Identifying top revenue-generating days.

## Excel Analysis and Dashboard

Excel was used as a business-analysis and reporting layer for the project.

The workbook, `Cafe_Sales_Excel_Analysis.xlsx`, contains four worksheets:

- **Data:** The cleaned cafe sales dataset.
- **Analysis:** KPI calculations and item-level analysis using Excel formulas.
- **Pivot Tables:** Revenue summaries by item, payment method, and location.
- **Dashboard:** Key performance indicators, PivotCharts, and business insights.

### Excel Features Used

- **Formulas:** `SUM`, `AVERAGE`, `MAX`, `MIN`, `COUNTA`, `UNIQUE`, `SUMIF`, `COUNTIF`, `AVERAGEIF`, and `FILTER`.
- **PivotTables:** Summarized revenue by item, payment method, and location.
- **PivotCharts:** Visualized revenue comparisons across these categories.
- **Dashboard:** Presented key metrics and findings in a consolidated view.

### Dashboard KPIs

- Total revenue: ₹89,096
- Total quantity sold: 30,180
- Number of transactions: 10,000
- Average transaction value: ₹8.93

### Excel Business Insights

- Salad generated the highest revenue among the recorded item categories.
- Credit Card had the highest recorded revenue among the available payment methods.
- In-store sales generated slightly higher recorded revenue than takeaway sales.
- Juice had the highest transaction count among the recorded item categories.

Blank categories were excluded from the corresponding PivotTable summaries. Therefore, the category-level revenue totals differ from overall revenue because some transactions have missing item, payment method, or location values.

## Key Insights

- Salad generated the highest total revenue among the items.
- Coffee had the highest quantity sold.
- The item with the highest sales volume was not necessarily the item with the highest revenue.
- June recorded the highest monthly revenue.
- February recorded the lowest monthly revenue.
- October recorded the highest number of transactions.
- Credit Card had the highest recorded revenue among the available payment-method records.
- In-store transactions generated slightly higher recorded revenue than takeaway transactions.
- Most transactions were concentrated in the lower transaction-value ranges.
- The average transaction value was approximately ₹8.93.
- Quantity and Total Spent showed a positive relationship.
- Thursday recorded the highest revenue among the days of the week.
- Wednesday recorded the lowest revenue among the days of the week.

## Tools & Technologies

- Python
- Pandas
- NumPy
- Matplotlib
- MySQL
- MySQL Workbench
- Microsoft Excel
- Jupyter Notebook
- Git and GitHub

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
├── excel/
│   └── Cafe_Sales_Excel_Analysis.xlsx
│
├── README.md
├── requirements.txt
└── .gitignore
```

## Conclusion

This project demonstrates an end-to-end data analytics workflow using Python, SQL, and Excel. It covers data cleaning, missing-value handling, validation, exploratory data analysis, visualization, SQL-based analysis, and Excel reporting.

The project provided practical experience in transforming a messy transactional dataset into a structured dataset suitable for analysis, then presenting business metrics and insights through an Excel dashboard.
