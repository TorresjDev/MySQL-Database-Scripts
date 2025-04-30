-- --------------------------------------------------------------
-- --------------------------------------------------------------
-- ? FINANCIAL_ACCOUNTS
-- -- * Financial Account – Strong Entity
CREATE TABLE Financial_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Institution_Name VARCHAR(100) NOT NULL,
    Account_Type VARCHAR(30) NOT NULL CHECK (Account_Type IN ('Bank', 'Loan', 'Investment', 'Digital Asset', 'Credit')),
    Account_Name VARCHAR(100) NOT NULL,
    Account_Number VARCHAR(10-30) NOT NULL,
    Account_Balance DECIMAL(12, 2) NOT NULL,
    Date_Account_Opened DATE NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Financial_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_User_Account FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- -------------------------------------------------------------
-- -- * Bank_Account – Weak Entity
CREATE TABLE Bank_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Routing_Number CHAR(9) NOT NULL,
    APY DECIMAL(5, 2),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Bank_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Bank FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- -- * Loan_Account – Weak Entity
CREATE TABLE Loan_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Loan_Amount DECIMAL(12, 2) NOT NULL,
    Loan_Term INT NOT NULL,
    Interest_Rate DECIMAL(5, 2) NOT NULL,
    Exp_Monthly_Payment DECIMAL(10, 2) NOT NULL,
    Start_Date DATE NOT NULL,
    Exp_End_Date DATE NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Loan_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Loan FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- -------------------------------------------------------------
-- -- * Credit_Account – Weak Entity
CREATE TABLE Credit_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Credit_Card_Number VARCHAR(19-25) NOT NULL,
    Credit_Limit DECIMAL(12, 2) NOT NULL,
    Interest_Rate DECIMAL(5, 2) NOT NULL,
    Billing_Cycle_Due_Date DATE NOT NULL,
    Card_Expiration_Date CHAR(7) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Credit_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Credit FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- -------------------------------------------------------------
-- -- * Investment_Account – Weak Entity
CREATE TABLE Investment_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Investment_Value DECIMAL(12, 2) NOT NULL,
    

    CONSTRAINT PK_Investment_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID) 
);
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- -------------------------------------------------------------
-- -- * Digital_Asset_Account – Weak Entity
CREATE TABLE Digital_Asset_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Digital_Account_Type VARCHAR(50) NOT NULL,
    Wallet_Address VARCHAR(100) UNIQUE NOT NULL,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Holdings_Amount DECIMAL(12, 2) NOT NULL,
    Digital_Portfolio_Value DECIMAL(12, 2),
    CONSTRAINT PK_Digital_Asset_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Digital FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- -------------------------------------------------------------
