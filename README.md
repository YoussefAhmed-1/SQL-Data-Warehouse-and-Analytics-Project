# SQL Data Warehouse & Analytics Project

## 📖 Project Overview

This project demonstrates the development of a modern SQL-based data warehouse and analytics solution, combining **Data Engineering** and **Data Analysis** in one end-to-end project.

The project covers the complete data pipeline, starting with raw data ingestion from ERP and CRM systems, followed by data transformation, data integration, and analytical SQL queries to generate meaningful business insights.

The solution follows the **Medallion Architecture (Bronze, Silver, and Gold)** to organize and manage data efficiently.

## 🚀Project Objectives

- Build a modern SQL data warehouse.
- Integrate data from multiple ERP and CRM source systems.
- Implement the Medallion Architecture.
- Clean, transform, and standardize raw data.
- Develop analytical SQL queries to explore business data.
- Generate customer and product insights.
- Support data-driven business decision-making.

## 🏗️ Data Architecture

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:

![Data Architecture](Docs/data_architecture.png)

1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

## Data Warehouse Design

The data warehouse is designed using a **Star Schema** to simplify analytical queries and improve reporting efficiency.

The Gold Layer includes:
- Fact tables containing measurable business events.
- Dimension tables providing descriptive context.
- Relationships that support customer, product, and sales analysis.

## Data Engineering

The Data Engineering part focuses on building and managing the data warehouse pipeline.

### Data Sources
- **CRM System:** Customer information and sales-related data.
- **ERP System:** Product, transaction, and other operational data.

### ETL Process
1. Extract data from CSV source files.
2. Load raw data into the Bronze Layer.
3. Transform and clean data in the Silver Layer.
4. Integrate and model data in the Gold Layer.
5. Validate data quality across the pipeline.

## Data Analysis

The Data Analysis part focuses on exploring the warehouse data and extracting actionable business insights using SQL.

### 1. Exploratory Data Analysis (EDA)
- Explore database tables and structures.
- Understand data distributions.
- Identify missing values and duplicates.
- Examine relationships between datasets.

### 2. Key Analytical Techniques

**Change Over Time Analysis**
- Analyze sales trends over time.
- Identify monthly and yearly patterns.

**Cumulative Analysis**
- Calculate running totals.
- Track cumulative business performance.

**Performance Analysis**
- Evaluate product and customer performance.
- Compare performance across different periods.

**Part-to-Whole Analysis**
- Calculate the contribution of products and categories to total sales.

**Data Segmentation**
- Segment customers based on purchasing behavior.
- Group products based on business characteristics.

**Ranking Analysis**
- Identify top-performing products and customers.
- Rank business entities using SQL window functions.

**Magnitude Analysis**
- Measure sales volumes and other available business metrics.
- Compare performance across categories and dimensions.

## 📂Repository Structure

The repository is organized into the following structure:

```text
SQL-Data-Warehouse-Project/
│
├── datasets/
│   ├── source_crm/
│   └── source_erp/
│
├── Docs/
│   ├── data_architecture.png
│   ├── data_catalog.md
│   ├── data_flow.png
│   ├── data_integration.png
│   ├── data_model.png
│   └── naming_conventions.md
│
├── scripts/
│   ├── bronze/
│   ├── silver/
│   ├── gold/
│   └── tests/
│
├── EDA-Scrpits/
│   ├──Exploratory data analysis(1-6)
│   └──Advanced analytics (7-13)
│
├── README.md
└── LICENSE
```

*Note: This structure is a suggested organization. Update folder and file names to match the actual repository contents.*

## Tools & Technologies

- **SQL Server:** Database management and SQL development.
- **SQL:** Data extraction, transformation, cleaning, and analysis.
- **Draw.io:** Data architecture and modeling diagrams.
- **Git & GitHub:** Version control and project documentation.


## Key Deliverables

- End-to-end SQL data warehouse.
- Medallion Architecture implementation.
- Integrated ERP and CRM datasets.
- Cleaned and transformed data.
- Dimensional data model.
- SQL data quality checks.
- Analytical SQL scripts.
- Business insights and reporting.

## Business Value

This project demonstrates how raw operational data can be transformed into structured, reliable, and meaningful information.

It provides a foundation for:
- Understanding customer purchasing behavior.
- Identifying top-performing products.
- Monitoring sales trends.
- Evaluating business performance.
- Supporting data-driven decisions.

##👤 Author

**Youssef Ahmed**

GitHub: [YoussefAhmed-1](https://github.com/YoussefAhmed-1)
