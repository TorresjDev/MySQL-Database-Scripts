-- ---------------------------------------------------------
-- ! -------------------------------------------------------
-- ? Investments
-- ---------------------------------------------------------
-- -- * Investment_Account – Subtype of Financial_Account
-- ---------------------------------------------------------
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
-- ---------------------------------------------------------
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
-- ---------------------------------------------------------
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
    Broker_Fee DECIMAL(10, 2),
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
-- -- * Financial > Investment Account Insert Statement
INSERT INTO Financial_Account (User_ID, Institution_Name, Account_Type, Account_Name, Account_Number, Account_Balance, Date_Account_Opened)
VALUES
(1, 'Robinhood', 'Investment', 'Robinhood Account', '369258147', 5000.00, '2023-05-25'),
(2, 'Robinhood', 'Investment', 'Robinhood Gold Account', '321654987', 4000.00, '2023-09-15'),
(3, 'Coinbase', 'Investment', 'Coinbase Pro Account', '654789321', 9000.00, '2023-10-01'),
(4, 'Wells Fargo', 'Investment', 'Wells Fargo Investment Account', '753951468', 15000.00, '2023-07-15'),
(5, 'Chase', 'Investment', 'Chase Investment Account', '159753258', 20000.00, '2023-08-01');
INSERT INTO Investment_Account (Account_ID, Buying_Power, Cash_Balance, Total_User_Contribution, Total_Investment_Value, Total_Dividends_Earned, Total_Interest_Earned)
VALUES
(1, 5000.00, 2000.00, 3000.00, 7000.00, 100.00, 50.00),
(2, 4000.00, 1500.00, 2500.00, 6000.00, 80.00, 40.00),
(3, 9000.00, 3000.00, 6000.00, 12000.00, 200.00, 100.00),
(4, 15000.00, 5000.00, 10000.00, 20000.00, 300.00, 150.00),
(5, 20000.00, 7000.00, 13000.00, 25000.00, 400.00, 200.00);
-- -------------------------------------------------------------
SELECT * FROM Investment_Account;
-- -------------------------------------------------------------
-- -- * Investment > Investment Holding Insert Statement
INSERT INTO Investment_Holding (Account_ID, Investment_Type, Investment_Symbol, Investment_Name, Total_Quantity, Average_Price_Per_Share, Current_Price, Holdings_Value, Unrealized_Gain_Or_Loss, Realized_Gain_Or_Loss, Date_Opened, Holding_Status)
VALUES
(1, 'Stock', 'AAPL', 'Apple Inc.', 50, 150.00, 160.00, 8000.00, 500.00, 0.00, '2023-05-25', 'Active'),
(2, 'Stock', 'TSLA', 'Tesla Inc.', 30, 700.00, 720.00, 21600.00, 600.00, 0.00, '2023-09-15', 'Active'),
(3, 'ETF', 'SPY', 'SPDR S&P 500 ETF Trust', 100, 400.00, 410.00, 41000.00, 1000.00, 0.00, '2023-10-01', 'Active'),
(4, 'ETF', 'VOO', 'Vanguard S&P 500 ETF', 20, 250.00, 260.00, 5200.00, 200.00, 0.00, '2023-07-15', 'Active'),
(5, 'Mutual Fund', 'VFIAX', 'Vanguard 500 Index Fund', 10, 3000.00, 3100.00, 31000.00, 1000.00, 0.00, '2023-08-01', 'Active');
-- -------------------------------------------------------------
SELECT * FROM Investment_Holding;
-- -- * Investment > Investment Asset Insert Statement
INSERT INTO Investment_Asset (Holdings_ID, Account_ID, Action_Type, Quantity, Price_Per_Share, Dividend_Amount, Reinvestment_Flag, Fee_Type, Broker_Fee, Inv_Timestamp, Optional_Note)
VALUES    
(6, 1, 'Buy', 10, 150.00, NULL, FALSE, 'Brokerage Fee', 5.00, '2023-05-26 10:00:00', 'Bought additional shares of AAPL.'),
(7, 2, 'Sell', 5, 720.00, NULL, FALSE, 'Brokerage Fee', 10.00, '2023-09-16 11:00:00', 'Sold some shares of TSLA.'),
(8, 3, 'Dividend', NULL, NULL, 50.00, TRUE, NULL, NULL, '2023-10-02 12:00:00', 'Received dividend payment from SPY.'),
(9, 4, 'Buy', 2, 260.00, NULL, FALSE, 'Brokerage Fee', 5.00, '2023-07-16 13:00:00', 'Bought additional shares of VOO.'),
(10, 5, 'Sell', 1, 3100.00, NULL, FALSE, 'Brokerage Fee', 15.00, '2023-08-02 14:00:00', 'Sold some shares of VFIAX.');
-- -------------------------------------------------------------
SELECT * FROM Investment_Asset;
-- -------------------------------------------------
