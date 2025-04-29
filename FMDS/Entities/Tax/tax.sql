-- ---------------------------------------------------------
-- ? TAX_REPORT – Strong Entity
CREATE TABLE Tax_Report (
    Tax_Report_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Transaction_ID INT NOT NULL,
    Tax_Year YEAR NOT NULL,
    Filing_Status VARCHAR(30) CHECK (Filing_Status IN ('Single', 'Married Filing Jointly', 'Married Filing Separately', 'Head of Household', 'Qualifying Surviving Spouse')),
    Tax_Category VARCHAR(50),
    Taxable_Amount DECIMAL(10, 2),
    Identified_Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Spouse_Income DECIMAL(10, 2),
    Num_Dependents INT,
    Tax_Description TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Tax_Report PRIMARY KEY (Tax_Report_ID),
    CONSTRAINT FK_User_Tax FOREIGN KEY (User_ID) REFERENCES User(User_ID),
    CONSTRAINT FK_Transaction_Tax FOREIGN KEY (Transaction_ID) REFERENCES Transaction(Transaction_ID)
);
-- ---------------------------------------------------------
-- * Tax Report Insert Statement
INSERT INTO Tax_Report (User_ID, Transaction_ID, Tax_Year, Filing_Status, Tax_Category, Taxable_Amount, Identified_Timestamp, Spouse_Income, Num_Dependents, Tax_Description)
VALUES
(1, 1, 2023, 'Single', 'Income', 1000.00, '2023-01-15 10:00:00', NULL, 0, 'Salary deposit for January'),
(2, 2, 2024, 'Married Filing Jointly', 'Expense', 200.00, '2023-01-20 14:30:00', NULL, 1, 'Cash withdrawal for groceries'),
(3, 3, 2023, 'Head of Household', 'Expense', 500.00, '2023-02-05 09:15:00', NULL, 2, 'Transfer to savings account'),
(4, 4, 2023, 'Single', 'Income', 1500.00, '2023-02-10 11:45:00', NULL, 0, 'Bonus payment for February'),
(5, 5, 2023, 'Married Filing Separately', 'Expense', 300.00, '2023-03-01 16:20:00', NULL, 1, 'Purchase at local store'),
(6, 6, 2023, 'Qualifying Surviving Spouse', 'Expense', 700.00, '2023-03-15 12:10:00', NULL, 2, 'Transfer to investment account'),
(7, 7, 2023, 'Single', 'Income', 1200.00, '2023-04-01 08:00:00', NULL, NULL ,0 ,NULL),
(8 ,8 ,2023 ,'Married Filing Jointly' ,'Expense' ,150.00 ,'2023-04-10' ,'13:30:00' ,NULL ,1 ,'Cash withdrawal for dining out'),
(9 ,9 ,2023 ,'Head of Household' ,'Expense' ,400.00 ,'2023-05-05' ,'10:45:00' ,NULL ,2 ,'Transfer to emergency fund'),
(10 ,10 ,2023 ,'Single' ,'Income' ,800.00 ,'2023-05-15' ,'15:20:00' ,NULL ,0 ,'Freelance payment for May');
-- ---------------------------------------------------------
-- * Tax Report Select Statement
SELECT * FROM Tax_Report;