-- ? Insert Statement
-- -- * Financial > Bank Account Insert Statement
INSERT INTO FINANCIAL_ACCOUNT (User_ID, Institution_Name, Account_Type, Account_Name, Account_Number, Account_Balance, Date_Account_Opened)
VALUES
(1, 'Bank of America', 'Bank', 'Savings Account', '123456789', 10000.00, '2023-01-01'),
(1, 'Wells Fargo', 'Bank', 'Checking Account', '987654321', 3500.00, '2023-02-15'),
(2, 'Chase', 'Bank', 'Chase Business Account', '147258369', 12000.00, '2023-05-01'),
(3, 'Citibank', 'Bank', 'Business Checking Account', '159753468', 8000.00, '2023-07-01'),
(4, 'Wells Fargo', 'Bank', 'Personal Savings Account', '369147258', 2000.00, '2023-11-15'),
(5, 'Bank of America', 'Bank', 'Business Savings Account', '951753852', 6000.00, '2023-12-20');
-- -------------------------------------------------------------
INSERT INTO Bank_Account (Account_ID, Routing_Number, APY)
VALUES
(1, '123456789', 0.05),
(1, '987654321', 0.03),
(2, '147258369', 0.04),
(3, '159753468', 0.02),
(4, '369147258', 0.01),
(5, '951753852', 0.06);
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- -------------------------------------------------------------
-- -- * Financial > Loan Account Insert Statement
INSERT INTO FINANCIAL_ACCOUNT (User_ID, Institution_Name, Account_Type, Account_Name, Account_Number, Account_Balance, Date_Account_Opened)
VALUES
(1, 'Chase', 'Loan', 'Chase Auto Loan', '321654987', 15000.00, '2023-04-20'),
(2, 'Chase', 'Loan', 'Chase Home Loan', '789456123', 250000.00, '2023-06-01'),
(3, 'Wells Fargo', 'Loan', 'Wells Fargo Personal Loan', '456123789', 5000.00, '2023-08-01'),
(4, 'Bank of America', 'Loan', 'Bank of America Student Loan', '654789321', 20000.00, '2023-09-15'),
(5, 'Chase', 'Loan', 'Chase Business Line of Credit', '258369147', 8000.00, '2024-01-15');
-- -------------------------------------------------------------
INSERT INTO Loan_Account (Account_ID, Loan_Amount, Loan_Term, Interest_Rate, Exp_Monthly_Payment, Start_Date, Exp_End_Date)
VALUES
(1, 15000.00, 60, 3.5, 300.00, '2023-04-20', '2028-04-20'),
(2, 250000.00, 360, 4.0, 1200.00, '2023-06-01', '2053-06-01'),
(3, 5000.00, 24, 5.0, 250.00, '2023-08-01', '2025-08-01'),
(4, 20000.00, 48, 6.0, 500.00, '2023-09-15', '2027-09-15'),
(5, 8000.00, 36, 4.5, 250.00, '2024-01-15', '2027-01-15');
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- -------------------------------------------------------------
-- -- * Financial > Credit Account Insert Statement
INSERT INTO FINANCIAL_ACCOUNT (User_ID, Institution_Name, Account_Type, Account_Name, Account_Number, Account_Balance, Date_Account_Opened)
VALUES
(1, 'Citibank', 'Credit', 'Citibank Student Credit', '456789123', 5000.00, '2023-03-10'),
(2, 'American Express', 'Credit', 'Amex Gold Card', '258741369', 8000.00, '2023-05-15'),
(3, 'American Express', 'Credit', 'Amex Platinum Card', '456123789', 6000.00, '2023-09-01'),
(4, 'Chase', 'Credit', 'Chase Freedom Card', '753159486', 3000.00, '2023-12-01'),
(5, 'American Express', 'Credit', 'Amex Business Gold Card', '456789321', 9000.00, '2024-02-01');
-- -------------------------------------------------------------
INSERT INTO Credit_Account (Account_ID, Credit_Card_Number, Credit_Limit, Interest_Rate, Billing_Cycle_Due_Date, Card_Expiration_Date)
VALUES
(1, '1234567890123456', 10000.00, 15.0, '2023-01-15', '2025-01'),
(2, '9876543210987654', 15000.00, 18.0, '2023-02-20', '2025-02'),
(3, '4561237890123456', 20000.00, 12.0, '2023-03-10', '2025-03'),
(4, '3216549870123456', 5000.00, 20.0, '2023-04-05', '2025-04'),
(5, '2583691470123456', 8000.00, 22.0, '2024-01-15', '2026-01');
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- -------------------------------------------------------------
-- -- * Financial > Investment Account Insert Statement
INSERT INTO FINANCIAL_ACCOUNT (User_ID, Institution_Name, Account_Type, Account_Name, Account_Number, Account_Balance, Date_Account_Opened)
VALUES
(1, 'Robinhood', 'Investment', 'Robinhood Account', '369258147', 5000.00, '2023-05-25'),
(2, 'Robinhood', 'Investment', 'Robinhood Gold Account', '321654987', 4000.00, '2023-09-15'),
(3, 'Coinbase', 'Investment', 'Coinbase Pro Account', '654789321', 9000.00, '2023-10-01'),
(4, 'Wells Fargo', 'Investment', 'Wells Fargo Investment Account', '753951468', 15000.00, '2023-07-15'),
(5, 'Chase', 'Investment', 'Chase Investment Account', '159753258', 20000.00, '2023-08-01');
-- -------------------------------------------------------------
INSERT INTO Investment_Account (Account_ID, Total_User_Contribution, Total_Holdings_Amount)
VALUES
(1, 5000.00, 10000.00),
(2, 4000.00, 8000.00),
(3, 9000.00, 20000.00),
(4, 15000.00, 30000.00),
(5, 20000.00, 50000.00);
-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- -------------------------------------------------------------
-- -- * Financial > Digital Asset Account Insert Statement
INSERT INTO FINANCIAL_ACCOUNT (User_ID, Institution_Name, Account_Type, Account_Name, Account_Number, Account_Balance, Date_Account_Opened)
VALUES
(1, 'Robinhood', 'Digital Asset', 'Robinhood Crypto Wallet', '963852741', 3000.00, '2023-06-01'),
(2, 'Coinbase', 'Digital Asset', 'Coinbase Account', '852963741', 7000.00, '2023-06-10'),
(3, 'Coinbase', 'Digital Asset', 'Coinbase Pro Account', '654789321', 9000.00, '2023-10-01'),
(4, 'Chase', 'Digital Asset', 'Chase Crypto Wallet', '753951468', 15000.00, '2023-07-15'),
(5, 'Robinhood', 'Digital Asset', 'Robinhood Crypto Wallet', '159753258', 20000.00, '2023-08-01');
-- -------------------------------------------------------------
INSERT INTO Digital_Asset_Account (Account_ID, Digital_Account_Type, Wallet_Address, Total_User_Contribution, Total_Holdings_Amount, Digital_Portfolio_Value)
VALUES
(1, 'Crypto', '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa', 3000.00, 5000.00, 7000.00),
(2, 'Crypto', '3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy', 7000.00, 10000.00, 15000.00),
(3, 'Crypto', '1BvBMSEYstWetqTFn5Au4m4GFyFeo8YxJ9', 9000.00, 12000.00, 20000.00),
(4, 'Crypto', '1C6g7h8j9k0lmnopQRStuvwxYZ1234567890', 15000.00, 20000.00, 25000.00),
(5, 'Crypto', '1D2e3F4g5H6i7J8k9L0mnopQRStuvwxYZ1234567890', 20000.00, 30000.00, 40000.00);

