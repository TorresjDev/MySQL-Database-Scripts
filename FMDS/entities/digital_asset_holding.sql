-- ===============================
-- * Digital Asset Holding - Strong Entity
-- ===============================
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
    CONSTRAINT FK_Account_Digital_Holding FOREIGN KEY (Account_ID) REFERENCES Digital_Asset_Account (Account_ID),
    CONSTRAINT UQ_Digital_Asset_Hold UNIQUE (
        Account_ID,
        Digital_Asset_Symbol,
        Digital_Asset_Type
    )
);
-- ===============================