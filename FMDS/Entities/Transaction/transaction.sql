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
    CONSTRAINT PK_Transaction PRIMARY KEY (Transaction_ID),
    CONSTRAINT FK_Account_Transaction FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- ---------------------------------------------------------
-- * Transaction Insert Statement
INSERT INTO Transaction (Account_ID, Transaction_Type, Amount, Transaction_Timestamp, Payment_Method, Payment_Category, Short_Description)
VALUES
(1, 'Deposit', 1000.00, '2023-01-15 10:00:00', 'Bank Transfer', 'Income', 'Salary deposit for January'),
(3, 'Withdrawal', 200.00, '2023-01-20 14:30:00', 'ATM', 'Expense', 'Cash for groceries'),
(5, 'Transfer', 500.00, '2023-02-05 09:15:00', 'Online Transfer', 'Investment', 'Moved funds to investment'),
(1, 'Deposit', 1500.00, '2023-02-10 11:45:00', 'Direct Deposit', 'Income', 'February bonus'),
(2, 'Withdrawal', 300.00, '2023-03-01 16:20:00', 'Debit Card', 'Expense', 'Retail purchase'),
(3, 'Transfer', 700.00, '2023-03-15 12:10:00', 'Online Transfer', 'Investment', 'Contribution to IRA'),
(2, 'Withdrawal', 150.00, '2023-04-10 13:30:00', 'ATM', 'Expense', 'Dining out'),
(3, 'Transfer', 400.00, '2023-05-05 10:45:00', 'Online Transfer', 'Emergency Fund', 'Rainy day savings'),
(1, 'Deposit', 800.00, '2023-05-15 15:20:00', 'Direct Deposit', 'Freelance', 'May freelance payout'),
(4, 'Withdrawal', 250.00, '2023-06-01 11:00:00', 'Debit Card', 'Expense', 'Home improvement supplies'),
(5, 'Transfer', 600.00, '2023-06-10 14:50:00', 'Online Transfer', 'Investment', 'Stock purchase'),
(5, 'Deposit', 1200.00, '2023-07-01 09:30:00', 'Bank Transfer', 'Income', 'July salary deposit'),
(3, 'Withdrawal', 350.00, '2023-07-15 13:15:00', 'ATM', 'Expense', 'Vacation spending'),
(6, 'Transfer', 900.00, '2023-08-05 10:05:00', 'Online Transfer', 'Investment', 'Real estate investment'),
(4, 'Deposit', 2000.00, '2023-08-20 12:40:00', 'Direct Deposit', 'Income', 'August salary deposit'),
(5, 'Withdrawal', 500.00, '2023-09-01 14:25:00', 'Debit Card', 'Expense', 'New furniture purchase');
-- ---------------------------------------------------------
-- * Transaction Select Statement
SELECT * FROM Transaction;