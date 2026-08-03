# Adidas Sales Performance Analysis (2020 vs. 2021)

A SQL-based comparative sales analysis of Adidas product performance across 2020 and 2021, examining revenue trends across products, retailers, regions, and sales methods to inform 2022 sales, inventory, and channel-investment planning.

**Prepared by:** Beatrice Wambui · July 2026 · Internal Use Only

---

## 📊 Overview

Adidas generated **$899.9M** in combined revenue across 2020–2021, with total revenue growing **294.3% year-over-year**  from $182.1M in 2020 to $717.8M in 2021. This project uses MySQL to dissect that growth across six dimensions and identify which specific drivers mattered most, while also surfacing data-quality flags and open questions worth resolving before 2022 budget decisions.

## 🎯 Business Objective

This report analyzes Adidas product sales performance across 2020 and 2021 to identify year-over-year revenue trends and their key drivers. It compares the two years across six dimensions  monthly and daily revenue patterns, top-performing products, retailer performance, geographic performance (city, region, state), and sales method  to determine which drivers of the 2020-to-2021 change were most significant.

**Questions answered:**

- How did total revenue compare between 2020 and 2021?
- Which month in each year recorded peak revenue?
- Which day recorded peak revenue across the two-year period?
- Which product generated the highest revenue in each year?
- Which retailer generated the highest revenue in each year?
- Which city, region, and state generated the highest revenue in each year?
- Which sales method generated the highest revenue between the two years?

## 🧮 Methodology

- **Source:** A single sales transactions table covering January 2020 – December 2021 (order date, product, retailer, city/region/state, sales method, units sold, and total sales revenue).
- **Aggregation:** Revenue rolled up by month, day, product, retailer, and geography to identify each dimension's top performer per year.
- **YoY calculation:** `((2021 revenue − 2020 revenue) / 2020 revenue) × 100`
- **Peak periods:** Identified by ranking aggregated revenue in descending order within each year.
- **Tooling:** All queries written and executed in **MySQL**.
- **Scope:** No records were excluded. The dataset does not track returns/refunds separately.

## 📐 Key Performance Indicators

| KPI | Formula |
|---|---|
| YoY Revenue Growth Rate | `((2021 revenue − 2020 revenue) / 2020 revenue) × 100` |
| Peak Month Revenue (per year) | `MAX(monthly revenue)`, ranked |
| Peak Day Revenue | `MAX(daily revenue)`, ranked |
| Top Product Revenue Share | Top product revenue / total revenue × 100, per year |
| Top Retailer Revenue Share | Top retailer revenue / total revenue × 100, per year |
| Top Region Revenue Share | Top city/region/state revenue / total revenue × 100, per year |
| Sales Method Revenue Comparison | Revenue by method (in-store/online/outlet), % of total |

## 🗂️ Data Dictionary

| Column | Type | Description |
|---|---|---|
| `Retailer` | VARCHAR | Retail partner selling the product (e.g., Foot Locker, Walmart) |
| `Retailer_Id` | VARCHAR | Unique identifier for the retailer |
| `Invoice_Date` | DATE | Date of the transaction |
| `Region` | VARCHAR | Sales region |
| `State` | VARCHAR | Sales state |
| `City` | VARCHAR | Sales city |
| `Product` | VARCHAR | Product name / line sold |
| `Price_Per_Unit` | FLOAT | Unit price |
| `Units_Sold` | INT | Quantity sold |
| `Total_Sales` | FLOAT | Revenue for the transaction |
| `Operating_Profit` | FLOAT | Profit for the transaction |
| `Operating_Margin` | PERCENTAGE | Profit margin |
| `Sales_Method` | VARCHAR | In-store, online, or outlet |
| `Year_Num` | INT | Year of transaction |
| `Month_Num` / `Month_Name` | INT / VARCHAR | Month of transaction |
| `Day_Num` / `Day_Name` | INT / VARCHAR | Day of transaction (verify: calendar day vs. day-of-week) |

**Dataset footprint:** 9,648 orders · 2,478,861 units sold · 6 products · 6 retailers · 5 regions · 50 states · 52 cities · 3 sales methods · $332.1M operating profit (~36.9% margin) · $93,258 average order value.

## 🔍 Key Insights

