-- ===============================
-- * Digital Asset - Associative Entity
-- ===============================
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
    TIMESTAMP DATETIME DEFAULT CURRENT_TIMESTAMP,
    Optional_Note TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Digital_Asset PRIMARY KEY (Action_ID),
    CONSTRAINT FK_Holding_Digital FOREIGN KEY (Holding_ID) REFERENCES Digital_Asset_Holding (Holding_ID),
    CONSTRAINT FK_Account_Digital FOREIGN KEY (Account_ID) REFERENCES Digital_Asset_Account (Account_ID),
    CONSTRAINT UQ_Digital_Asset UNIQUE (
        Holding_ID,
        Action_Type,
        TIMESTAMP,
        Quantity,
        Price_Per_Token
    )
);
-- ===============================