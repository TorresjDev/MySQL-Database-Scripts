-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? USERS
-- ---------------------------------------------------------
-- -- * User - Supertype

-- -------------------------------------------------------------
-- -- * Business_User - Subtype of User

-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- ? Insert Statements
-- -------------------------------------------------------------
-- -- * User Insert Statements

-- -------------------------------------------------------------
-- -- * Business User Insert Statements

-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- ? Select Statements
SELECT * FROM User;
SELECT * FROM Business_User;
SELECT * FROM User WHERE Has_Business = TRUE;
SELECT * FROM User WHERE SSN IS NOT NULL;
-- ------------------------------------------------------------
-- -- * Select All User info By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth,
      TIMESTAMPDIFF(YEAR, u.Date_Of_Birth, CURDATE()) AS Age, 
      CASE WHEN u.SSN IS NOT NULL THEN CONCAT('****-**-', RIGHT(u.SSN, 4)) ELSE 'NA' END AS SSN,
      u.Email, u.Phone_Number,
      CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address,
      CASE WHEN u.Has_Business = TRUE THEN 'Yes' ELSE 'No' END AS Has_Business,
      DATE_FORMAT(u.Created_At, '%m/%d/%Y') AS Member_Since
FROM User u ORDER BY u.User_ID DESC;
-- ------------------------------------------------------------
-- -- * Select Users with no SSN & no Business By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u WHERE u.SSN IS NULL AND u.Has_Business = FALSE ORDER BY u.User_ID DESC;
-- ------------------------------------------------------------
-- -- * Select Users with SSN & no Business By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u WHERE u.SSN IS NOT NULL AND u.Has_Business = FALSE ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select Users with business & no SSN By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address, u.SSN
FROM User u WHERE u.SSN IS NULL AND u.Has_Business = TRUE ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select Users with business & SSN By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u WHERE u.SSN IS NOT NULL AND u.Has_Business = TRUE ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select All User Data with SSN ONLY By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u WHERE u.SSN IS NOT NULL ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select All User Data with Business Data
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth,  u.Email, u.Phone_Number, CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address,
       bu.Business_ID, bu.EIN, bu.Business_Name, bu.Start_Of_Business, bu.Business_Phone, bu.Business_Email
FROM User u LEFT JOIN Business_User bu ON u.User_ID = bu.User_ID WHERE u.Has_Business = TRUE ORDER BY u.User_ID DESC;
-- ------------------------------------------------------------
-- -- * Select All User Data with No Business Data
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth,  u.Email, u.Phone_Number, CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u LEFT JOIN Business_User bu ON u.User_ID = bu.User_ID WHERE u.Has_Business = FALSE ORDER BY u.User_ID DESC;


SELECT 
    u.User_ID,
    u.Full_Name,
    b.Business_ID,
    b.Business_Name,
    CONCAT('**-***', RIGHT(b.EIN, 4)) AS EIN_Last_4,
    b.Business_Phone,
    b.Business_Email,
    b.Start_Of_Business as Business_Established,
    TIMESTAMPDIFF(YEAR, b.Start_Of_Business, CURDATE()) AS Business_Age,
    DATE_FORMAT(b.Created_At, '%M %d, %Y') AS Business_Registered_Since,
    (
        SELECT COUNT(*) 
        FROM Financial_Account fa 
        WHERE fa.User_ID = u.User_ID AND fa.Is_Business_Account = TRUE
    ) AS Number_Of_Fin_Accounts
FROM 
    User u
JOIN 
    Business_User b ON u.User_ID = b.User_ID
ORDER BY 
    u.Full_Name ASC;

select * from business_user   ;

SELECT 
    u.User_ID,
    u.Full_Name,
    u.Email,
    u.Phone_Number,
    CONCAT_WS(', ', u.City, u.State, u.Zip_Code) AS Location,
    fa.Account_ID,
    fa.Institution_Name,
    fa.Account_Type,
    fa.Account_Name,
    CONCAT('******', RIGHT(fa.Account_Number, 4)) AS Account_Ends_With,
    CONCAT('$', FORMAT(fa.Account_Balance, 2)) AS Account_Balance,
    DATE_FORMAT(fa.Date_Account_Opened, '%b %d, %Y') AS Opened_On,
    TIMESTAMPDIFF(MONTH, fa.Date_Account_Opened, CURDATE()) AS Account_Age_Months,
    (
        SELECT COUNT(*) 
        FROM Transaction t 
        WHERE t.Account_ID = fa.Account_ID
    ) AS Total_Transactions
FROM 
    User u
JOIN 
    Financial_Account fa ON u.User_ID = fa.User_ID
WHERE 
    fa.Is_Business_Account = FALSE
ORDER BY 
    u.Full_Name ASC, fa.Account_Balance DESC;


select * from financial_account;

SELECT 
    u.User_ID,
    u.Full_Name,
    b.Business_ID,
    b.Business_Name,
    CONCAT('**-***', RIGHT(b.EIN, 4)) AS EIN_Last_4,
    b.Business_Phone,
    b.Business_Email,
    fa.Account_ID,
    fa.Institution_Name,
    fa.Account_Type,
    fa.Account_Name,
    CONCAT('******', RIGHT(fa.Account_Number, 4)) AS Account_Ends_With,
    CONCAT('$', FORMAT(fa.Account_Balance, 2)) AS Account_Balance,
    DATE_FORMAT(fa.Date_Account_Opened, '%b %d, %Y') AS Opened_On,
    TIMESTAMPDIFF(MONTH, fa.Date_Account_Opened, CURDATE()) AS Account_Age_Months,
    (
        SELECT COUNT(*) 
        FROM Transaction t 
        WHERE t.Account_ID = fa.Account_ID
    ) AS Total_Transactions
