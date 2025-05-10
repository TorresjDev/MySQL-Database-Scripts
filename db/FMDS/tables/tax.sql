-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? TAXES
-- ---------------------------------------------------------
-- -- * Tax_Report - Strong Entity
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
    CONSTRAINT FK_User_Tax_Report FOREIGN KEY (User_ID) REFERENCES User(User_ID),
    CONSTRAINT UQ_Tax_Report UNIQUE (User_ID, Tax_Year, Filing_Status, Spouse_Income, Num_Dependents)
);
-- ---------------------------------------------------------
-- -- * Taxable_Transaction - (Associative) Weak Entity
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
-- ---------------------------------------------------------
-- -- ? Insert Statements
-- -- * Tax Report Insert Statements
INSERT INTO Tax_Report (User_ID, Tax_Year, Filing_Status, Spouse_Income, Num_Dependents, Tax_Notes)
VALUES
(1, 2023, 'Single', NULL, 0, 'Standard income filing'),
(3, 2023, 'Married Filing Jointly', 45000.00, 2, 'Includes spouse income and dependents'),
(5, 2023, 'Head of Household', NULL, 1, 'Freelance work + family support');
SELECT * FROM Tax_Report;
-- ---------------------------------------------------------
-- -- * Taxable Transaction Insert Statements
INSERT INTO Taxable_Transaction (Tx_ID, Tax_Report_ID, Tax_Category, Taxable_Amount, Identified_Timestamp, Notes)
VALUES
(1, 1, 'Wages', 1000.00, '2023-10-01 09:00:00', 'Salary reported for September'),
(3, 1, 'Freelance Income', 500.00, '2023-10-03 08:30:00', 'Income from freelance work'),
(7, 1, 'Wages', 1200.00, '2023-10-13 09:15:00', 'October paycheck'),
(5, 2, 'Dividends', 15.00, '2023-10-06 11:30:00', 'SPY dividend reinvested'),
(6, 2, 'Investment Expense', 300.00, '2023-10-06 11:20:00', 'Robinhood premium fee - partially deductible'),
(17, 2, 'Dividends', 35.00, '2023-10-17 13:30:00', 'VOO quarterly dividend'),
(12, 2, 'Capital Gains', 1200.00, '2023-10-22 10:10:00', 'Gains from QQQ stock purchase'),
(9, 3, 'Freelance Income', 800.00, '2023-10-09 17:00:00', 'Freelance work payout'),
(15, 3, 'Interest Income', 25.00, '2023-10-08 12:00:00', 'Crypto platform interest accrued'),
(19, 3, 'Travel Expense', 600.00, '2023-10-18 17:15:00', 'Work travel charges reimbursed later'),
(24, 3, 'Capital Gains', 300.00, '2023-10-25 16:30:00', 'LTC partial sale - capital gain');


SELECT * FROM Taxable_Transaction;
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- -- ? Select Statements
-- -- * SELECT ALL VALUABLE TAX INFORMATION FOR USER
SELECT u.Full_Name, u.Email, u.Phone_Number, t.Tax_Year, t.Filing_Status, t.Spouse_Income, t.Num_Dependents, tt.Tax_Category, tt.Taxable_Amount, tt.Identified_Timestamp, tt.Notes
FROM User u
JOIN Tax_Report t ON u.User_ID = t.User_ID
JOIN Taxable_Transaction tt ON t.Tax_Report_ID = tt.Tax_Report_ID
-- WHERE u.User_ID = 1; -- Replace with the desired User_ID
-- ---------------------------------------------------------