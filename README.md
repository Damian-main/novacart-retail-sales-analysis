# NovaCart Retail Sales Analysis

**Tools:** MySQL, Excel, Power BI  
**Project type:** Portfolio case study  
**Focus:** Sales performance, product/category analysis, customer value, order outcomes, and data quality.

## Project overview

NovaCart is a retail analytics case study that combines SQL-based analysis with a Power BI report. The goal is to turn transaction data into useful business observations while documenting data-quality limitations that can affect reporting accuracy.

## Repository structure

- `sql/novacart_analysis.sql` — SQL queries used for exploration, cleaning checks, and sales analysis.
- `dashboard/NovaCart_Sales_Analysis.pbix` — Power BI report file.
- `evidence/sales_overview_dashboard.png` — screenshot of the Sales Overview page.
- `documentation/business_insights.md` — business findings, recommendations, and limitations.

## Questions explored

- Which product categories contribute the most completed revenue?
- How do monthly sales and order volumes change over time?
- Which products perform well by revenue versus units sold?
- How do order outcomes break down across completed, cancelled, and returned orders?
- What data-quality issues should be investigated before decisions are made?

## Selected findings from the current SQL results

- Completed revenue calculated in SQL: **₦151,581,150**.
- The order status count showed **975 completed orders**, while **974 distinct completed orders** appeared in the join to order items and products.
- Home was the highest-revenue category in the supplied result set.
- Completed revenue increased from approximately **₦9.36 million in September 2025** to **₦16.03 million in October 2025** in the supplied monthly results.

These findings are based on the current project extract and should be rechecked if the underlying data or definitions change.

## Data quality and limitations

The analysis identified issues that require review, including a duplicate customer ID (`C1071`), an order item referencing product `P999` that is absent from the products table, two invalid quantity rows, and a negative shipping fee.

The SQL completed-revenue result (**₦151.58 million**) differs from the Power BI card previously observed (approximately **₦155.81 million**). This discrepancy has **not** been reconciled. Do not treat either figure as a final reconciled business metric until the source, filters, relationships, and measure definitions have been checked.

Revenue is not profit. Cost and margin data have not been validated.

## How to view the project

1. Open `dashboard/NovaCart_Sales_Analysis.pbix` in Power BI Desktop.
2. Open `sql/novacart_analysis.sql` in MySQL Workbench and select the `novacart` database before running queries.
3. Review the findings and limitations in `documentation/business_insights.md`.

## Privacy note

Raw customer/order spreadsheets are intentionally not included in this public repository. Share only data that is safe to publish and remove any private or personally identifiable information before adding further files.
