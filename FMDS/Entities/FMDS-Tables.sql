-- !  FMDS Tables 
-- MAKE YOU ARE IN THE FMDS DATABASE
-- -- ------------------------------------------------------------
USE FMDS;

-- ? USER – Strong Entity
CREATE TABLE User (
    User_ID INT NOT NULL AUTO_INCREMENT,
    User_Type VARCHAR(20) NOT NULL CHECK (User_Type IN ('personal', 'business')),
    Date_Of_Birth DATE NOT NULL,
    SSN VARCHAR(11) UNIQUE NULL,
    Full_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone_Number VARCHAR(15) NOT NULL,
    Address_Line_1 VARCHAR(100) NOT NULL,
    Address_Line_2 VARCHAR(100),
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State CHAR(2) NOT NULL,
    Zip_Code VARCHAR(10) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    CONSTRAINT PK_User PRIMARY KEY (User_ID)
);

-- ? BUSINESS_USER – Weak Entity
CREATE TABLE Business_User (
    Business_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    EIN VARCHAR(15) UNIQUE NOT NULL,
    Business_Name VARCHAR(100) NOT NULL,
    Business_Founded_Date DATE NOT NULL,
    Business_Phone VARCHAR(15),
    Business_Email VARCHAR(100),
    Age_Of_Business INT,
    CONSTRAINT PK_Business_User PRIMARY KEY (Business_ID),
    CONSTRAINT FK_User_Business FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

-- ? CREDIT_REPORT – Strong Entity
CREATE TABLE Credit_Report (
      Credit_Report_ID INT NOT NULL AUTO_INCREMENT,
      User_ID INT NOT NULL,
      Credit_Bureau_Name VARCHAR(50) NOT NULL CHECK (Credit_Bureau_Name IN ('Equifax', 'Experian', 'TransUnion')),
      Credit_Score INT NOT NULL CHECK (Credit_Score BETWEEN 300 AND 850),
      Report_Date DATE NOT NULL,
      Credit_Description TEXT,
      CONSTRAINT PK_Credit_Report PRIMARY KEY (Credit_Report_ID),
      CONSTRAINT FK_User_Credit FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

-- ? FINANCIAL_ACCOUNT – Strong Entity
CREATE TABLE Financial_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Institution_Name VARCHAR(100) NOT NULL,
    Account_Type VARCHAR(30) NOT NULL CHECK (Account_Type IN ('Bank', 'Loan', 'Investment', 'Digital Asset', 'Credit')),
    Account_Name VARCHAR(100) NOT NULL,
    Account_Number VARCHAR(30) NOT NULL,
    Account_Balance DECIMAL(12, 2) NOT NULL,
    Date_Account_Opened DATE NOT NULL,
    CONSTRAINT PK_Financial_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_User_Account FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

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
    CONSTRAINT PK_Tax_Report PRIMARY KEY (Tax_Report_ID),
    CONSTRAINT FK_User_Tax FOREIGN KEY (User_ID) REFERENCES User(User_ID),
    CONSTRAINT FK_Transaction_Tax FOREIGN KEY (Transaction_ID) REFERENCES Transaction(Transaction_ID)
);

-- ? Bank_Account – Weak Entity
CREATE TABLE Bank_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Routing_Number CHAR(9) NOT NULL,
    APY DECIMAL(5, 2),
    CONSTRAINT PK_Bank_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Bank FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);

-- ? Loan_Account – Weak Entity
CREATE TABLE Loan_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Loan_Type VARCHAR(50) NOT NULL,
    Loan_Amount DECIMAL(12, 2) NOT NULL,
    Loan_Term INT NOT NULL,
    Interest_Rate DECIMAL(5, 2) NOT NULL,
    Exp_Monthly_Payment DECIMAL(10, 2) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    Remaining_Balance DECIMAL(12, 2) NOT NULL,
    CONSTRAINT PK_Loan_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Loan FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);

-- ? Credit_Account – Weak Entity
CREATE TABLE Credit_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Credit_Type VARCHAR(30) NOT NULL,
    Credit_Card_Number VARCHAR(25) NOT NULL,
    Credit_Limit DECIMAL(12, 2) NOT NULL,
    Interest_Rate DECIMAL(5, 2) NOT NULL,
    Billing_Cycle_Due_Date DATE NOT NULL,
    Card_Expiration_Date CHAR(7) NOT NULL,
    Remaining_Balance DECIMAL(12, 2) NOT NULL,
    CONSTRAINT PK_Credit_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Credit FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);

