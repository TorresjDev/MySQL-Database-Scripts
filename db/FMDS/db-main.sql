-- -------------------------------------------------------
-- ? FMDS - Database
CREATE DATABASE FMDS;
USE FMDS;


SELECT * FROM User ORDER BY User_ID DESC;

SELECT * FROM Business_User ORDER BY Business_ID DESC;

SELECT * FROM Financial_Account ORDER BY Account_ID DESC;

SELECT * FROM Bank_Account ORDER BY Account_ID DESC;

SELECT * FROM Loan_Account ORDER BY Account_ID DESC;

SELECT * FROM Credit_Account ORDER BY Account_ID DESC;

SELECT * FROM Investment_Account ORDER BY Account_ID DESC;

SELECT * FROM Digital_Asset_Account ORDER BY Account_ID DESC;

SELECT * FROM Credit_Report ORDER BY Credit_Report_ID DESC;

SELECT * FROM Investment_Holding ORDER BY Holdings_ID DESC;

SELECT * FROM Investment_Asset ORDER BY Action_ID DESC;

SELECT * FROM Transaction ORDER BY Transaction_ID DESC;

SELECT * FROM Tax_Report ORDER BY Tax_Report_ID DESC;

SELECT * FROM Taxable_Transaction ORDER BY Tx_ID DESC;


-- Your submission must include SQL queries and screen shots of the 
-- results of those queries tested with MySQL. The queries should 
-- include accessing a single table as well as joining multiple tables. 
-- Include at least 5 SELECT Queries, with at least 3 multiple table
-- joins. 
 
-- a) Your Select statements must not all be (select * from 
-- table_name format) 
-- b) The select statements must provide meaningful information to a 
-- potential user. 
-- c) At least 3 of your select statements must feature table joins. 
-- (Refer to additional SQL exercises and its solutions) 
-- d) Use the select statement with aggregate functions (Sum, Count, 
-- Avg etc.). Hint: Using aggregate functions may require the use 
-- of ‘Group By’ or ‘Having’ clauses.  

-- 5 SELECT Statements with Joins and Aggregate Functions
-- -- -- ---------------------------------------------------------

-- * Select All Financial Accounts by User (Grouped Summary)
SELECT 
    u.User_ID,
    u.Full_Name,
    COUNT(fa.Account_ID) AS Total_Accounts,
    GROUP_CONCAT(DISTINCT fa.Account_Type ORDER BY fa.Account_Type ASC SEPARATOR ', ') AS Account_Types,
    SUM(fa.Account_Balance) AS Total_Balance
FROM Financial_Account fa
JOIN User u ON fa.User_ID = u.User_ID
GROUP BY u.User_ID
ORDER BY u.Full_Name;


-- * All Transactions by Most Recent User Transaction by Total Amount Descending (Grouped Summary)
SELECT 
    u.User_ID,
    u.Full_Name,
    fa.Account_Type,
    fa.Account_Name,
    t.Transaction_Type,
    COUNT(t.Transaction_ID) AS Transaction_Count,
    SUM(t.Amount) AS Total_Amount,
    MAX(t.Transaction_Timestamp) AS Most_Recent_Transaction,
    t.Payment_Method
FROM Transaction t
JOIN Financial_Account fa ON t.Account_ID = fa.Account_ID
JOIN User u ON fa.User_ID = u.User_ID
GROUP BY u.User_ID, fa.Account_Type, fa.Account_Name, t.Transaction_Type, t.Payment_Method
ORDER BY u.Full_Name, Total_Amount DESC, Most_Recent_Transaction DESC;

-- -- * Investment Overview by User 
-- SELECT 
--     u.User_ID,
--     u.Full_Name,
--     COUNT(ih.Holdings_ID) AS Total_Holdings,
--     GROUP_CONCAT(DISTINCT ih.Investment_Type ORDER BY ih.Investment_Type ASC SEPARATOR ', ') AS Investment_Types,
--     ROUND(SUM(ih.Total_Quantity), 0) AS Total_Shares_Held,
--     SUM(ih.Holdings_Value) AS Total_Holdings_Value,
--     SUM(ih.Realized_Gain_Or_Loss) AS Realized_Gains,
--     SUM(ih.Unrealized_Gain_Or_Loss) AS Unrealized_Gains
-- FROM Investment_Holding ih
-- JOIN Investment_Account ia ON ih.Account_ID = ia.Account_ID
-- JOIN Financial_Account fa ON ia.Account_ID = fa.Account_ID
-- JOIN User u ON fa.User_ID = u.User_ID
-- GROUP BY u.User_ID
-- ORDER BY u.Full_Name;


-- * Investment Overview by Holding Type per user
SELECT 
    u.User_ID,
    u.Full_Name,
    ih.Investment_Symbol,
    ih.Investment_Type,
    COUNT(ih.Holdings_ID) AS Total_Holdings,
    ROUND(SUM(ih.Total_Quantity), 0) AS Total_Shares_Held,
    SUM(ih.Holdings_Value) AS Total_Holdings_Value,
    SUM(ih.Realized_Gain_Or_Loss) AS Realized_Gains,
    SUM(ih.Unrealized_Gain_Or_Loss) AS Unrealized_Gains
FROM Investment_Holding ih
JOIN Investment_Account ia ON ih.Account_ID = ia.Account_ID
JOIN Financial_Account fa ON ia.Account_ID = fa.Account_ID
JOIN User u ON fa.User_ID = u.User_ID
GROUP BY u.User_ID, ih.Investment_Symbol, ih.Investment_Type
ORDER BY u.Full_Name, ih.Investment_Type;