FROM 
    User u
JOIN 
    Business_User b ON u.User_ID = b.User_ID
JOIN 
    Financial_Account fa ON u.User_ID = fa.User_ID
WHERE 
    fa.Is_Business_Account = TRUE
ORDER BY 
    b.Business_Name ASC, fa.Account_Balance DESC;


SELECT 
    u.User_ID,
    u.Full_Name,
    b.Business_ID,
    b.Business_Name,
    CONCAT('**-***', RIGHT(b.EIN, 4)) AS EIN_Last_4,
    b.Business_Phone,
    b.Business_Email,
    fa.Account_ID,
    fa.Institution_Name,
    fa.Account_Type,
    fa.Account_Name,
    CONCAT('******', RIGHT(fa.Account_Number, 4)) AS Account_Number_Last_4,
    CONCAT('$', FORMAT(fa.Account_Balance, 2)) AS Account_Balance,
    DATE_FORMAT(fa.Date_Account_Opened, '%b %d, %Y') AS Opened_On,
    TIMESTAMPDIFF(YEAR, fa.Date_Account_Opened, CURDATE()) AS Account_Age_Years,
    (
        SELECT COUNT(*) 
        FROM Transaction t 
        WHERE t.Account_ID = fa.Account_ID
    ) AS Total_Transactions,
FROM 
    User u
JOIN 
    Business_User b ON u.User_ID = b.User_ID
JOIN 
    Financial_Account fa ON u.User_ID = fa.User_ID
WHERE 
    fa.Is_Business_Account = TRUE
ORDER BY 
    b.Business_Name ASC, fa.Account_Balance DESC;

--  v. Select All Transactions for Personal Users Only
    SELECT 
    u.User_ID,
    u.Full_Name,
    u.Email,
    fa.Account_ID,
    fa.Account_Name,
    fa.Account_Type,
    fa.Institution_Name,
    CONCAT('******', RIGHT(fa.Account_Number, 4)) AS Account_Last_4,
    t.Transaction_ID,
    t.Transaction_Type,
    CONCAT('$', FORMAT(t.Amount, 2)) AS Transaction_Amount,
    DATE_FORMAT(t.Transaction_Timestamp, '%b %d, %Y @%h:%i%p') AS Timestamp,
    t.Payment_Method,
    t.Payment_Category,
    LEFT(t.Short_Description, 50) AS Summary
FROM 
    User u
JOIN 
    Financial_Account fa ON u.User_ID = fa.User_ID
JOIN 
    Transaction t ON fa.Account_ID = t.Account_ID
WHERE 
    fa.Is_Business_Account = FALSE
ORDER BY 
    t.Transaction_Timestamp DESC, u.Full_Name ASC;

-- ✅ vi. Select All Transactions for Business Users Only

SELECT 
    u.User_ID,
    u.Full_Name as Business_Account_Owner,
    b.Business_ID,
    b.Business_Name,
    fa.Account_ID,
    fa.Institution_Name,
    fa.Account_Type,
    CONCAT('******', RIGHT(fa.Account_Number, 4)) AS Account_Last_4,
    fa.Account_Name,
    t.Transaction_ID,
    t.Transaction_Type,
    CONCAT('$', FORMAT(t.Amount, 2)) AS Transaction_Amount,
    DATE_FORMAT(t.Transaction_Timestamp, '%b %d, %Y at %h:%i %p') AS Timestamp,
    t.Payment_Method,
    t.Payment_Category,
    LEFT(t.Short_Description, 50) AS Summary
FROM 
    User u
JOIN 
    Business_User b ON u.User_ID = b.User_ID
JOIN 
    Financial_Account fa ON u.User_ID = fa.User_ID
JOIN 
    Transaction t ON fa.Account_ID = t.Account_ID
WHERE 
    fa.Is_Business_Account = TRUE
ORDER BY 
    b.Business_Name ASC, t.Transaction_Timestamp DESC;


-- Select All Valuable Tax Information for Users with SSN and Filed Taxes
SELECT 
    u.User_ID,
    u.Full_Name,
    CONCAT('****-**-', RIGHT(u.SSN, 4)) AS SSN_Last4,
    u.Email,
    u.Phone_Number,
    tr.Tax_Year,
    tr.Filing_Status,
    IFNULL(CONCAT('$', FORMAT(tr.Spouse_Income, 2)), 'N/A') AS Spouse_Income,
    tr.Num_Dependents,
    tt.Tax_Category,
    CONCAT('$', FORMAT(tt.Taxable_Amount, 2)) AS Taxable_Amount,
    DATE_FORMAT(tt.Identified_Timestamp, '%b %d, %Y @%h:%i%p') AS Tax_Record_Timestamp,
    LEFT(tt.Notes, 80) AS Notes_Preview,
       (
        SELECT CONCAT('$', FORMAT(SUM(tt2.Taxable_Amount), 2))
        FROM Taxable_Transaction tt2
        WHERE tt2.Tax_Report_ID = tr.Tax_Report_ID
    ) AS Total_Taxable_Income
FROM User u
JOIN Tax_Report tr ON u.User_ID = tr.User_ID
JOIN Taxable_Transaction tt ON tr.Tax_Report_ID = tt.Tax_Report_ID
WHERE u.SSN IS NOT NULL
ORDER BY 
    u.Full_Name ASC, tr.Tax_Year DESC, tt.Identified_Timestamp DESC;


