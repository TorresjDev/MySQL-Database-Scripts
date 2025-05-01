-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? TAXES
-- ---------------------------------------------------------
-- -- * Tax_Report - Strong Entity
-- ---------------------------------------------------------
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
    CONSTRAINT FK_User_Tax_Report FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);
-- ---------------------------------------------------------
-- -- * Taxable_Transaction - (Associative) Weak Entity
-- ---------------------------------------------------------
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
-- * Tax Report Insert Statement if User_ID has SSN
-- ---------------------------------------------------------

-- ---------------------------------------------------------
-- * Tax Report Select Statement
-- ---------------------------------------------------------
SELECT * FROM Tax_Report;