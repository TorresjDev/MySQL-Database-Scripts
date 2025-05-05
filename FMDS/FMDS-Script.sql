-- ? FMDS - Database
CREATE DATABASE FMDS;
USE FMDS;

-- -- ---------------------------------------------------------
-- -- ---------------------------------------------------------
-- -- ? Tables
-- -- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? USERS
-- ---------------------------------------------------------
-- -- * User - Supertype
CREATE TABLE User (
    User_ID INT NOT NULL AUTO_INCREMENT,
    Full_Name VARCHAR(100) NOT NULL,
    Date_Of_Birth DATE NOT NULL,
    SSN CHAR(11) UNIQUE NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone_Number VARCHAR(15) NOT NULL,
    Address_Line_1 VARCHAR(100) NOT NULL,
    Address_Line_2 VARCHAR(100),
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State CHAR(2) NOT NULL,
    Zip_Code VARCHAR(10) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Has_Business BOOLEAN DEFAULT FALSE,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_User PRIMARY KEY (User_ID)
);
-- -------------------------------------------------------------
-- -- * Business_User - Subtype of User
CREATE TABLE Business_User (
    Business_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    EIN VARCHAR(15) UNIQUE NOT NULL,
    Business_Name VARCHAR(100) NOT NULL,
    Start_Of_Business DATE NOT NULL,
    Business_Phone VARCHAR(15),
    Business_Email VARCHAR(100),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Business_User PRIMARY KEY (Business_ID),
    CONSTRAINT FK_User_Business FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);
-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- ? Insert Statements
-- -------------------------------------------------------------
-- -- * User Insert Statements
INSERT INTO User (User_ID, Full_Name, Date_Of_Birth, SSN, Email, Phone_Number, Address_Line_1, Address_Line_2, Street, City, State, Zip_Code, Country, Has_Business)
VALUES
(1, 'Alice Johnson', '1990-03-15', '123-45-6789', 'alice.johnson@email.com', '123-456-7890', '123', NULL, 'Main St', 'New York', 'NY', '10001', 'USA', TRUE),
(2, 'Brian Lee', '1985-07-20', NULL, 'brian.lee@email.com', '321-654-9870', '456', NULL, 'Elm St', 'Dallas', 'TX', '75001', 'USA', FALSE),
(3, 'Carlos Rivera', '1988-12-05', '987-65-4321', 'carlos.rivera@email.com', '789-654-1230', '789', NULL, 'Oak St', 'Houston', 'TX', '77002', 'USA', TRUE),
(4, 'Diana Blake', '1995-04-22', NULL, 'diana.blake@email.com', '147-258-3690', '321', NULL, 'Pine St', 'San Antonio', 'TX', '78205', 'USA', TRUE),
(5, 'Ethan Hunt', '1992-11-11', '135-45-6279', 'ethan.hunt@email.com', '123-456-7890', '423', NULL, 'Maple St', 'Austin', 'TX', '73301', 'USA', FALSE);
-- -------------------------------------------------------------
-- -- * Business User Insert Statements
INSERT INTO Business_User (User_ID, EIN, Business_Name, Start_Of_Business, Business_Phone, Business_Email)
VALUES
(1, '12-3456789', 'Tech Innovations', '2010-01-01', '5551234567', 'tech.innovations@gmail.com'),
(3, '14-3475189', 'Rivera Consulting LLC', '2015-06-01', '8882223333', 'contact@riveraconsult.com'),
(4, '98-7654321', 'Blake Design Studio', '2018-09-15', '8664449999', 'hello@blakedesigns.com');
-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- ? Select Statements
SELECT * FROM User;
SELECT * FROM Business_User;
SELECT * FROM User WHERE Has_Business = TRUE;
SELECT * FROM User WHERE SSN IS NOT NULL;
-- ------------------------------------------------------------
-- -- * Select All Users By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
    CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select Users with no SSN & no Business By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u WHERE u.SSN IS NULL AND u.Has_Business = FALSE ORDER BY u.User_ID ASC;
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


-- --------------------------------------------------------------
-- ? Financial_AccountS
-- --------------------------------------------------------------
-- -- * Financial Account – Strong Entity
CREATE TABLE Financial_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Institution_Name VARCHAR(100) NOT NULL,
    Account_Type VARCHAR(30) NOT NULL CHECK (Account_Type IN ('Bank', 'Loan', 'Investment', 'Digital Asset', 'Credit')),
    Account_Name VARCHAR(100) NOT NULL,
    Account_Number VARCHAR(30) UNIQUE NOT NULL,
    Account_Balance DECIMAL(12, 2) NOT NULL,
    Date_Account_Opened DATE NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Financial_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_User_Account FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);
