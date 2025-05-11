-- ===============================
-- * Investment Holding - Strong Entity
-- ===============================
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
    CONSTRAINT FK_Account_Holding FOREIGN KEY (Account_ID) REFERENCES Investment_Account (Account_ID),
    CONSTRAINT UQ_Investment_Symbol UNIQUE (
        Account_ID,
        Investment_Symbol,
        Investment_Name
    )
);
-- ===============================