-- ---------------------------------------------------------
-- ? TRANSACTION – Strong Entity
-- -- * Transaction - Strong Entity
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
    CONSTRAINT FK_Account_Transaction FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID),
    CONSTRAINT UQ_Transaction UNIQUE (Account_ID, Transaction_Type, Amount, Transaction_Timestamp, Payment_Method)
);
-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- ? Insert Statements
-- -------------------------------------------------------------
-- -- * Transaction Insert Statement
INSERT INTO Transaction (Account_ID, Transaction_Type, Amount, Transaction_Timestamp, Payment_Method, Payment_Category, Short_Description)
VALUES
(1, 'Deposit', 1000.00, '2023-10-01 09:00:00', 'Direct Deposit', 'Income', 'Salary for September'),
(1, 'Withdrawal', 100.00, '2023-10-02 15:00:00', 'Debit Card Purchase', 'Groceries', 'Walmart grocery run'),
(2, 'Deposit', 500.00, '2023-10-03 08:30:00', 'Internal Transfer', 'Income', 'Transferred from Checking'),
(2, 'Withdrawal', 50.00, '2023-10-04 14:20:00', 'ATM Withdrawal', 'Cash', 'Emergency cash withdrawal'),
(3, 'Purchase', 800.00, '2023-10-05 10:15:00', 'Robinhood App', 'Stock', 'Bought 5 shares of AAPL'),
(3, 'Dividend', 15.00, '2023-10-06 11:30:00', 'Automatic Reinvest', 'Dividend', 'SPY dividend reinvested'),
(4, 'Buy', 1000.00, '2023-10-07 13:45:00', 'Crypto Wallet', 'Crypto', 'Bought BTC with USD'),
(4, 'Interest', 25.00, '2023-10-08 12:00:00', 'Crypto Wallet', 'Interest', 'Monthly interest payout'),
(5, 'Payment', 300.00, '2023-10-09 09:30:00', 'Online Banking', 'Credit Payment', 'Paid off statement balance'),
(5, 'Charge', 120.00, '2023-10-10 17:00:00', 'Visa Swipe', 'Entertainment', 'AMC movie tickets'),
(6, 'Payment', 200.00, '2023-10-11 08:00:00', 'Bank Transfer', 'Loan Payment', 'October student loan payment'),
(6, 'Interest', 25.00, '2023-10-12 23:00:00', 'Interest Accrual', 'Interest', 'Monthly interest accrued'),
(7, 'Deposit', 1200.00, '2023-10-13 09:15:00', 'Direct Deposit', 'Income', 'Paycheck October'),
(7, 'Withdrawal', 200.00, '2023-10-14 19:30:00', 'Debit Purchase', 'Dining', 'Dinner with family'),
(8, 'Buy', 750.00, '2023-10-15 11:20:00', 'Coinbase Wallet', 'Crypto', 'Bought ETH'),
(8, 'Gas Fee', 10.00, '2023-10-15 11:25:00', 'Blockchain Fee', 'Fee', 'Transaction gas fee'),
(9, 'Contribution', 2000.00, '2023-10-16 10:00:00', 'Bank Transfer', 'Retirement', 'IRA contribution'),
(9, 'Dividend', 35.00, '2023-10-17 13:30:00', 'Auto Reinvest', 'Dividend', 'VOO quarterly dividend'),
(10, 'Charge', 600.00, '2023-10-18 17:15:00', 'Tap to Pay', 'Travel', 'Hotel stay in Houston'),
(10, 'Payment', 600.00, '2023-10-19 08:00:00', 'Online Payment', 'Credit Payment', 'Paid off Gold Card'),
(11, 'Payment', 350.00, '2023-10-20 08:30:00', 'Auto Debit', 'Loan Payment', 'October car payment'),
(11, 'Interest', 45.00, '2023-10-21 00:00:00', 'Auto Accrual', 'Interest', 'Monthly interest accrued'),
(12, 'Purchase', 1200.00, '2023-10-22 10:10:00', 'TDA Account', 'Stock', 'Bought shares of QQQ'),
(12, 'Dividend', 20.00, '2023-10-23 12:00:00', 'Reinvest', 'Dividend', 'QQQ dividend payout'),
(13, 'Buy', 500.00, '2023-10-24 14:15:00', 'PayPal Crypto', 'Crypto', 'Purchased LTC'),
(13, 'Sell', 300.00, '2023-10-25 16:30:00', 'PayPal Wallet', 'Crypto', 'Sold partial LTC holdings');
SELECT * FROM Transaction;
-- ---------------------------------------------------------
-- -- ? SELECT Statements