-- -------------------------------------------------------------
-- -- * Bank Account –> Subtype of Financial Account
CREATE TABLE Bank_Account (
    Account_ID INT NOT NULL,
    Routing_Number CHAR(9) NOT NULL,
    APY DECIMAL(5, 2),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Bank_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Bank FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID),
    CONSTRAINT UQ_Bank_Account UNIQUE (Account_ID, Routing_Number)
);
-- -------------------------------------------------------------
-- -- * Loan Account –> Subtype of Financial Account
CREATE TABLE Loan_Account (
    Account_ID INT NOT NULL,
    Loan_Amount DECIMAL(12, 2) NOT NULL,
    Loan_Term INT NOT NULL,
    Interest_Rate DECIMAL(5, 2) NOT NULL,
    Exp_Monthly_Payment DECIMAL(10, 2) NOT NULL,
    Start_Date DATE NOT NULL,
    Exp_End_Date DATE NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Loan_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Loan FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- -------------------------------------------------------------
-- -- * Credit Account –> Subtype of Financial Account
CREATE TABLE Credit_Account (
    Account_ID INT NOT NULL,
    Credit_Card_Number VARCHAR(25) NOT NULL,
    Credit_Limit DECIMAL(12, 2) NOT NULL,
    Interest_Rate DECIMAL(5, 2) NOT NULL,
    Billing_Cycle_Due_Date DATE NOT NULL,
    Card_Expiration_Date CHAR(7) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Credit_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Credit FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- -------------------------------------------------------------
-- -- * Investment Account –> Subtype of Financial Account
CREATE TABLE Investment_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Buying_Power DECIMAL(12, 2) NOT NULL,
    Cash_Balance DECIMAL(12, 2) NOT NULL,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Investment_Value DECIMAL(12, 2) NOT NULL,
    Total_Dividends_Earned DECIMAL(12, 2) NOT NULL,
    Total_Interest_Earned DECIMAL(12, 2) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Investment_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID) 
);
-- -------------------------------------------------------------
-- -- * Digital Asset Account –> Subtype of Financial Account
CREATE TABLE Digital_Asset_Account (
    Account_ID INT NOT NULL,
    Digital_Account_Type VARCHAR(50) NOT NULL,
    Wallet_Address VARCHAR(100) UNIQUE NOT NULL,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Digital_Assets_Value DECIMAL(12, 2) NOT NULL,
    Total_Dividends_Earned DECIMAL(12, 2) NOT NULL,
    Total_Interest_Earned DECIMAL(12, 2) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Digital_Asset_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Digital FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- -------------------------------------------------------------
-- ? Insert && Select Statements
-- -------------------------------------------------------------

-- -- * Financial Account Insert Statement
INSERT INTO Financial_Account (User_ID, Institution_Name, Account_Type, Account_Name, Account_Number, Account_Balance, Date_Account_Opened)
VALUES
(1, 'Wells Fargo', 'Bank', 'Primary Checking', '111122223333', 2500.00, '2023-01-01'),
(2, 'Chase Bank', 'Bank', 'Savings Account', '444455556666', 4500.00, '2022-11-10'),
(3, 'Robinhood', 'Investment', 'Brokerage', 'RH77889900', 10000.00, '2023-03-05'),
(4, 'BlockFi', 'Digital Asset', 'Crypto Wallet', 'BFCrypto001', 3200.00, '2023-02-15'),
(5, 'Navy Federal', 'Credit', 'Visa Signature', '998877665544', 1200.00, '2023-05-20'),
(1, 'SoFi', 'Loan', 'Student Loan', 'SL12345678', 15000.00, '2021-09-01'),
(2, 'Bank of America', 'Bank', 'Primary Checking', '222233334444', 3000.00, '2023-04-01'),
(2, 'Coinbase', 'Digital Asset', 'Crypto Wallet', 'COIN12345678', 5000.00, '2023-06-10'),
(4, 'Fidelity', 'Investment', 'Retirement Account', 'FID98765432', 20000.00, '2023-07-15'),
(5, 'American Express', 'Credit', 'Gold Card', 'AMEX55556666', 8000.00, '2023-08-20'),
(3, 'Chase Bank', 'Loan', 'Auto Loan', 'AL12345678', 20000.00, '2022-10-01'),
(4, 'TD Ameritrade', 'Investment', 'Brokerage Account', 'TDA12345678', 15000.00, '2023-10-01'),
(5, 'PayPal', 'Digital Asset', 'Crypto Wallet', 'PAYPAL12345678', 3000.00, '2023-11-01');
Select * from Financial_Account;
-- -------------------------------------------------------------
-- -- -- * Bank Account Insert Statement
INSERT INTO Bank_Account (Account_ID, Routing_Number, APY)
VALUES
(1, '123456789', 0.05),
(2, '987654321', 0.03),
(12, '456789123', 0.04);
Select * from Bank_Account;
-- -------------------------------------------------------------
-- -- -- * Loan Account Insert Statement
INSERT INTO Loan_Account (Account_ID, Loan_Amount, Loan_Term, Interest_Rate, Exp_Monthly_Payment, Start_Date, Exp_End_Date)
VALUES
(1, 15000.00, 120, 5.25, 160.00, '2021-09-01', '2031-09-01'),
(2, 20000.00, 60, 4.75, 400.00, '2022-10-01', '2027-10-01');
Select * from Loan_Account;
-- -------------------------------------------------------------
-- -- -- * Financial --> Credit Account Insert Statement
INSERT INTO Credit_Account (Account_ID, Credit_Card_Number, Credit_Limit, Interest_Rate, Billing_Cycle_Due_Date, Card_Expiration_Date)
VALUES
(5, '4111111111111111', 5000.00, 18.99, '2024-05-10', '2027-05'),
(10, '5500000000000004', 10000.00, 15.99, '2024-06-15', '2026-06');
Select * from Credit_Account;
-- -------------------------------------------------------------
-- -- -- * Investment Account Insert Statement
INSERT INTO Investment_Account (Account_ID, Buying_Power, Cash_Balance, Total_User_Contribution, Total_Investment_Value, Total_Dividends_Earned, Total_Interest_Earned)
VALUES
(3, 5000.00, 1500.00, 8000.00, 10250.00, 120.50, 45.25),
(9, 20000.00, 7000.00, 13000.00, 25000.00, 400.00, 200.00),
(12, 15000.00, 5000.00, 10000.00, 20000.00, 300.00, 150.00);
SELECT * FROM Investment_Account;
-- -------------------------------------------------------------
-- -- * Digital Asset Account Insert Statement
INSERT INTO Digital_Asset_Account (Account_ID, Digital_Account_Type, Wallet_Address, Total_User_Contribution, Total_Digital_Assets_Value, Total_Dividends_Earned, Total_Interest_Earned)
VALUES 
(4, 'Crypto Wallet', '0xA1B2C3D4E5F6G7H8I9J0', 3200.00, 4100.00, 85.00, 22.50),
(8, 'Crypto Wallet', '0xB1C2D3E4F5G6H7I8J9K0', 5000.00, 6000.00, 150.00, 30.00),
(13, 'Hardware Wallet', '0xC1D2E3F4G5H6I7J8K9L0', 7000.00, 8000.00, 200.00, 40.00);
SELECT * FROM Digital_Asset_Account;
-- -------------------------------------------------------------
-- ? Select Statement
-- -------------------------------------------------------------
-- -- * Select All Financial Accounts
SELECT * FROM Financial_Account;
SELECT * FROM Bank_Account;
SELECT * FROM Loan_Account;
SELECT * FROM Credit_Account;
SELECT * FROM Investment_Account;
SELECT * FROM Digital_Asset_Account;
-- -- -------------------------------------------------------------
-- -- * Select All Financial Accounts with User Data
SELECT fa.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, fa.Account_Balance, fa.Date_Account_Opened
FROM Financial_Account fa
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------
-- -- * Select All Bank Accounts with User Data
SELECT ba.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, ba.Routing_Number, fa.Account_Balance, ba.APY, fa.Date_Account_Opened
FROM Bank_Account ba
    JOIN Financial_Account fa ON ba.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------
-- -- * Select All Loan Accounts with User Data
SELECT la.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, la.Loan_Amount, la.Loan_Term, la.Interest_Rate, la.Exp_Monthly_Payment, la.Start_Date, la.Exp_End_Date, fa.Account_Balance, fa.Date_Account_Opened
FROM Loan_Account la
    JOIN Financial_Account fa ON la.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------
-- -- * Select All Credit Accounts with User Data
SELECT ca.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, ca.Credit_Card_Number, ca.Credit_Limit, ca.Interest_Rate, ca.Billing_Cycle_Due_Date, ca.Card_Expiration_Date, fa.Account_Balance, fa.Date_Account_Opened
FROM Credit_Account ca
    JOIN Financial_Account fa ON ca.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------
-- -- * Select All Investment Accounts with User Data
SELECT ia.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, ia.Buying_Power, ia.Cash_Balance, ia.Total_User_Contribution, ia.Total_Investment_Value, ia.Total_Dividends_Earned, ia.Total_Interest_Earned, fa.Account_Balance, fa.Date_Account_Opened
FROM Investment_Account ia
    JOIN Financial_Account fa ON ia.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------
-- -- * Select All Digital Asset Accounts with User Data
SELECT da.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, da.Digital_Account_Type, da.Wallet_Address, da.Total_User_Contribution, da.Total_Digital_Assets_Value, da.Total_Dividends_Earned, da.Total_Interest_Earned, fa.Account_Balance, fa.Date_Account_Opened
FROM Digital_Asset_Account da
    JOIN Financial_Account fa ON da.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------

-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? CREDIT_REPORT – Strong Entity
-- ---------------------------------------------------------
-- -- * Create Credit Report Entity
CREATE TABLE Credit_Report (
      Credit_Report_ID INT NOT NULL AUTO_INCREMENT,
      User_ID INT NOT NULL,
      Credit_Bureau_Name VARCHAR(50) NOT NULL CHECK (Credit_Bureau_Name IN ('Equifax', 'Experian', 'TransUnion')),
      Credit_Score INT NOT NULL CHECK (Credit_Score BETWEEN 300 AND 850),
      Report_Date DATE NOT NULL,
      Credit_Description TEXT,
      Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      CONSTRAINT PK_Credit_Report PRIMARY KEY (Credit_Report_ID),
      CONSTRAINT FK_User_Credit FOREIGN KEY (User_ID) REFERENCES User(User_ID),
      CONSTRAINT UQ_User_Bureau_Date UNIQUE (User_ID, Credit_Bureau_Name, Report_Date)
);
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? Insert Statements
-- -- * Credit Report Insert Statement 
INSERT INTO Credit_Report (User_ID, Credit_Bureau_Name, Credit_Score, Report_Date, Credit_Description)
VALUES
(1, 'Equifax', 720, '2023-01-15', 'Good credit history'),
(1, 'Experian', 710, '2023-01-15', 'Good credit history'),
(1, 'TransUnion', 715, '2023-01-15', 'Good credit history'),
(3, 'Equifax', 680, '2023-02-20', 'Average credit history'),
(3, 'Experian', 690, '2023-02-20', 'Average credit history'),
(3, 'TransUnion', 685, '2023-02-20', 'Average credit history'),
(5, 'Equifax', 750, '2023-03-10', 'Excellent credit history'),
(5, 'Experian', 740, '2023-03-10', 'Excellent credit history'),
(5, 'TransUnion', 745, '2023-03-10', 'Excellent credit history');
-- ---------------------------------------------------------
-- ? Select Statements
-- * Credit Report Select Statement
SELECT * FROM Credit_Report;
-- -- ---------------------------------------------------------
-- -- * Select All Credit Reports by User_ID
SELECT cr.User_ID, u.Full_Name, u.SSN, u.Date_Of_Birth AS DOB, CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address, cr.Credit_Report_ID AS CR_ID, cr.Report_Date, cr.Credit_Bureau_Name, cr.Credit_Score, cr.Credit_Description, u.Email as User_Email, u.Phone_Number as User_Phone_Number
FROM Credit_Report cr
JOIN User u ON cr.User_ID = u.User_ID ORDER BY cr.User_ID ASC, cr.Report_Date DESC;
-- -- * Select A Credit Report by User_ID
SELECT cr.User_ID, u.Full_Name, u.SSN, u.Date_Of_Birth AS DOB, CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address, cr.Credit_Report_ID AS CR_ID, cr.Report_Date, cr.Credit_Bureau_Name, cr.Credit_Score, cr.Credit_Description, u.Email as User_Email, u.Phone_Number as User_Phone_Number
FROM Credit_Report cr
JOIN User u ON cr.User_ID = u.User_ID 
WHERE cr.User_ID = 3 AND cr.Credit_Bureau_Name = 'Equifax' ORDER BY cr.User_ID ASC, cr.Report_Date DESC
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ! -------------------------------------------------------
-- ? Investments
-- ---------------------------------------------------------
-- -- * Investment_Account – Subtype of Financial_Account
CREATE TABLE Investment_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Buying_Power DECIMAL(12, 2) NOT NULL,
    Cash_Balance DECIMAL(12, 2) NOT NULL,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Investment_Value DECIMAL(12, 2) NOT NULL,
    Total_Dividends_Earned DECIMAL(12, 2) NOT NULL,
    Total_Interest_Earned DECIMAL(12, 2) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Investment_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID) 
);
-- ---------------------------------------------------------
-- -- * Investment_Holding - Strong Entity
CREATE TABLE Investment_Holding (
    Holdings_ID INT NOT NULL AUTO_INCREMENT,
    Account_ID INT NOT NULL,
    Investment_Type VARCHAR(30) NOT NULL,
    Investment_Symbol VARCHAR(15) NOT NULL,
    Investment_Name VARCHAR(100),
    Total_Quantity DECIMAL(12, 4) NOT NULL,
    Average_Price_Per_Share DECIMAL(12, 4),
    Current_Price DECIMAL(12, 4),
    Holdings_Value DECIMAL(14, 2),
    Unrealized_Gain_Or_Loss DECIMAL(14, 2),
    Realized_Gain_Or_Loss DECIMAL(14, 2),
    Date_Opened DATE NOT NULL,
    Holding_Status VARCHAR(20) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Investment_Holding PRIMARY KEY (Holdings_ID),
    CONSTRAINT FK_Account_Holding FOREIGN KEY (Account_ID) REFERENCES Investment_Account(Account_ID),
    CONSTRAINT UQ_Investment_Symbol UNIQUE (Account_ID, Investment_Symbol, Investment_Name)
);
-- ---------------------------------------------------------
-- -- * Investment_Asset - (Associative) Weak Entity
CREATE TABLE Investment_Asset (
    Action_ID INT NOT NULL AUTO_INCREMENT,
    Holdings_ID INT NOT NULL,
    Account_ID INT NOT NULL,
    Action_Type VARCHAR(20) NOT NULL,  
    Quantity DECIMAL(12, 4),          
    Price_Per_Share DECIMAL(12, 4),    
    Dividend_Amount DECIMAL(12, 2),
    Reinvestment_Flag BOOLEAN,       
    Fee_Type VARCHAR(30),              
    Fee_Amount DECIMAL(10, 2),
    Inv_Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Optional_Note TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Investment_Asset PRIMARY KEY (Action_ID),
    CONSTRAINT FK_Holdings_Investment FOREIGN KEY (Holdings_ID) REFERENCES Investment_Holding(Holdings_ID),
    CONSTRAINT FK_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Investment_Account(Account_ID),
    CONSTRAINT UQ_Investment_Asset UNIQUE (Holdings_ID, Action_Type, Inv_Timestamp, Quantity, Price_Per_Share)
);
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- ? Insert Statements
-- -------------------------------------------------------------
-- -- * Financial > Investment Account Insert Statement --> financial_accounts.sql
SELECT * FROM Investment_Account;
-- -------------------------------------------------------------
-- -- * Investment > Investment Holding Insert Statement
INSERT INTO Investment_Holding (Account_ID, Investment_Type, Investment_Symbol, Investment_Name, Total_Quantity, Average_Price_Per_Share, Current_Price, Holdings_Value, Unrealized_Gain_Or_Loss, Realized_Gain_Or_Loss, Date_Opened, Holding_Status)
VALUES
(3, 'Stock', 'AAPL', 'Apple Inc.', 50, 150.00, 160.00, 8000.00, 500.00, 0.00, '2023-05-25', 'Active'),
(3, 'Stock', 'TSLA', 'Tesla Inc.', 30, 700.00, 720.00, 21600.00, 600.00, 0.00, '2023-09-15', 'Active'),
(9, 'ETF', 'SPY', 'SPDR S&P 500 ETF Trust', 100, 400.00, 410.00, 41000.00, 1000.00, 0.00, '2023-10-01', 'Active'),
(12, 'ETF', 'VOO', 'Vanguard S&P 500 ETF', 20, 250.00, 260.00, 5200.00, 200.00, 0.00, '2023-07-15', 'Active'),
(12, 'Mutual Fund', 'VFIAX', 'Vanguard 500 Index Fund', 10, 3000.00, 3100.00, 31000.00, 1000.00, 0.00, '2023-08-01', 'Active');
SELECT * FROM Investment_Holding;
-- -------------------------------------------------------------
-- -- * Investment > Investment Asset Insert Statement
INSERT INTO Investment_Asset (Holdings_ID, Account_ID, Action_Type, Quantity, Price_Per_Share, Dividend_Amount, Reinvestment_Flag, Fee_Type, Fee_Amount, Inv_Timestamp, Optional_Note)
VALUES
(1, 3, 'Purchase', 10, 150.00, 0.00, FALSE, 'Brokerage Fee', 5.00, '2023-05-25 10:00:00', 'Initial purchase of Apple shares'),
(2, 3, 'Purchase', 5, 700.00, 0.00, FALSE, 'Brokerage Fee', 10.00, '2023-09-15 14:30:00', 'Initial purchase of Tesla shares'),
(3, 9, 'Dividend', 0, 0.00, 50.00, TRUE, 'Reinvestment Fee', 0.00, '2023-10-01 12:00:00', 'Dividend reinvestment for SPY ETF'),
(4, 12, 'Purchase', 2, 250.00, 0.00, FALSE, 'Brokerage Fee', 5.00, '2023-07-15 11:30:00', 'Initial purchase of VOO ETF'),
(5, 12, 'Purchase', 1, 3000.00, 0.00, FALSE, 'Brokerage Fee', 20.00, '2023-08-01 09:45:00', 'Initial purchase of VFIAX Mutual Fund');
SELECT * FROM Investment_Asset;
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- ? Select Statements
-- -------------------------------------------------------------
-- -- * Select All Investments
SELECT * FROM Investment_Account;
SELECT * FROM Investment_Holding;
SELECT * FROM Investment_Asset;
-- -- -------------------------------------------------------------
-- -- * Select All Investment Assets in Investment Accounts > Financial Account by User

