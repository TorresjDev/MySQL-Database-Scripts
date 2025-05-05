-- --------------------------------------------------------------
-- ? Financial_AccountS
-- --------------------------------------------------------------
-- -- * Financial Account – Strong Entity
CREATE TABLE Financial_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Institution_Name VARCHAR(100) NOT NULL,
    Account_Type VARCHAR(30) NOT NULL CHECK (Account_Type IN ('Bank', 'Loan', 'Investment', 'Digital Asset', 'Credit')),
    Account_Name VARCHAR(100) NOT NULL,
    Account_Number VARCHAR(30) UNIQUE NOT NULL,
    Account_Balance DECIMAL(12, 2) NOT NULL,
    Date_Account_Opened DATE NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Financial_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_User_Account FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);
-- -------------------------------------------------------------
-- -- * Bank Account –> Subtype of Financial Account
CREATE TABLE Bank_Account (
    Account_ID INT NOT NULL,
    Routing_Number CHAR(9) NOT NULL,
    APY DECIMAL(5, 2),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Bank_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Bank FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID),
    CONSTRAINT UQ_Bank_Account UNIQUE (Account_ID, Routing_Number)
);
-- -------------------------------------------------------------
-- -- * Loan Account –> Subtype of Financial Account
CREATE TABLE Loan_Account (
    Account_ID INT NOT NULL,
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
-- -- * Credit Account –> Subtype of Financial Account
CREATE TABLE Credit_Account (
    Account_ID INT NOT NULL,
    Credit_Card_Number VARCHAR(25) NOT NULL,
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
-- -- * Investment Account –> Subtype of Financial Account
CREATE TABLE Investment_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Buying_Power DECIMAL(12, 2) NOT NULL,
    Cash_Balance DECIMAL(12, 2) NOT NULL,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Investment_Value DECIMAL(12, 2) NOT NULL,
    Total_Dividends_Earned DECIMAL(12, 2) NOT NULL,
    Total_Interest_Earned DECIMAL(12, 2) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Investment_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID) 
);
-- -------------------------------------------------------------
-- -- * Digital Asset Account –> Subtype of Financial Account
CREATE TABLE Digital_Asset_Account (
    Account_ID INT NOT NULL,
    Digital_Account_Type VARCHAR(50) NOT NULL,
    Wallet_Address VARCHAR(100) UNIQUE NOT NULL,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Digital_Assets_Value DECIMAL(12, 2) NOT NULL,
    Total_Dividends_Earned DECIMAL(12, 2) NOT NULL,
    Total_Interest_Earned DECIMAL(12, 2) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Digital_Asset_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Digital FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- -------------------------------------------------------------
-- ? Insert && Select Statements
-- -------------------------------------------------------------

-- -- * Financial Account Insert Statement
INSERT INTO Financial_Account (User_ID, Institution_Name, Account_Type, Account_Name, Account_Number, Account_Balance, Date_Account_Opened)
VALUES
(1, 'Wells Fargo', 'Bank', 'Primary Checking', '111122223333', 2500.00, '2023-01-01'),
(2, 'Chase Bank', 'Bank', 'Savings Account', '444455556666', 4500.00, '2022-11-10'),
(3, 'Robinhood', 'Investment', 'Brokerage', 'RH77889900', 10000.00, '2023-03-05'),
(4, 'BlockFi', 'Digital Asset', 'Crypto Wallet', 'BFCrypto001', 3200.00, '2023-02-15'),
(5, 'Navy Federal', 'Credit', 'Visa Signature', '998877665544', 1200.00, '2023-05-20'),
(1, 'SoFi', 'Loan', 'Student Loan', 'SL12345678', 15000.00, '2021-09-01'),
(2, 'Bank of America', 'Bank', 'Primary Checking', '222233334444', 3000.00, '2023-04-01'),
(2, 'Coinbase', 'Digital Asset', 'Crypto Wallet', 'COIN12345678', 5000.00, '2023-06-10'),
(4, 'Fidelity', 'Investment', 'Retirement Account', 'FID98765432', 20000.00, '2023-07-15'),
(5, 'American Express', 'Credit', 'Gold Card', 'AMEX55556666', 8000.00, '2023-08-20'),
(3, 'Chase Bank', 'Loan', 'Auto Loan', 'AL12345678', 20000.00, '2022-10-01'),
(4, 'TD Ameritrade', 'Investment', 'Brokerage Account', 'TDA12345678', 15000.00, '2023-10-01'),
(5, 'PayPal', 'Digital Asset', 'Crypto Wallet', 'PAYPAL12345678', 3000.00, '2023-11-01');
Select * from Financial_Account;
-- -------------------------------------------------------------
-- -- -- * Bank Account Insert Statement
INSERT INTO Bank_Account (Account_ID, Routing_Number, APY)
VALUES
(1, '123456789', 0.05),
(2, '987654321', 0.03),
(12, '456789123', 0.04);
Select * from Bank_Account;
-- -------------------------------------------------------------
-- -- -- * Loan Account Insert Statement
INSERT INTO Loan_Account (Account_ID, Loan_Amount, Loan_Term, Interest_Rate, Exp_Monthly_Payment, Start_Date, Exp_End_Date)
VALUES
(1, 15000.00, 120, 5.25, 160.00, '2021-09-01', '2031-09-01'),
(2, 20000.00, 60, 4.75, 400.00, '2022-10-01', '2027-10-01');
Select * from Loan_Account;
-- -------------------------------------------------------------
-- -- -- * Financial --> Credit Account Insert Statement
INSERT INTO Credit_Account (Account_ID, Credit_Card_Number, Credit_Limit, Interest_Rate, Billing_Cycle_Due_Date, Card_Expiration_Date)
VALUES
(5, '4111111111111111', 5000.00, 18.99, '2024-05-10', '2027-05'),
(10, '5500000000000004', 10000.00, 15.99, '2024-06-15', '2026-06');
Select * from Credit_Account;
-- -------------------------------------------------------------
-- -- -- * Investment Account Insert Statement
INSERT INTO Investment_Account (Account_ID, Buying_Power, Cash_Balance, Total_User_Contribution, Total_Investment_Value, Total_Dividends_Earned, Total_Interest_Earned)
VALUES
(3, 5000.00, 1500.00, 8000.00, 10250.00, 120.50, 45.25),
(9, 20000.00, 7000.00, 13000.00, 25000.00, 400.00, 200.00),
(12, 15000.00, 5000.00, 10000.00, 20000.00, 300.00, 150.00);
SELECT * FROM Investment_Account;
-- -------------------------------------------------------------
-- -- * Digital Asset Account Insert Statement
INSERT INTO Digital_Asset_Account (Account_ID, Digital_Account_Type, Wallet_Address, Total_User_Contribution, Total_Digital_Assets_Value, Total_Dividends_Earned, Total_Interest_Earned)
VALUES 
(4, 'Crypto Wallet', '0xA1B2C3D4E5F6G7H8I9J0', 3200.00, 4100.00, 85.00, 22.50),
(8, 'Crypto Wallet', '0xB1C2D3E4F5G6H7I8J9K0', 5000.00, 6000.00, 150.00, 30.00),
(13, 'Hardware Wallet', '0xC1D2E3F4G5H6I7J8K9L0', 7000.00, 8000.00, 200.00, 40.00);
SELECT * FROM Digital_Asset_Account;
-- -------------------------------------------------------------
-- ? Select Statement
-- -------------------------------------------------------------
-- -- * Select All Financial Accounts
SELECT * FROM Financial_Account;
SELECT * FROM Bank_Account;
SELECT * FROM Loan_Account;
SELECT * FROM Credit_Account;
SELECT * FROM Investment_Account;
SELECT * FROM Digital_Asset_Account;
-- -- -------------------------------------------------------------
-- -- * Select All Financial Accounts with User Data
SELECT fa.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, fa.Account_Balance, fa.Date_Account_Opened
FROM Financial_Account fa
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------
-- -- * Select All Bank Accounts with User Data
SELECT ba.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, ba.Routing_Number, fa.Account_Balance, ba.APY, fa.Date_Account_Opened
FROM Bank_Account ba
    JOIN Financial_Account fa ON ba.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------
-- -- * Select All Loan Accounts with User Data
SELECT la.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, la.Loan_Amount, la.Loan_Term, la.Interest_Rate, la.Exp_Monthly_Payment, la.Start_Date, la.Exp_End_Date, fa.Account_Balance, fa.Date_Account_Opened
FROM Loan_Account la
    JOIN Financial_Account fa ON la.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------
-- -- * Select All Credit Accounts with User Data
SELECT ca.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, ca.Credit_Card_Number, ca.Credit_Limit, ca.Interest_Rate, ca.Billing_Cycle_Due_Date, ca.Card_Expiration_Date, fa.Account_Balance, fa.Date_Account_Opened
FROM Credit_Account ca
    JOIN Financial_Account fa ON ca.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------
-- -- * Select All Investment Accounts with User Data
SELECT ia.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, ia.Buying_Power, ia.Cash_Balance, ia.Total_User_Contribution, ia.Total_Investment_Value, ia.Total_Dividends_Earned, ia.Total_Interest_Earned, fa.Account_Balance, fa.Date_Account_Opened
FROM Investment_Account ia
    JOIN Financial_Account fa ON ia.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------
-- -- * Select All Digital Asset Accounts with User Data
SELECT da.Account_ID, fa.User_ID, u.Full_Name, u.Email, u.Phone_Number, fa.Institution_Name, fa.Account_Type, fa.Account_Name, fa.Account_Number, da.Digital_Account_Type, da.Wallet_Address, da.Total_User_Contribution, da.Total_Digital_Assets_Value, da.Total_Dividends_Earned, da.Total_Interest_Earned, fa.Account_Balance, fa.Date_Account_Opened
FROM Digital_Asset_Account da
    JOIN Financial_Account fa ON da.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
ORDER BY u.Full_Name ASC, fa.Institution_Name ASC;
-- -- -------------------------------------------------------------



-- * Insert business financial accounts
INSERT INTO Financial_Account (Account_ID, User_ID, Institution_Name, Account_Type, Account_Name, Account_Number, Account_Balance, Date_Account_Opened)
VALUES 
(14, 3, 'Wells Fargo', 'Bank', 'Business Checking', '133126623393', 5000.00, '2023-01-01'),
(15, 2, 'Chase Bank', 'Bank', 'Business Savings', '456457856966', 10000.00, '2022-11-10'),
(16, 3, 'Robinhood', 'Investment', 'Business Brokerage', 'RH76989900', 20000.00, '2023-03-05'),
(17, 1, 'BlockFi', 'Digital Asset', 'Business Crypto Wallet', 'BFCrypto173', 15000.00, '2023-02-15'),
(18, 1, 'Navy Federal', 'Credit', 'Business Visa Signature', '998277665544', 8000.00, '2023-05-20'),
(19, 2, 'SoFi', 'Loan', 'Business Start Up Loan', 'SL12345679', 25000.00, '2021-09-01');
SELECT * FROM Financial_Account;

-- -------------------------------------------------------------

-- -- * Business Bank Account Insert Statement
INSERT INTO Bank_Account (Account_ID, Routing_Number, APY)
VALUES
(14, '173456789', 0.05),
(15, '827654321', 0.03);  
Select * from Bank_Account;
-- -------------------------------------------------------------
-- -- * Business Loan Account Insert Statement
INSERT INTO Loan_Account (Account_ID, Loan_Amount, Loan_Term, Interest_Rate, Exp_Monthly_Payment, Start_Date, Exp_End_Date)
VALUES
(1, 50000.00, 120, 5.25, 550.00, '2023-01-01', '2033-01-01'),
(2, 100000.00, 60, 4.75, 2000.00, '2022-10-01', '2027-10-01');

-- Example: Insert 1 business INvestment account data
INSERT INTO Investment_Account (Account_ID, Buying_Power, Cash_Balance, Total_User_Contribution, Total_Investment_Value, Total_Dividends_Earned, Total_Interest_Earned)
VALUES
(16, 10000.00, 5000.00, 8000.00, 12000.00, 200.00, 100.00);
SELECT * FROM Investment_Account;

-- -------------------------------------------------------------
-- -- * Business 1 Digital Asset Account Insert Statement

INSERT INTO Digital_Asset_Account (Account_ID, Digital_Account_Type, Wallet_Address, Total_User_Contribution, Total_Digital_Assets_Value, Total_Dividends_Earned, Total_Interest_Earned)
VALUES 
(17, 'Business Crypto Wallet', '0xA1B2C3D4E5F6G7H8I9J0', 15000.00, 20000.00, 300.00, 50.00);
SELECT * FROM Digital_Asset_Account;
-- -------------------------------------------------------------
-- -- * Business 1 Credit Account Insert Statement
INSERT INTO Credit_Account (Account_ID, Credit_Card_Number, Credit_Limit, Interest_Rate, Billing_Cycle_Due_Date, Card_Expiration_Date)  
VALUES
(18, '4111111111111111', 10000.00, 18.99, '2024-05-10', '2027-05');
SELECT * FROM Credit_Account;


