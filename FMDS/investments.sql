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