-- Drop all tables in the database

-- -- ---------------------------------------------------------
-- ! -----------------------------------------------------------
-- ? Digital Assets
-- -- ---------------------------------------------------------
-- -- * Digital_Assets_Account – Subtype of Financial_Account
-- -- ---------------------------------------------------------
CREATE TABLE Digital_Asset_Account (
    Account_ID INT NOT NULL,
    Digital_Account_Type VARCHAR(50) NOT NULL,
    Wallet_Address VARCHAR(100) UNIQUE NOT NULL,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Digital_Assets_Value DECIMAL(12, 2) NOT NULL,
    Total_Dividends_Earned DECIMAL(12, 2) NOT NULL,
    Total_Interest_Earned DECIMAL(12, 2) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Digital_Asset_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Digital FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- -- ---------------------------------------------------------
-- -- * Digital_Assets_Holding - Strong Entity
CREATE TABLE Digital_Asset_Holding (
    Holding_ID INT NOT NULL AUTO_INCREMENT,
    Account_ID INT NOT NULL,
    Digital_Asset_Type VARCHAR(30) NOT NULL, -- 'Crypto', 'NFT', etc.
    Digital_Asset_Symbol VARCHAR(15) NOT NULL,
    Digital_Asset_Name VARCHAR(100),
    Total_Quantity DECIMAL(18, 8) NOT NULL,
    Total_Purchase_Price DECIMAL(20, 2) NOT NULL,
    Average_Price_Per_Share DECIMAL(18, 8) NOT NULL,
    Current_Price DECIMAL(18, 8) NOT NULL,
    Holdings_Value DECIMAL(20, 2),
    Unrealized_Gain_Or_Loss DECIMAL(20, 2),
    Realized_Gain_Or_Loss DECIMAL(20, 2),
    Date_Opened DATE NOT NULL,
    Holding_Status VARCHAR(20) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Digital_Asset_Holding PRIMARY KEY (Holding_ID),
    CONSTRAINT FK_Account_Digital_Holding FOREIGN KEY (Account_ID)
        REFERENCES Digital_Asset_Account(Account_ID),
    CONSTRAINT UQ_Digital_Asset_Hold UNIQUE (Account_ID, Digital_Asset_Symbol, Digital_Asset_Type)
);
-- -- ---------------------------------------------------------
-- -- * Digital_Assets_Asset - (Associative) Weak Entity
CREATE TABLE Digital_Asset (
    Action_ID INT NOT NULL AUTO_INCREMENT,
    Holding_ID INT NOT NULL,
    Account_ID INT NOT NULL,
    Action_Type VARCHAR(20) NOT NULL, 
    Quantity DECIMAL(18, 8) NOT NULL,
    Price_Per_Token DECIMAL(18, 8),
    Yield_Amount DECIMAL(12, 2), 
    Gas_Fee DECIMAL(10, 2),
    Transaction_Fee DECIMAL(10, 2),
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Optional_Note TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Digital_Asset PRIMARY KEY (Action_ID),
    CONSTRAINT FK_Holding_Digital FOREIGN KEY (Holding_ID) REFERENCES Digital_Asset_Holding(Holding_ID),
    CONSTRAINT FK_Account_Digital FOREIGN KEY (Account_ID) REFERENCES Digital_Asset_Account(Account_ID),
    CONSTRAINT UQ_Digital_Asset UNIQUE (Holding_ID, Action_Type, Timestamp, Quantity, Price_Per_Token)
);
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- ? Insert Statements
-- -------------------------------------------------------------
-- -- -- * Financial > Digital Asset Account Insert Statement --> financial_accounts.sql
SELECT * FROM Digital_Asset_Account;
-- -------------------------------------------------------------
-- -- -- * Digital Asset > Digital Asset Holding Insert Statement
INSERT INTO Digital_Asset_Holding (Account_ID, Digital_Asset_Type, Digital_Asset_Symbol, Digital_Asset_Name, Total_Quantity, Total_Purchase_Price, Average_Price_Per_Share, Current_Price, Holdings_Value, Unrealized_Gain_Or_Loss, Realized_Gain_Or_Loss, Date_Opened, Holding_Status)
VALUES
(13, 'Crypto', 'BTC', 'Bitcoin', 2.5, 100000.00, 40000.00, 45000.00, 112500.00, 12500.00, 0.00, '2023-01-01', 'Active'),
(13, 'Crypto', 'ETH', 'Ethereum', 10.0, 20000.00, 2000.00, 2500.00, 25000.00, 5000.00, 0.00, '2023-02-01', 'Active'),
(4, 'Digital Art', 'NFT', 'CryptoPunk #1234', 1.0, 500000.00, 500000.00, 600000.00, 600000.00, 100000.00, 0.00, '2023-03-01', 'Active'),
(8, 'Crypto', 'SOL', 'Solana', 50.0, 5000.00, 100.00, 120.00, 6000.00, 1000.00, 0.00, '2023-04-01', 'Active'),
(8, 'Digital Art', 'NFT', 'Bored Ape #5678', 1.0, 200000.00, 200000.00, 250000.00, 250000.00, 50000.00, 0.00, '2023-05-01', 'Active');
SELECT * FROM Digital_Asset_Holding;
-- -------------------------------------------------------------
-- -- -- * Digital Asset Insert Statement
INSERT INTO Digital_Asset (Holding_ID, Account_ID, Action_Type, Quantity, Price_Per_Token, Yield_Amount, Gas_Fee, Transaction_Fee, Timestamp, Optional_Note)
VALUES
(1, 13, 'Purchase', 0.5, 40000.00, NULL, 0.50, 2.00, '2023-01-15 10:00:00', 'Purchased Bitcoin'),
(1, 13, 'Sale', 0.2, 45000.00, NULL, 0.50, 2.00, '2023-02-15 10:00:00', 'Sold Bitcoin for profit'),
(2, 13, 'Purchase', 1.0, 2000.00, NULL, 0.50, 2.00, '2023-03-15 10:00:00', 'Purchased Ethereum'),
(3, 4, 'Purchase', 1.0, 500000.00, NULL, 0.50, 2.00, '2023-04-15 10:00:00', 'Purchased CryptoPunk #1234'),
(4, 8, 'Purchase', 25.0, 100.00, NULL, 0.50, 2.00, '2023-05-15 10:00:00', 'Purchased Solana'),
(5, 8, 'Sale', 10.0, 120.00, NULL, 0.50, 2.00, '2023-06-15 10:00:00', 'Sold Solana for profit');
SELECT * FROM Digital_Asset;    
-- -------------------------------------------------------------

-- ---------------------------------------------------------
-- ? TRANSACTION – Strong Entity
-- -- * Transaction - Strong Entity
CREATE TABLE Transaction (
    Transaction_ID INT NOT NULL AUTO_INCREMENT,
    Account_ID INT NOT NULL,
    Transaction_Type VARCHAR(30) NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Transaction_Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Payment_Method VARCHAR(50),
    Payment_Category VARCHAR(50),
    Short_Description TEXT,
    CONSTRAINT PK_Transaction PRIMARY KEY (Transaction_ID),
    CONSTRAINT FK_Account_Transaction FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID),
    CONSTRAINT UQ_Transaction UNIQUE (Account_ID, Transaction_Type, Amount, Transaction_Timestamp, Payment_Method)
);
-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- ? Insert Statements
-- -------------------------------------------------------------
-- -- * Transaction Insert Statement
INSERT INTO Transaction (Account_ID, Transaction_Type, Amount, Transaction_Timestamp, Payment_Method, Payment_Category, Short_Description)
VALUES
(1, 'Deposit', 1000.00, '2023-10-01 09:00:00', 'Direct Deposit', 'Income', 'Salary for September'),
(1, 'Withdrawal', 100.00, '2023-10-02 15:00:00', 'Debit Card Purchase', 'Groceries', 'Walmart grocery run'),
(2, 'Deposit', 500.00, '2023-10-03 08:30:00', 'Internal Transfer', 'Income', 'Transferred from Checking'),
(2, 'Withdrawal', 50.00, '2023-10-04 14:20:00', 'ATM Withdrawal', 'Cash', 'Emergency cash withdrawal'),
(3, 'Purchase', 800.00, '2023-10-05 10:15:00', 'Robinhood App', 'Stock', 'Bought 5 shares of AAPL'),
(3, 'Dividend', 15.00, '2023-10-06 11:30:00', 'Automatic Reinvest', 'Dividend', 'SPY dividend reinvested'),
(4, 'Buy', 1000.00, '2023-10-07 13:45:00', 'Crypto Wallet', 'Crypto', 'Bought BTC with USD'),
(4, 'Interest', 25.00, '2023-10-08 12:00:00', 'Crypto Wallet', 'Interest', 'Monthly interest payout'),
(5, 'Payment', 300.00, '2023-10-09 09:30:00', 'Online Banking', 'Credit Payment', 'Paid off statement balance'),
(5, 'Charge', 120.00, '2023-10-10 17:00:00', 'Visa Swipe', 'Entertainment', 'AMC movie tickets'),
(6, 'Payment', 200.00, '2023-10-11 08:00:00', 'Bank Transfer', 'Loan Payment', 'October student loan payment'),
(6, 'Interest', 25.00, '2023-10-12 23:00:00', 'Interest Accrual', 'Interest', 'Monthly interest accrued'),
(7, 'Deposit', 1200.00, '2023-10-13 09:15:00', 'Direct Deposit', 'Income', 'Paycheck October'),
(7, 'Withdrawal', 200.00, '2023-10-14 19:30:00', 'Debit Purchase', 'Dining', 'Dinner with family'),
(8, 'Buy', 750.00, '2023-10-15 11:20:00', 'Coinbase Wallet', 'Crypto', 'Bought ETH'),
(8, 'Gas Fee', 10.00, '2023-10-15 11:25:00', 'Blockchain Fee', 'Fee', 'Transaction gas fee'),
(9, 'Contribution', 2000.00, '2023-10-16 10:00:00', 'Bank Transfer', 'Retirement', 'IRA contribution'),
(9, 'Dividend', 35.00, '2023-10-17 13:30:00', 'Auto Reinvest', 'Dividend', 'VOO quarterly dividend'),
(10, 'Charge', 600.00, '2023-10-18 17:15:00', 'Tap to Pay', 'Travel', 'Hotel stay in Houston'),
(10, 'Payment', 600.00, '2023-10-19 08:00:00', 'Online Payment', 'Credit Payment', 'Paid off Gold Card'),
(11, 'Payment', 350.00, '2023-10-20 08:30:00', 'Auto Debit', 'Loan Payment', 'October car payment'),
(11, 'Interest', 45.00, '2023-10-21 00:00:00', 'Auto Accrual', 'Interest', 'Monthly interest accrued'),
(12, 'Purchase', 1200.00, '2023-10-22 10:10:00', 'TDA Account', 'Stock', 'Bought shares of QQQ'),
(12, 'Dividend', 20.00, '2023-10-23 12:00:00', 'Reinvest', 'Dividend', 'QQQ dividend payout'),
(13, 'Buy', 500.00, '2023-10-24 14:15:00', 'PayPal Crypto', 'Crypto', 'Purchased LTC'),
(13, 'Sell', 300.00, '2023-10-25 16:30:00', 'PayPal Wallet', 'Crypto', 'Sold partial LTC holdings');
SELECT * FROM Transaction;
-- ---------------------------------------------------------
-- -- ? SELECT Statements


