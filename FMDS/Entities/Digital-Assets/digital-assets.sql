-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? Digital Assets
-- ---------------------------------------------------------
-- -- * Digital_Assets_Account – Subtype of Financial_Account
-- ---------------------------------------------------------
CREATE TABLE Digital_Asset_Account (
    Account_ID INT NOT NULL,
    Digital_Account_Type VARCHAR(50) NOT NULL,
    Wallet_Address VARCHAR(100) UNIQUE NOT NULL,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Digital_Assets_Amount DECIMAL(12, 2) NOT NULL,
    Total_Dividends_Earned DECIMAL(12, 2) NOT NULL,
    Total_Interest_Earned DECIMAL(12, 2) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Digital_Asset_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Digital FOREIGN KEY (Account_ID)
        REFERENCES Financial_Account(Account_ID)
);
-- -- ---------------------------------------------------------
-- -- * Digital_Assets_Holding - Strong Entity
-- ---------------------------------------------------------
CREATE TABLE Digital_Asset_Holding (
    Holding_ID INT NOT NULL AUTO_INCREMENT,
    Account_ID INT NOT NULL,
    Digital_Asset_Type VARCHAR(30) NOT NULL, -- 'Crypto', 'NFT', etc.
    Asset_Symbol VARCHAR(15) NOT NULL,
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
        REFERENCES Digital_Asset_Account(Account_ID)
);
-- -- ---------------------------------------------------------
-- -- * Digital_Assets_Asset - (Associative) Weak Entity
-- ---------------------------------------------------------
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
    CONSTRAINT FK_Account_Digital FOREIGN KEY (Account_ID) REFERENCES Digital_Asset_Account(Account_ID)
);