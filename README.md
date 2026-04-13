Sales Data Analysis using SQL

Project Overview:
This project analyzes e-commerce sales data using SQL to extract actionable business insights related to revenue, customer behavior, product performance, and sales trends.

The goal is to simulate real-world data analysis tasks performed by a data analyst.

Database Schema:
The project uses a relational database with the following tables:

customers – customer details
orders – order-level information
order_items – products within each order
products – product details and pricing

Revenue Analysis:
- What is the total revenue generated?
- How much revenue does each product contribute?
- What percentage of total revenue comes from each product?

Customer Analysis:
- How many orders has each customer placed?
- Who are the top customers by spending?
- How can customers be segmented based on spending behavior?
- Which customers have never placed any orders?
- Which customers are repeat customers?

Product Analysis:
- What are the top 3 revenue-generating products?

Order Analysis:
- What is the total value of each order?
- What is the average order value (AOV)?
- Which orders are above average value?

Time-Based Analysis:
- How does revenue change month over month?
- What is the month-over-month growth rate?

Skills Demonstrated:
- SQL Joins (INNER JOIN, LEFT JOIN)
- Aggregations (SUM, COUNT, AVG)
- Subqueries and Common Table Expressions (CTEs)
- Window Functions (LAG, DENSE_RANK)
- CASE statements for customer segmentation
- Handling edge cases (NULL values, division by zero)

Key Insights:
- Identified top-performing products contributing the highest revenue
- Segmented customers into high-value and low-value groups based on spending
- Detected repeat customers and analyzed their behavior
- Measured average order value to understand purchasing patterns
- Analyzed monthly revenue trends and growth rate

Project Structure:
sales-sql-project/
│
├── schema.sql -- Database structure
├── data.sql -- Sample dataset
├── queries.sql -- SQL analysis queries
└── README.md -- Project documentation

Dashboard Preview

Overview
<img width="1141" height="642" alt="Overview" src="https://github.com/user-attachments/assets/1d541b42-1503-4677-90b3-c5b925c75cf4" />

Customer Analysis
![Customer](images/customer_analysis.png)

### Product Analysis
![Product](images/product_analysis.png)

### Time Analysis
![Time](images/time_analysis.png)
Conclusion:
This project demonstrates the ability to analyze structured data using SQL and derive meaningful business insights. It reflects practical data analysis skills required for entry-level data analyst roles.
