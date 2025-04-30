-- ---------------------------------------------------------
-- ---------------------------------------------------------
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
    Total_Capital_Gains DECIMAL(12, 2) NOT NULL,
    Total_Unrealized_Gains DECIMAL(12, 2) NOT NULL,
    Total_Realized_Gains DECIMAL(12, 2) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Investment_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID) 
);
-- -- ---------------------------------------------------------
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
    Total_Value DECIMAL(14, 2),
    Unrealized_Gain_Or_Loss DECIMAL(14, 2),
    Realized_Gain_Or_Loss DECIMAL(14, 2),
    Date_Opened DATE NOT NULL,
    Holding_Status VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Investment_Holding PRIMARY KEY (Holdings_ID),
    CONSTRAINT FK_Account_Holding FOREIGN KEY (Account_ID) REFERENCES Investment_Account(Account_ID)
);
-- -- ---------------------------------------------------------
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
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Optional_Note TEXT,
    CONSTRAINT PK_Investment_Asset PRIMARY KEY (Action_ID),
    CONSTRAINT FK_Holdings_Investment FOREIGN KEY (Holdings_ID) REFERENCES Investment_Holding(Holdings_ID),
    CONSTRAINT FK_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Investment_Account(Account_ID)
);