-- ===============================
-- * Tax_Report - Strong Entity
-- ===============================
CREATE TABLE Tax_Report (
    Tax_Report_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Tax_Year YEAR NOT NULL,
    Filing_Status VARCHAR(30) CHECK (
        Filing_Status IN (
            'Single',
            'Married Filing Jointly',
            'Married Filing Separately',
            'Head of Household',
            'Qualifying Surviving Spouse'
        )
    ),
    Spouse_Income DECIMAL(12, 2),
    Num_Dependents INT,
    Tax_Notes TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Tax_Report PRIMARY KEY (Tax_Report_ID),
    CONSTRAINT FK_User_Tax_Report FOREIGN KEY (User_ID) REFERENCES User (User_ID),
    CONSTRAINT UQ_Tax_Report UNIQUE (
        User_ID,
        Tax_Year,
        Filing_Status,
        Spouse_Income,
        Num_Dependents
    )
);
-- ===============================