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
(13, 'Sell', 300.00, '2023-10-25 16:30:00', 'PayPal Wallet', 'Crypto', 'Sold partial LTC holdings'),
(1, 'Payment', 3452.16, '2023-11-01 08:00:00', 'Direct Deposit', 'Credit Payment', 'Payment for credit payment'),
(1, 'Charge', 4236.17, '2023-11-01 10:00:00', 'Direct Deposit', 'Stock', 'Charge for stock'),
(18, 'Dividend', 4413.56, '2023-11-01 21:00:00', 'Bank Transfer', 'Loan Payment', 'Dividend for loan payment'),
(18, 'Payment', 3604.97, '2023-11-02 07:00:00', 'Bank Transfer', 'Stock', 'Payment for stock'),
(17, 'Buy', 1782.92, '2023-11-02 18:00:00', 'Card Swipe', 'Credit Payment', 'Buy for credit payment'),
(17, 'Buy', 4998.18, '2023-11-03 01:00:00', 'Bank Transfer', 'Loan Payment', 'Buy for loan payment'),
(6, 'Buy', 1196.42, '2023-11-03 11:00:00', 'Online Banking', 'Stock', 'Buy for stock'),
(6, 'Payment', 4649.11, '2023-11-03 20:00:00', 'Bank Transfer', 'Crypto', 'Payment for crypto'),
(14, 'Withdrawal', 708.33, '2023-11-04 01:00:00', 'Bank Transfer', 'Crypto', 'Withdrawal for crypto'),
(14, 'Payment', 2610.02, '2023-11-04 13:00:00', 'Card Swipe', 'Crypto', 'Payment for crypto'),
(14, 'Charge', 1893.50, '2023-11-04 18:00:00', 'Bank Transfer', 'Dividend', 'Charge for dividend'),
(3, 'Interest', 4310.53, '2023-11-05 00:00:00', 'Bank Transfer', 'Loan Payment', 'Interest for loan payment'),
(3, 'Dividend', 860.17, '2023-11-05 02:00:00', 'Online Banking', 'Dividend', 'Dividend for dividend'),
(16, 'Interest', 3602.82, '2023-11-05 07:00:00', 'Card Swipe', 'Dividend', 'Interest for dividend'),
(16, 'Buy', 2877.17, '2023-11-05 17:00:00', 'Direct Deposit', 'Stock', 'Buy for stock'),
(16, 'Charge', 1931.89, '2023-11-06 02:00:00', 'Card Swipe', 'Dividend', 'Charge for dividend'),
(11, 'Deposit', 4562.69, '2023-11-06 13:00:00', 'Bank Transfer', 'Loan Payment', 'Deposit for loan payment'),
(11, 'Deposit', 1440.27, '2023-11-07 01:00:00', 'Crypto Wallet', 'Loan Payment', 'Deposit for loan payment'),
(4, 'Interest', 3901.28, '2023-11-07 13:00:00', 'Online Banking', 'Interest', 'Interest for interest'),
(4, 'Buy', 4082.65, '2023-11-07 21:00:00', 'Bank Transfer', 'Stock', 'Buy for stock'),
(9, 'Dividend', 2043.73, '2023-11-08 09:00:00', 'Card Swipe', 'Dividend', 'Dividend for dividend'),
(9, 'Sell', 3175.81, '2023-11-08 19:00:00', 'Bank Transfer', 'Stock', 'Sell for stock'),
(12, 'Charge', 2915.35, '2023-11-09 08:00:00', 'Card Swipe', 'Crypto', 'Charge for crypto'),
(12, 'Payment', 1660.24, '2023-11-09 15:00:00', 'Direct Deposit', 'Loan Payment', 'Payment for loan payment');
SELECT * FROM Transaction;
-- ---------------------------------------------------------
-- -- ? SELECT Statements