-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? TAXES
-- ---------------------------------------------------------
-- -- * Tax_Report - Strong Entity
CREATE TABLE Tax_Report (
    Tax_Report_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Tax_Year YEAR NOT NULL,
    Filing_Status VARCHAR(30) CHECK (Filing_Status IN 
      ('Single', 'Married Filing Jointly', 'Married Filing Separately', 'Head of Household', 'Qualifying Surviving Spouse')),
    Spouse_Income DECIMAL(12, 2),
    Num_Dependents INT,
    Tax_Notes TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Tax_Report PRIMARY KEY (Tax_Report_ID),
    CONSTRAINT FK_User_Tax_Report FOREIGN KEY (User_ID) REFERENCES User(User_ID),
    CONSTRAINT UQ_Tax_Report UNIQUE (User_ID, Tax_Year, Filing_Status, Spouse_Income, Num_Dependents)
);
-- ---------------------------------------------------------
-- -- * Taxable_Transaction - (Associative) Weak Entity
CREATE TABLE Taxable_Transaction (
    Tx_ID INT NOT NULL,
    Tax_Report_ID INT NOT NULL,
    Tax_Category VARCHAR(50),        -- e.g., 'Capital Gains', 'Interest', 'Wages'
    Taxable_Amount DECIMAL(12, 2),   -- Portion of this transaction considered taxable
    Identified_Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Notes TEXT,
    CONSTRAINT PK_Taxable_Transaction PRIMARY KEY (Tx_ID),
    CONSTRAINT FK_Tx_Tax FOREIGN KEY (Tx_ID) REFERENCES Transaction(Transaction_ID),
    CONSTRAINT FK_Tax_Report_Join FOREIGN KEY (Tax_Report_ID) REFERENCES Tax_Report(Tax_Report_ID)
);
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- -- ? Insert Statements
-- -- * Tax Report Insert Statements
INSERT INTO Tax_Report (User_ID, Tax_Year, Filing_Status, Spouse_Income, Num_Dependents, Tax_Notes)
VALUES
(1, 2023, 'Single', NULL, 0, 'Standard income filing'),
(3, 2023, 'Married Filing Jointly', 45000.00, 2, 'Includes spouse income and dependents'),
(5, 2023, 'Head of Household', NULL, 1, 'Freelance work + family support');
SELECT * FROM Tax_Report;
-- ---------------------------------------------------------
-- -- * Taxable Transaction Insert Statements
INSERT INTO Taxable_Transaction (Tx_ID, Tax_Report_ID, Tax_Category, Taxable_Amount, Identified_Timestamp, Notes)
VALUES
(1, 1, 'Wages', 1000.00, '2023-10-01 09:00:00', 'Salary reported for September'),
(3, 1, 'Freelance Income', 500.00, '2023-10-03 08:30:00', 'Income from freelance work'),
(7, 1, 'Wages', 1200.00, '2023-10-13 09:15:00', 'October paycheck'),
(5, 2, 'Dividends', 15.00, '2023-10-06 11:30:00', 'SPY dividend reinvested'),
(6, 2, 'Investment Expense', 300.00, '2023-10-06 11:20:00', 'Robinhood premium fee - partially deductible'),
(17, 2, 'Dividends', 35.00, '2023-10-17 13:30:00', 'VOO quarterly dividend'),
(12, 2, 'Capital Gains', 1200.00, '2023-10-22 10:10:00', 'Gains from QQQ stock purchase'),
(9, 3, 'Freelance Income', 800.00, '2023-10-09 17:00:00', 'Freelance work payout'),
(15, 3, 'Interest Income', 25.00, '2023-10-08 12:00:00', 'Crypto platform interest accrued'),
(19, 3, 'Travel Expense', 600.00, '2023-10-18 17:15:00', 'Work travel charges reimbursed later'),
(24, 3, 'Capital Gains', 300.00, '2023-10-25 16:30:00', 'LTC partial sale - capital gain');


SELECT * FROM Taxable_Transaction;
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- -- ? Select Statements
-- -- * SELECT ALL VALUABLE TAX INFORMATION FOR USER
SELECT u.Full_Name, u.Email, u.Phone_Number, t.Tax_Year, t.Filing_Status, t.Spouse_Income, t.Num_Dependents, tt.Tax_Category, tt.Taxable_Amount, tt.Identified_Timestamp, tt.Notes
FROM User u
JOIN Tax_Report t ON u.User_ID = t.User_ID
JOIN Taxable_Transaction tt ON t.Tax_Report_ID = tt.Tax_Report_ID
-- WHERE u.User_ID = 1; -- Replace with the desired User_ID
-- ---------------------------------------------------------

select * from business_user;

SELECT 
    u.User_ID,
    u.Full_Name,
    b.Business_ID,
    b.Business_Name,
    b.EIN,
    b.Start_Of_Business
FROM 
    User u
JOIN 
    Business_User b ON u.User_ID = b.User_ID
WHERE 
    u.Has_Business = TRUE;
