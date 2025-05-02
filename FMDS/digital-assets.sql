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