-- -------------------------------------------------------------
-- ! -----------------------------------------------------------
-- -------------------------------------------------------------
-- ? Select Statement


INSERT INTO Financial_Account (User_ID, Institution_Name, Account_Type, Account_Name, Account_Number, Account_Balance, Date_Account_Opened)
VALUES
(1, 'Bank of America', 'Bank', 'Savings Account', '123456789', 10000.00, '2023-01-01'),
(1, 'Wells Fargo', 'Bank', 'Checking Account', '987654321', 3500.00, '2023-02-15'),
(1, 'Citibank', 'Credit', 'Citibank Student Credit', '456789123', 5000.00, '2023-03-10'),
(1, 'Chase', 'Loan', 'Chase Auto Loan', '321654987', 15000.00, '2023-04-20'),
(2, 'Chase', 'Bank', 'Chase Business Account', '147258369', 12000.00, '2023-05-01'),
(2, 'American Express', 'Credit', 'Amex Gold Card', '258741369', 8000.00, '2023-05-15'),
(2, 'Robinhood', 'Investment', 'Robinhood Account', '369258147', 5000.00, '2023-05-25'),
(2, 'Robinhood', 'Digital Asset', 'Robinhood Crypto Wallet', '963852741', 3000.00, '2023-06-01'),
(2, 'Coinbase', 'Digital Asset', 'Coinbase Account', '852963741', 7000.00, '2023-06-10'),
(3, 'Bank of America', 'Bank', 'Business Checking Account', '159753468', 8000.00, '2023-07-01'),
(3, 'American Express', 'Credit', 'Amex Platinum Card', '456123789', 6000.00, '2023-09-01'),
(3, 'Robinhood', 'Investment', 'Robinhood Gold Account', '321654987', 4000.00, '2023-09-15'),
(3, 'Coinbase', 'Digital Asset', 'Coinbase Pro Account', '654789321', 9000.00, '2023-10-01'),
(3, 'Wells Fargo', 'Bank', 'Business Savings Account', '753951468', 15000.00, '2023-07-15'),
(3, 'Citibank', 'Credit', 'Citibank Business Credit', '159753258', 20000.00, '2023-08-01'),
(3, 'Chase', 'Loan', 'Chase Business Loan', '951357852', 25000.00, '2023-08-15'),
(4, 'Bank of America', 'Bank', 'Personal Checking Account', '258963147', 5000.00, '2023-11-01'),
(4, 'Wells Fargo', 'Bank', 'Personal Savings Account', '369147258', 2000.00, '2023-11-15'),
(4, 'Chase', 'Credit', 'Chase Freedom Card', '753159486', 3000.00, '2023-12-01'),
(4, 'American Express', 'Credit', 'Amex Blue Cash Card', '852741963', 4000.00, '2023-12-15'),
(5, 'Bank of America', 'Bank', 'Business Savings Account', '951753852', 6000.00, '2023-12-20'),
(5, 'Wells Fargo', 'Bank', 'Business Checking Account', '159357468', 7000.00, '2024-01-01'),
(5, 'Chase', 'Loan', 'Chase Business Line of Credit', '258369147', 8000.00, '2024-01-15'),
(5, 'American Express', 'Credit', 'Amex Business Gold Card', '456789321', 9000.00, '2024-02-01');

