-- ---------------------------------------------------------
-- ? TRANSACTION – Strong Entity
CREATE TABLE Transaction (
    Transaction_ID INT NOT NULL AUTO_INCREMENT,
    Account_ID INT NOT NULL,
    Transaction_Type VARCHAR(30) NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Transaction_Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Payment_Method VARCHAR(50),
    Payment_Category VARCHAR(50),
    Short_Description TEXT,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Transaction PRIMARY KEY (Transaction_ID),
    CONSTRAINT FK_Account_Transaction FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- ---------------------------------------------------------
-- * Transaction Insert Statement
INSERT INTO Transaction (Account_ID, Transaction_Type, Amount, Transaction_Timestamp, Payment_Method, Payment_Category, Short_Description)
VALUES
(1, 'Deposit', 1000.00, '2023-01-15 10:00:00', 'Bank Transfer', 'Income', 'Salary deposit for January'),
(2, 'Withdrawal', 200.00, '2023-01-20 14:30:00', 'ATM Withdrawal', 'Expense', 'Cash withdrawal for groceries'),
(3, 'Transfer', 500.00, '2023-02-05 09:15:00', 'Online Transfer', 'Expense', 'Transfer to savings account'),
(4, 'Deposit', 1500.00, '2023-02-10 11:45:00', 'Direct Deposit', 'Income', 'Bonus payment for February'),
(5, 'Withdrawal', 300.00, '2023-03-01 16:20:00', 'Debit Card Purchase', 'Expense', 'Purchase at local store'),
(6, 'Transfer', 700.00, '2023-03-15 12:10:00', 'Online Transfer', 'Expense', 'Transfer to investment account');
-- (7, 'Deposit', 1200.00, '2023-04-01 08:00:00', 'Bank Transfer', 'Income', 'Salary deposit for April'),
(8, 'Withdrawal', 150.00, '2023-04-10 13:30:00', 'ATM Withdrawal', 'Expense', 'Cash withdrawal for dining out'),
(9, 'Transfer', 400.00, '2023-05-05 10:45:00', 'Online Transfer', 'Expense', 'Transfer to emergency fund'),
(10, 'Deposit', 800.00, '2023-05-15 15:20:00', 'Direct Deposit', 'Income', 'Freelance payment for May');
-- ---------------------------------------------------------
-- * Transaction Select Statement
SELECT * FROM Transaction;