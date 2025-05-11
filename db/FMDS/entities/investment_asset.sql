-- ===============================
-- * Investment Asset - Associative Entity
-- ===============================
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
    CONSTRAINT FK_Holdings_Investment FOREIGN KEY (Holdings_ID) REFERENCES Investment_Holding (Holdings_ID),
    CONSTRAINT FK_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Investment_Account (Account_ID),
    CONSTRAINT UQ_Investment_Asset UNIQUE (
        Holdings_ID,
        Action_Type,
        Inv_Timestamp,
        Quantity,
        Price_Per_Share
    )
);
-- ===============================