-- * Digital Asset Overview by Holding Type per user
SELECT 
   u.User_ID,
   u.Full_Name,
   dah.Digital_Asset_Type,
   dah.Digital_Asset_Symbol,
   COUNT(dah.Holding_ID) AS Total_Holdings,
   ROUND(SUM(dah.Total_Quantity), 0) AS Total_Shares_Held,
   SUM(dah.Holdings_Value) AS Total_Holdings_Value,
   SUM(dah.Realized_Gain_Or_Loss) AS Realized_Gains,
   SUM(dah.Unrealized_Gain_Or_Loss) AS Unrealized_Gains
FROM Digital_Asset_Holding dah
JOIN Digital_Asset_Account daa ON dah.Account_ID = daa.Account_ID
JOIN Financial_Account fa ON daa.Account_ID = fa.Account_ID
JOIN User u ON fa.User_ID = u.User_ID
GROUP BY u.User_ID, dah.Digital_Asset_Type, dah.Digital_Asset_Symbol
ORDER BY u.Full_Name, dah.Digital_Asset_Type;


-- * Tax Report Overview by User
SELECT 
    u.User_ID,
    u.Full_Name,
    u.SSN,
    u.Date_Of_Birth,
    u.State,
    tr.Tax_Year,
    tr.Filing_Status,
    tr.Spouse_Income,
    tr.Num_Dependents,
    SUM(tt.Taxable_Amount) AS Total_Taxable_Income,
    GROUP_CONCAT(DISTINCT tt.Tax_Category ORDER BY tt.Tax_Category ASC SEPARATOR ', ') AS Tax_Categories
FROM Tax_Report tr
JOIN User u ON tr.User_ID = u.User_ID
JOIN Taxable_Transaction tt ON tr.Tax_Report_ID = tt.Tax_Report_ID
GROUP BY u.User_ID, tr.Tax_Year, tr.Filing_Status, tr.Spouse_Income, tr.Num_Dependents
ORDER BY u.Full_Name, tr.Tax_Year;

-- * Credit Score Summary by Bureau
SELECT 
    u.User_ID,
    u.Full_Name,
    cr.Credit_Bureau_Name,
    cr.Credit_Score,
    CASE 
        WHEN cr.Credit_Score >= 740 THEN 'Excellent'
        WHEN cr.Credit_Score >= 670 THEN 'Good'
        WHEN cr.Credit_Score >= 580 THEN 'Fair'
        ELSE 'Poor'
    END AS Score_Grade,
    cr.Report_Date
FROM Credit_Report cr
JOIN User u ON cr.User_ID = u.User_ID
ORDER BY u.Full_Name, cr.Credit_Bureau_Name;


-- * Spending Breakdown by Payment Category
SELECT 
    u.User_ID,
    u.Full_Name,
    t.Payment_Category,
    COUNT(t.Transaction_ID) AS Transactions,
    SUM(t.Amount) AS Total_Spent
FROM Transaction t
JOIN Financial_Account fa ON t.Account_ID = fa.Account_ID
JOIN User u ON fa.User_ID = u.User_ID
WHERE t.Transaction_Type = 'Withdrawal' OR t.Transaction_Type = 'Payment'
GROUP BY u.User_ID, t.Payment_Category
ORDER BY u.Full_Name, Total_Spent DESC;

-- * Total Portfolio Value (Investments + Digital Assets)
SELECT 
    u.User_ID,
    u.Full_Name,
    COALESCE(SUM(DISTINCT ia.Total_Investment_Value), 0) AS Total_Investment_Value,
    COALESCE(SUM(DISTINCT daa.Total_Digital_Assets_Value), 0) AS Total_Digital_Value,
    COALESCE(SUM(DISTINCT ia.Total_Investment_Value), 0) + COALESCE(SUM(DISTINCT daa.Total_Digital_Assets_Value), 0) AS Total_Portfolio_Value
FROM User u
LEFT JOIN Financial_Account fa1 ON u.User_ID = fa1.User_ID AND fa1.Account_Type = 'Investment'
LEFT JOIN Investment_Account ia ON fa1.Account_ID = ia.Account_ID
LEFT JOIN Financial_Account fa2 ON u.User_ID = fa2.User_ID AND fa2.Account_Type = 'Digital Asset'
LEFT JOIN Digital_Asset_Account daa ON fa2.Account_ID = daa.Account_ID
GROUP BY u.User_ID
ORDER BY Total_Portfolio_Value DESC;






    

-- * User Portfolio Summary with Tax and Activity Info
SELECT 
    u.User_ID,
    u.Full_Name,
    COUNT(DISTINCT fa.Account_ID) AS Total_Accounts,
    COALESCE(SUM(DISTINCT ia.Total_Investment_Value), 0) + COALESCE(SUM(DISTINCT daa.Total_Digital_Assets_Value), 0) AS Total_Portfolio_Value,
    COALESCE(SUM(DISTINCT tt.Taxable_Amount), 0) AS Total_Taxable_Income,
    MAX(t.Transaction_Timestamp) AS Last_Transaction
FROM User u
LEFT JOIN Financial_Account fa ON u.User_ID = fa.User_ID
LEFT JOIN Investment_Account ia ON fa.Account_ID = ia.Account_ID
LEFT JOIN Digital_Asset_Account daa ON fa.Account_ID = daa.Account_ID
LEFT JOIN Transaction t ON fa.Account_ID = t.Account_ID
LEFT JOIN Tax_Report tr ON u.User_ID = tr.User_ID
LEFT JOIN Taxable_Transaction tt ON tr.Tax_Report_ID = tt.Tax_Report_ID
GROUP BY u.User_ID
ORDER BY u.Full_Name;