-- ? Investment_Account – Weak Entity
CREATE TABLE Investment_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Investment_Account_Type VARCHAR(50) NOT NULL,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Holdings_Amount DECIMAL(12, 2) NOT NULL,
    CONSTRAINT PK_Investment_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);

-- ? Investment_Holding – Entity
CREATE TABLE Investment_Holding (
    Holdings_ID INT NOT NULL AUTO_INCREMENT,
    Account_ID INT NOT NULL,
    Investment_Type VARCHAR(30) NOT NULL,
    Investment_Symbol VARCHAR(15) NOT NULL,
    Total_Quantity DECIMAL(12, 4) NOT NULL,
    Total_Purchase_Price DECIMAL(14, 2) NOT NULL,
    Average_Price_Per_Share DECIMAL(12, 4) NOT NULL,
    Current_Price DECIMAL(12, 4) NOT NULL,
    Total_Value DECIMAL(14, 2) NOT NULL,
    Unrealized_Gain_Or_Loss DECIMAL(14, 2),
    Realized_Gain_Or_Loss DECIMAL(14, 2),
    Date_Opened DATE NOT NULL,
    Holding_Status VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Investment_Holding PRIMARY KEY (Holdings_ID),
    CONSTRAINT FK_Account_Holding FOREIGN KEY (Account_ID) REFERENCES Investment_Account(Account_ID)
);

-- ? Investment_Asset – Weak Entity
CREATE TABLE Investment_Asset (
    Action_ID INT NOT NULL AUTO_INCREMENT,
    Holdings_ID INT NOT NULL,
    Account_ID INT NOT NULL,
    Action_Type VARCHAR(20) NOT NULL,
    Symbol VARCHAR(15) NOT NULL,
    Quantity DECIMAL(12, 4) NOT NULL,
    Price_Per_Share DECIMAL(12, 4) NOT NULL,
    Total_Price DECIMAL(14, 2) NOT NULL,
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Broker_Fee DECIMAL(10, 2),
    Optional_Note TEXT,
    CONSTRAINT PK_Investment_Asset PRIMARY KEY (Action_ID),
    CONSTRAINT FK_Holdings_Investment FOREIGN KEY (Holdings_ID) REFERENCES Investment_Holding(Holdings_ID),
    CONSTRAINT FK_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Investment_Account(Account_ID)
);

-- ? Digital_Asset_Account – Weak Entity
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

-- ? Digital_Asset_Holding – Entity
CREATE TABLE Digital_Asset_Holding
(
    Holding_ID INT NOT NULL AUTO_INCREMENT,
    Account_ID INT NOT NULL,
    Digital_Asset_Type VARCHAR(30) NOT NULL,
    Asset_Symbol VARCHAR(15) NOT NULL,
    Total_Quantity DECIMAL(18, 8) NOT NULL,
    Total_Purchase_Price DECIMAL(20, 2) NOT NULL,
    Average_Price_Per_Share DECIMAL(18, 8) NOT NULL,
    Current_Price DECIMAL(18, 8) NOT NULL,
    Total_Value DECIMAL(20, 2) NOT NULL,
    Unrealized_Gain_Or_Loss DECIMAL(20, 2),
    Realized_Gain_Or_Loss DECIMAL(20, 2),
    Date_Opened DATE NOT NULL,
    Holding_Status VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Digital_Asset_Holding PRIMARY KEY (Holding_ID),
    CONSTRAINT FK_Account_Digital_Holding FOREIGN KEY (Account_ID) REFERENCES Digital_Asset_Account(Account_ID)
);

-- ? Digital_Asset – Weak Entity
CREATE TABLE Digital_Asset (
    Action_ID INT NOT NULL AUTO_INCREMENT,
    Holding_ID INT NOT NULL,
    Account_ID INT NOT NULL,
    Action_Type VARCHAR(20) NOT NULL,
    Asset_Symbol VARCHAR(15) NOT NULL,
    Quantity DECIMAL(18, 8) NOT NULL,
    Price_Per_Token DECIMAL(18, 8) NOT NULL,
    Total_Price DECIMAL(20, 2) NOT NULL,
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Transaction_Fee DECIMAL(10, 2),
    Gas_Fee DECIMAL(10, 2),
    Optional_Note TEXT,
    CONSTRAINT PK_Digital_Asset PRIMARY KEY (Action_ID),
    CONSTRAINT FK_Holding_Digital FOREIGN KEY (Holding_ID) REFERENCES Digital_Asset_Holding(Holding_ID),
    CONSTRAINT FK_Account_Digital FOREIGN KEY (Account_ID) REFERENCES Digital_Asset_Account(Account_ID)
);