NOVACART — BUSINESS INSIGHTS
Final copy based on the SQL results and screenshots supplied on 21 October 2026

PROJECT SUMMARY
NovaCart is a retail sales analysis project using Excel, MySQL and Power BI. The analysis reviews completed sales, product/category performance, monthly movement, customer value and data quality. The figures below reflect the SQL result screenshots provided. The Power BI revenue discrepancy remains unresolved and is explicitly disclosed.

KEY METRICS
- Completed revenue (SQL): ₦151,581,150
- Completed orders in status table: 975
- Completed orders represented in the product join: 974
- Units sold in the completed-item join: 5,721
- Joined order-item rows: 1,910
- Total orders in the orders table: 1,159
- Order outcomes: 975 completed, 113 cancelled, 71 returned

INSIGHT 1 — HOME GENERATES THE MOST REVENUE
Home generated ₦64,414,450 from 1,474 units, the highest category revenue in the supplied results. Electronics generated ₦50,497,500 from 1,888 units. Home therefore generated more revenue with fewer units, indicating a higher revenue value per unit in this dataset. Fashion contributed ₦23,715,700, Accessories ₦11,054,800, and Stationery ₦1,898,700.

Business implication:
Prioritise a closer review of the Home category and its leading products. Compare margins, stock availability, returns and demand before making inventory or promotional decisions. Revenue is not the same as profit.

INSIGHT 2 — OCTOBER REVENUE ROSE SHARPLY
Completed revenue increased from ₦9,357,925 in September 2025 to ₦16,033,775 in October 2025, a month-on-month increase of 71.34%. Completed orders rose from 66 to 101, and units sold increased from 374 to 606 over the same period.

Business implication:
Investigate what drove October’s rise by checking product mix, order volume, units sold and revenue per unit. The available results show the increase, but do not by themselves establish its cause.

INSIGHT 3 — PRODUCT PERFORMANCE SHOULD BE READ BY REVENUE AND VOLUME
The leading product by completed revenue in the supplied result is Office Chair (P015) at ₦18,675,000 from 265 units. Air Fryer (P012) generated ₦16,878,000 from 308 units, while Coffee Maker (P011) generated ₦14,428,800 from 319 units. These results show that the highest-volume product is not necessarily the highest-revenue product.

Business implication:
Review products using both revenue and units sold. Add validated cost and margin data before making profitability claims.

INSIGHT 4 — CUSTOMER VALUE IS UNEVENLY DISTRIBUTED
The top-customer query lists customer C1071 (shown as Samuel James 71) with 5 completed orders, 84 units purchased and ₦2,490,800 completed revenue. Other customers in the top ten show different combinations of order frequency, units and revenue per order.

Business implication:
Use customer revenue alongside order frequency and units purchased to understand customer value. However, validate duplicate customer records first: customer ID C1071 appears twice in the customer table, so customer-level findings may be affected.

INSIGHT 5 — ORDER OUTCOMES NEED MONITORING
The status result contains 975 completed orders, 113 cancelled orders and 71 returned orders, for 1,159 orders overall. These correspond to approximately 84.1% completed, 9.8% cancelled and 6.1% returned.

Business implication:
Track cancellation and return rates over time and segment them by product, payment method and location to find where operational follow-up may be needed. These overall counts do not identify the causes of cancellations or returns.

INSIGHT 6 — LOCATION RESULTS CAN GUIDE FURTHER INVESTIGATION
Awka is the highest-revenue city in the supplied city result, with ₦13,149,800 from 81 completed orders. Port Harcourt follows with ₦12,193,325 from 67 completed orders, while Benin City shows ₦11,527,600 from 81 completed orders.

Business implication:
Compare revenue, order count and customer count together when reviewing city performance. Do not assume the highest-revenue city is the most profitable without cost and margin data.

DATA QUALITY AND REPORTING LIMITATIONS
- Duplicate customer ID: C1071 appears twice.
- Unmatched product reference: order O20076 includes product P999, which is absent from the products table; the item quantity is 5.
- Two invalid-quantity rows were detected.
- One negative shipping fee was detected; no missing shipping fees were detected in the check shown.
- The status table contains 975 completed orders, but only 974 distinct completed orders appear in the join to order_items and products.
- SQL completed revenue is ₦151,581,150, while the Power BI card previously showed approximately ₦155.81 million. This difference has not been reconciled. Treat SQL as the current reference figure for this page and label the discrepancy as a validation limitation until the Power BI measure, filters, relationships and source data are checked.
- Do not describe revenue as profit: cost and margin data have not been validated.
- The unmatched P999 item means its revenue cannot be calculated from the current products table without confirming the correct product and price.

RECOMMENDED MANAGEMENT PRIORITIES
1. Reconcile the SQL and Power BI revenue measures and document the chosen definition.
2. Resolve or document product P999 without inventing a product or price.
3. Correct the two invalid quantities and investigate the negative shipping fee using source records.
4. Review the duplicate C1071 customer record before relying on customer-level reporting.
5. Monitor the October 2025 increase and identify the products or order patterns behind it.
6. Compare category and product revenue with validated costs, margins, returns and stock data before making profitability or inventory recommendations.

SHORT CONCLUSION
NovaCart’s supplied SQL results show Home as the leading revenue category and a strong rise in completed revenue in October 2025. Product revenue and volume do not always rank the same way, while customer and order-outcome analysis offers opportunities for deeper investigation. Before using the dashboard for final business decisions, the unmatched product, invalid quantities, negative shipping fee, duplicate customer ID and SQL–Power BI revenue discrepancy should be documented and resolved where possible.

SUGGESTED FOOTNOTE FOR THE POWER BI PAGE
Source: NovaCart project database, SQL validation queries. Revenue and operational findings are based on the current extract. SQL–Power BI revenue reconciliation and flagged data-quality issues remain under review. Revenue is not profit.