- **Revenue grew 294.3% YoY** ($182.1M → $717.8M) — broad-based across retailers, regions, and products, not concentrated in one area.
- **Data quality confirmed:** both years have full 12-month coverage (359 and 365 distinct transaction days), so the growth reflects genuine performance, not incomplete records.
- **Peak timing shifted** between years: peak month moved from April (2020) to July (2021); peak day moved from Friday (2020) to Thursday (2021) — with only two years of data, not yet confirmed as a stable seasonal pattern.
- **Men's Street Footwear** was the #1 revenue product in both years (20.77% → 23.82% share), growing 352.1% YoY — faster than the company average — driven primarily by volume (units sold up 398.2%).
- **Women's Athletic Footwear** was the lowest-revenue product both years, likely due to a pricing gap rather than weak demand (it was not the lowest by units sold).
- **Retailer landscape shifted significantly:** West Gear fell from 49.59% share (2020) to 21.27% (2021) despite growing 69.1% in absolute terms — simply outgrown by faster-scaling partners. Foot Locker rose to #1. Kohl's surged from 0.42% to 14.12% share (+13,262.7%). Amazon entered as a new retailer, contributing 10.82% of 2021 revenue.
- **Regional convergence:** West remained #1 both years but its share fell from 42.23% to 26.89% (slowest growth, +151.1%). Midwest grew **+1,640.6%**, the largest swing in the dataset — confirmed to be driven by three new retailers entering the region.
- **Sales-method mix flipped:** in 2020, in-store drove the majority of revenue despite the fewest transactions; by 2021, online's transaction volume and average transaction value both grew sharply (average transaction value +554%), though this still needs validation against online's 2020 launch date.
- **A secondary "value dilution" pattern** emerged: West Gear and the West region both show declining revenue-per-unit even as absolute revenue grows, suggesting a possible shift toward volume- or discount-driven growth in parts of the business.

## 💡 Recommendations

1. **Replicate the Midwest retailer-expansion model**  new retailer onboarding drove 51.1% of that region's 2021 revenue; apply the same playbook to South and Southeast, which grew more moderately without this dynamic.
2. **Investigate before acting** on four open questions:
   - Confirm online's 2020 launch date to rule out a partial-year artifact in its transaction-value growth.
   - Determine whether West Gear's pricing decline explains the West region's pricing decline (cross-tab `Sales_Method`, `Price_Per_Unit`, `Retailer` filtered to West Gear × West).
   - Confirm whether Women's Athletic Footwear's underperformance is a pricing gap vs. other products.
   - Test whether sales-method mix, retailer expansion, and regional expansion are one connected story (three-way breakdown of `Sales_Method` × `Retailer` × `Region`).
3. **Protect Men's Street Footwear**  it remains the single largest revenue driver and should be safeguarded in inventory and channel planning.
4. **Monitor without immediate action:** West region's slower growth (market maturity, not underperformance), Walmart's below-average growth (+26.7%, one year isn't yet a trend), and peak-timing shifts (re-evaluate once a third year of data is available).

## 🏁 Conclusion

2021's growth was a genuine, structural expansion  evidenced by consistent outsized growth across products, retailers, and regions rather than concentration in a single area  driven by retailer-network expansion, regional diversification, and continued strength in the top product line. A secondary pattern of value dilution in West Gear/West region and an unvalidated online growth trend should be resolved before finalizing 2022 budget and retailer decisions.

## 🛠️ Tech Stack

- **SQL (MySQL)** — all aggregation, ranking, and YoY calculations via CTEs and window functions (`RANK() OVER (PARTITION BY ...)`)
- **PowerPoint** — report and findings presentation

## 📁 Repository Structure

```
.
├── adidas_sales_report.pptx   # Full report: executive summary, methodology, findings, SQL, recommendations
├── queries/                    # (suggested) individual .sql files extracted from the report's appendix
└── README.md
```

## 📄 Report Contents

The full presentation (`adidas_sales_report.pptx`) includes:

1. Executive Summary
2. Business Objective
3. Methodology
4. Key Performance Indicators
5. Dataset Overview & Data Dictionary
6. SQL Analysis & Findings (revenue overview, YoY growth, peak month/day, top product/retailer/region, sales method comparison)
7. Key Insights
8. Business Interpretation
9. Recommendations
10. Conclusion
11. Appendix (full SQL query reference)

---

*This is an internal analytics report. Data reflects Adidas transaction records for the period January 2020 – December 2021.*
