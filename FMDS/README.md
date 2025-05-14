# 📊 Financial Management Database System (FMDS)

A fully relational MySQL database project simulating a realistic financial management environment. This system models user profiles, business accounts, investment portfolios, digital assets, tax reporting, and credit histories. Designed for learning, testing, and demonstrating advanced SQL queries and data relationships.

## 📑 Table of Contents

- [📊 Financial Management Database System (FMDS)](#-financial-management-database-system-fmds)
  - [📑 Table of Contents](#-table-of-contents)
  - [⭐ Features \& Highlights](#-features--highlights)
  - [🛠️ Tech Stack \& Dependencies](#️-tech-stack--dependencies)
  - [💻 How to Use](#-how-to-use)
  - [🚀 Usage Guide](#-usage-guide)
  - [🗂️ Project Structure](#️-project-structure)
    - [Folder Breakdown:](#folder-breakdown)
  - [📝 License \& Credits](#-license--credits)

## ⭐ Features & Highlights

- Full relational database schema for users & businesses.
- Supports financial accounts: Bank, Loan, Credit, Investment, Digital Assets.
- Investment holdings & asset management with performance tracking.
- Digital Asset (Crypto, NFTs) accounts with transactional history.
- Tax reports linked to transactions & users.
- Credit reports history with bureau-level tracking.
- Advanced SQL SELECT statements for reporting & data analysis.
- Modular SQL files: schema, inserts, reports—easy to navigate.

## 🛠️ Tech Stack & Dependencies

- **Database:** MySQL 8.x
- **SQL Features:** Subqueries, Joins, Aggregate Functions, CASE, IFNULL, GROUP_CONCAT, DATE_FORMAT.
- **Tools:** MySQL Workbench / DBeaver / VSCode for SQL development.
- **Environment:** Local MySQL Server (or hosted DB service).

## 💻 How to Use

You don't need to install anything special to get started.

- Open the SQL files in your favorite editor (like VS Code, DBeaver, or MySQL Workbench).
- You can copy-paste the SQL scripts directly into your SQL console or editor.
- Or simply drag and drop the files into your SQL editor for execution.
- Files are modular: load tables from /entities/, insert sample data from /statements/insert*\*.sql, and run reports using /statements/select*\*.sql.

This flexible structure allows you to practice, test, and learn SQL in a way that works best for you.

## 🚀 Usage Guide

Once the schema and data are loaded:

- Run SELECT statements to retrieve user profiles, account details, investments, taxes, and credit reports.
- Modify or extend sample queries for custom reports.
- Use for practicing real-world SQL joins, reporting, and optimization.

Example command:

```bash
mysql -u root -p < statements/select_users_digital_asset_holdings.sql
```

## 🗂️ Project Structure

```
/entities/
└── (Supertypes, Subtypes, Associative, ect.)

/statements/
└── (Insert, Update, Delete, Select, etc.)

/README.md
```

### Folder Breakdown:

- **entities/** → All database table definitions.
- **statements/** → Data population scripts & complex SELECT queries.
<!-- * **README.md** → This documentation file. -->

## 📝 License & Credits

- **License:** MIT License — Open for educational & non-commercial use.
- **Author:** Jesus Torres ([@TorresjDev](https://github.com/TorresjDev))
- **Inspiration:** Modeled after real-world financial systems for hands-on SQL practice.
