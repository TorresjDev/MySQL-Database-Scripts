-- ------------------------------------------------------------
-- ? FINANCE MANAGEMENT DATABASE SYSTEM (FMDS)
-- ------------------------------------------------------------
-- FMDS is designed to help users manage all personal and business
-- financial data in one place. It tracks accounts, transactions,
-- investments, digital assets, taxes, and credit reports.
-- 
-- The goal is to organize and monitor daily financial activity,
-- calculate performance, and support smart financial decisions
-- through real-time tracking and structured reporting.
-- ------------------------------------------------------------


-- ------------------------------------------------------------
-- TODO: SECTION 1: CREATE THE DATABASE 
-- ------------------------------------------------------------
-- This creates the FMDS database to store all financial entities.
CREATE DATABASE FMDS;
USE FMDS; 


-- ------------------------------------------------------------
-- TODO: SECTION 2: CREATE THE TABLES
-- ------------------------------------------------------------
-- Each table represents a major part of the financial system.
-- Strong and weak entities follow the structure in Deliverable II.
-- All foreign key constraints are applied during table creation.

-- #region 1: User
-- ------------------------------------------------------------
-- ! USER – Strong Entity
-- ------------------------------------------------------------
-- Represents the main FMDS user managing personal finances.
-- Optional features may include credit reports, tax reports, or business profiles.

-- Required Attributes:
-- - User_ID: INT, CONSTRAINT Primary Key, unique system identifier (surrogate key)
-- - Full_Name: VARCHAR(100), atomic full name value (avoid composite)
-- - Email: VARCHAR(100), must be unique for communication/login but user can have multiple emails but only one primary
-- - Phone_Number: VARCHAR(15), can have multiple numbers, but only one primary
-- - Date_Of_Birth: DATE, used for validation or age-based logic

-- Address Attributes (Composite split into atomic fields):
-- - Street: VARCHAR(100)
-- - City: VARCHAR(50)
-- - State: CHAR(2), two-letter standard format
-- - Zip_Code: VARCHAR(10), ZIP or ZIP+4 support

-- Optional Attributes:
-- - SSN: VARCHAR(11), optional for credit/tax modules, NOT PK
-- - User_Type: VARCHAR(20), optional flag (e.g., 'personal', 'business')

-- Design Notes:
-- • Address must be broken into 4 fields (street, city, state, zip) for filtering and sorting.
-- • SSN is optional and nullable; enforce formatting with domain rules if needed.
-- • No multi-valued attributes, no derived attributes — everything should be atomic.
-- • Follow 1NF–3NF to reduce anomalies and ensure flexibility for future subtype additions.
-- • Avoid storing grouped values like {First, Last} in one field — atomic structure only.
-- ------------------------------------------------------------

CREATE TABLE User (
    User_ID INT NOT NULL AUTO_INCREMENT,
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
    Date_Of_Birth DATE NOT NULL,
    SSN VARCHAR(11) UNIQUE NULL,
    User_Type VARCHAR(20) NOT NULL CHECK (User_Type IN ('personal', 'business')),
    CONSTRAINT PK_User PRIMARY KEY (User_ID)
);

-- #endregion 1: User

-- #region 2: Business_User
-- ------------------------------------------------------------
-- ! BUSINESS_USER – Weak Entity
-- ------------------------------------------------------------
-- Represents an optional business profile created and owned by a personal user.
-- Used for tracking business-related finances, accounts, and investments.

-- Attributes:
-- - Business_ID: INT, surrogate PK (system-generated)
-- - User_ID: INT, FK linking to User entity (required for weak entity)
-- - EIN: VARCHAR(15), required federal tax ID (non-PK, but must be unique per user)
-- - Business_Name: VARCHAR(100), required
-- - Start_Of_Business: DATE, date the business was founded
-- - Business_Phone: VARCHAR(15), optional, digits only
-- - Business_Email: VARCHAR(100), optional
-- - Age_Of_Business: INT, optional calculated field (can be derived from start date)

-- Design Notes:
-- • Business_User must link to one User (1:M relationship)
-- • Use a surrogate Business_ID as the PK instead of composite (EIN + User_ID)
-- • EIN must still be unique within a user's context but is not used as the primary key
-- • Age_Of_Business should be excluded from final table if calculated dynamically in views
-- • Avoid curly braces in SQL — store atomic values only
-- • Store optional fields like phone and email as nullable
-- ------------------------------------------------------------

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

-- #endregion 2: Business_User

-- #region 3: Credit_Report
-- ------------------------------------------------------------
-- ! CREDIT_REPORT – Strong Entity
-- ------------------------------------------------------------
-- Tracks a user's credit score history if the user enables credit monitoring.
-- This entity is optional and requires a valid SSN stored in the User profile.

-- Attributes:
-- - Credit_Report_ID: INT, surrogate primary key (auto-generated)
-- - User_ID: INT, foreign key referencing User(User_ID)
-- - Credit_Bureau_Name: VARCHAR(50), name of reporting bureau (e.g., Equifax)
-- - Credit_Score: INT, numeric score (typically 300–850 range)
-- - Report_Date: DATE, when the score was retrieved
-- - Credit_Description: TEXT, optional summary or remark on credit status

-- Design Notes:
-- • A user can have multiple credit reports over time (1:M)
-- • Credit_Report is optional; do not enforce FK if SSN is null
-- • SSN is stored in the User table and must be required before enabling this feature
-- • Credit_Bureau_Name should use a domain constraint if limited to known values
-- • Avoid duplicate entries per user + report date + bureau
-- ------------------------------------------------------------

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
-- #endregion 3: Credit_Report

-- #region 4: Tax_Report
-- ------------------------------------------------------------
-- ! TAX_REPORT – Strong Entity (User-Facing Tax Insights)
-- ------------------------------------------------------------
-- Tracks potential taxable activity based on user transactions.
-- This entity does NOT file with the IRS. It helps users identify
-- financial events that may require tax reporting, such as capital gains.
-- Requires SSN to enable. Optional inputs like spouse income and
-- number of dependents improve accuracy for user-facing insights.

-- Attributes:
-- - Tax_Report_ID: INT, surrogate primary key (auto-increment)
-- - User_ID: INT, FK to User(User_ID)
-- - Transaction_ID: INT, FK to Transaction(Transaction_ID)
-- - Tax_Year: YEAR, fiscal year the transaction occurred
-- - Filing_Status: VARCHAR(30), e.g., 'Single', 'Married Filing Jointly', etc.
-- - Tax_Category: VARCHAR(50), e.g., 'Capital Gains', 'Dividend', 'Crypto'
-- - Taxable_Amount: DECIMAL(10, 2), estimated exposure (manually entered or calculated)
-- - Identified_Timestamp: DATETIME, when FMDS flagged the activity
-- - Spouse_Income: DECIMAL(10, 2), optional, for joint filers
-- - Num_Dependents: INT, optional
-- - Notes: TEXT, optional description or context for the user

-- Design Notes:
-- • Filing_Status can be restricted using a CHECK constraint or ENUM values
-- • SSN is stored in User and must be present to activate tax features
-- • Identified_Timestamp is internal – NOT a filing date
-- • Taxable_Amount is NOT official – used only for user-facing analysis
-- • This structure supports future automation (e.g., IRS exports or summaries)
-- ------------------------------------------------------------

CREATE TABLE Tax_Report (
    Tax_Report_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Transaction_ID INT NOT NULL,
    Tax_Year YEAR NOT NULL,
    Filing_Status VARCHAR(30) CHECK (Filing_Status IN ('Single', 'Married Filing Jointly', 'Married Filing Separately', 'Head of Household', 'Qualifying Widow(er)')),
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

-- #endregion 4: Tax_Report

-- #region 5: Transaction
-- ------------------------------------------------------------
-- TRANSACTION – Strong Entity
-- ------------------------------------------------------------
-- Represents any financial activity made through a user's account,
-- such as deposits, withdrawals, transfers, purchases, or income.
-- Each transaction is categorized by type and may optionally link
-- to a tax report if flagged as taxable.

-- Attributes:
-- - Transaction_ID: INT, primary key (auto-incremented)
-- - Account_ID: INT, foreign key to Financial_Account(Account_ID)
-- - Transaction_Type: VARCHAR(30), e.g., 'Deposit', 'Withdrawal', 'Purchase'
-- - Amount: DECIMAL(10, 2), total amount involved in the transaction
-- - Transaction_Timestamp: DATETIME, exact time the transaction occurred
-- - Payment_Method: VARCHAR(50), e.g., 'ACH', 'Credit Card', 'Cash'
-- - Payment_Category: VARCHAR(50), e.g., 'Groceries', 'Utilities', 'Salary'
-- - Description: TEXT, optional note describing the purpose or context

-- Design Notes:
-- • Each transaction must be linked to one financial account (1:M)
-- • Transaction_Type should be controlled with CHECK or ENUM for consistency
-- • Timestamp is required for chronological sorting and reporting
-- • A transaction may optionally link to one tax report (via FK on Tax_Report)
-- • Avoid derived fields like "balance after transaction" — calculate in views
-- • Keep all values atomic and avoid multi-value storage in any field
-- ------------------------------------------------------------

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
-- #endregion 5: Transaction

-- #region 6: Financial_Account
-- ------------------------------------------------------------
-- ! FINANCIAL_ACCOUNT – Strong Entity
-- ------------------------------------------------------------
-- Represents all forms of financial accounts owned by the user.
-- Supports core account tracking across banking, investing, digital assets,
-- loans, and credit accounts. Subtypes expand account-specific attributes.

-- Attributes:
-- - Account_ID: INT, surrogate primary key (auto-incremented)
-- - User_ID: INT, FK to User(User_ID)
-- - Institution_Name: VARCHAR(100), name of bank, exchange, or issuer
-- - Account_Type: VARCHAR(30), general category (e.g., 'Bank', 'Loan', 'Investment')
-- - Account_Name: VARCHAR(100), name on account or nickname
-- - Account_Number: VARCHAR(30), masked or full account number (user-facing)
-- - Account_Balance: DECIMAL(12, 2), current balance tracked
-- - Date_Account_Opened: DATE, when the account was created or linked

-- Design Notes:
-- • Every account must belong to one User (1:M relationship)
-- • Account_Type is general; subtype-specific tables store additional fields
-- • Subtype tables: Bank_Account, Investment_Account, Digital_Asset_Account, Loan_Account, Credit_Account
-- • Subtypes linked via FK to Account_ID (1:1 extension pattern)
-- • Avoid repeating account-specific fields here — push them to subtype tables
-- • Use VARCHAR or ENUM to restrict Account_Type domain
-- • Each account links to many transactions, holdings, or assets (1:M)
-- ------------------------------------------------------------

CREATE TABLE Fincancial_Account (
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


-- #endregion 6: Financial_Account

-- #region 7: Credit_Account
-- ------------------------------------------------------------
-- ! CREDIT_ACCOUNT – Subtype of Financial_Account
-- ------------------------------------------------------------
-- Stores credit-specific details linked to a financial account.
-- Includes credit limits, interest rates, billing cycles, and balance tracking.

-- Attributes:
-- - Account_ID: INT, primary key & FK to Financial_Account(Account_ID)
-- - Credit_Type: VARCHAR(30), e.g., 'Personal Credit', 'Business Credit', 'Retail'
-- - Credit_Card_Number: VARCHAR(25), full or masked number (user display only)
-- - Credit_Limit: DECIMAL(12, 2), max amount allowed to borrow
-- - Interest_Rate: DECIMAL(5, 2), annual percentage rate (APR)
-- - Billing_Cycle_Due_Date: DATE, when payment is due
-- - Card_Expiration_Date: CHAR(7), stored as 'MM/YYYY'
-- - Remaining_Balance: DECIMAL(12, 2), unpaid balance as of latest sync

-- Design Notes:
-- • One-to-one relationship with Financial_Account (Account_ID = PK & FK)
-- • Remaining_Balance is stored — optionally update via trigger or calculation
-- • Expiration date stored as CHAR to preserve 'MM/YYYY' format (not full DATE)
-- • Credit_Type can be restricted using CHECK or ENUM constraints
-- • Masked card numbers are fine for storage (e.g., '**** **** **** 1234')
-- ------------------------------------------------------------

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


-- #endregion 7: Credit_Account

-- #region 8: Bank_Account
-- ------------------------------------------------------------
-- ! BANK_ACCOUNT – Subtype of Financial_Account
-- ------------------------------------------------------------
-- Stores bank-specific fields for standard checking or savings accounts.
-- Includes routing details and interest earnings from APY.

-- Attributes:
-- - Account_ID: INT, primary key & FK to Financial_Account(Account_ID)
-- - Routing_Number: CHAR(9), 9-digit bank routing number (US standard)
-- - APY: DECIMAL(5, 2), annual percentage yield (e.g., 1.25 for 1.25%)

-- Design Notes:
-- • Account_ID connects 1:1 with Financial_Account
-- • Routing_Number should be CHAR(9) with input validation logic
-- • APY reflects yield — optional but useful for reporting and comparison
-- • Only use this subtype when Account_Type = 'Bank'
-- • Use CHECK or ENUM constraints if you track bank account types separately
-- ------------------------------------------------------------

CREATE TABLE Bank_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Routing_Number CHAR(9) NOT NULL,
    APY DECIMAL(5, 2),
    CONSTRAINT PK_Bank_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Bank FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);




-- #endregion 8: Bank_Account

-- #region 9: Loan_Account
-- ------------------------------------------------------------
-- ! LOAN_ACCOUNT – Subtype of Financial_Account
-- ------------------------------------------------------------
-- Stores loan-specific data for tracking long-term borrowing accounts,
-- such as mortgages, auto loans, personal loans, or business financing.

-- Attributes:
-- - Account_ID: INT, primary key & FK to Financial_Account(Account_ID)
-- - Loan_Type: VARCHAR(50), e.g., 'Auto', 'Mortgage', 'Student Loan', etc.
-- - Loan_Amount: DECIMAL(12, 2), original total borrowed amount
-- - Loan_Term: INT, total loan duration in months (e.g., 60 for 5 years)
-- - Interest_Rate: DECIMAL(5, 2), annual percentage rate (APR)
-- - Monthly_Payment: DECIMAL(10, 2), expected monthly payment amount
-- - Start_Date: DATE, loan initiation date
-- - End_Date: DATE, expected payoff date
-- - Remaining_Balance: DECIMAL(12, 2), current unpaid balance

-- Design Notes:
-- • Loan_Account is linked 1:1 with Financial_Account
-- • Remaining_Balance can be calculated dynamically, or stored and updated manually
-- • Use Loan_Term in months for better calculation precision
-- • End_Date should align with expected payoff — not derived unless automation is added
-- • This model supports future analytics like payment tracking and amortization
-- ------------------------------------------------------------

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

-- #endregion 9: Loan_Account

-- #region 10: Investment_Account
-- ------------------------------------------------------------
-- ! INVESTMENT_ACCOUNT – Subtype of Financial_Account
-- ------------------------------------------------------------
-- Tracks investment-related financial accounts, including user
-- contributions and total portfolio value across all holdings.

-- Attributes:
-- - Account_ID: INT, primary key & FK to Financial_Account(Account_ID)
-- - Investment_Account_Type: VARCHAR(50), e.g., 'Brokerage', 'IRA', '401(k)', etc.
-- - Total_User_Contribution: DECIMAL(12, 2), total deposits made by user
-- - Total_Holdings_Amount: DECIMAL(12, 2), current value of all assets held

-- Design Notes:
-- • 1:1 relationship with Financial_Account — Account_ID is PK and FK
-- • Investment_Account_Type can be ENUM or constrained by CHECK logic
-- • Total_User_Contribution reflects only what the user deposited (not asset growth)
-- • Total_Holdings_Amount is the total current market value of all holdings
-- • This entity supports portfolio tracking, asset allocation, and performance reporting
-- ------------------------------------------------------------

CREATE TABLE Investment_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    Investment_Account_Type VARCHAR(50) NOT NULL,
    Total_User_Contribution DECIMAL(12, 2) NOT NULL,
    Total_Holdings_Amount DECIMAL(12, 2) NOT NULL,
    CONSTRAINT PK_Investment_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Investment FOREIGN KEY (Account_ID) REFERENCES Financial_Account(Account_ID)
);
-- #endregion 10: Investment_Account

-- #region 11: Investment_Asset
-- ------------------------------------------------------------
-- ! INVESTMENT_ASSET – Weak Entity
-- ------------------------------------------------------------
-- Tracks every investment action (buy, sell, dividend, split, etc.)
-- tied to a specific holding and investment account. Each record
-- contributes to calculating total value, quantity, and average price
-- within the associated holding.

-- Attributes:
-- - Action_ID: INT, surrogate primary key (auto-increment)
-- - Holdings_ID: INT, FK to Investment_Holdings(Holdings_ID)
-- - Account_ID: INT, FK to Investment_Account(Account_ID)
-- - Action_Type: VARCHAR(20), e.g., 'Buy', 'Sell', 'Dividend', 'Split'
-- - Symbol: VARCHAR(15), asset symbol involved in the transaction
-- - Quantity: DECIMAL(12, 4), total units involved
-- - Price_Per_Share: DECIMAL(12, 4), unit cost at transaction time
-- - Total_Price: DECIMAL(14, 2), calculated = Quantity × Price_Per_Share
-- - Timestamp: DATETIME, exact time of the trade or adjustment
-- - Broker_Fee: DECIMAL(10, 2), any applicable transaction fees
-- - Optional_Note: TEXT, remarks or transaction details

-- Design Notes:
-- • Weak entity – must be linked to both a Holding and Investment Account
-- • Action_ID can serve as the PK for easier indexing
-- • Action_Type should be constrained using ENUM or CHECK
-- • Timestamp used for historical reporting and trade tracking
-- • Total_Price may be computed or stored for query performance
-- • Holding updates (total value, avg. price) should reflect all actions
-- ------------------------------------------------------------

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
-- #endregion 11: Investment_Asset

-- #region 12: Investment_Asset_Holding
-- ------------------------------------------------------------
-- ! INVESTMENT_HOLDINGS – Strong Entity
-- ------------------------------------------------------------
-- Represents a user's collection of transactions grouped under
-- a specific investment symbol, such as a stock, ETF, or option.
-- Tracks combined performance, quantity, gains, and valuation.

-- Attributes:
-- - Holdings_ID: INT, primary key (auto-incremented)
-- - Account_ID: INT, FK to Investment_Account(Account_ID)
-- - Investment_Type: VARCHAR(30), e.g., 'Stock', 'ETF', 'Option'
-- - Investment_Symbol: VARCHAR(15), e.g., 'AAPL', 'TSLA', 'VOO'
-- - Total_Quantity: DECIMAL(12, 4), combined quantity across all actions
-- - Total_Purchase_Price: DECIMAL(14, 2), total cost basis
-- - Average_Price_Per_Share: DECIMAL(12, 4), average cost per unit
-- - Current_Price: DECIMAL(12, 4), latest market price
-- - Total_Value: DECIMAL(14, 2), current quantity × current price
-- - Unrealized_Gain_Or_Loss: DECIMAL(14, 2), gain or loss not yet sold
-- - Realized_Gain_Or_Loss: DECIMAL(14, 2), actual gain/loss from closed positions
-- - Date_Opened: DATE, when the first position under this symbol started
-- - Holding_Status: VARCHAR(20), e.g., 'Open', 'Closed', 'Partially Sold'

-- Design Notes:
-- • Each holding must belong to one Investment Account (1:M)
-- • Aggregate data like Total_Quantity and Avg_Price update after every new action
-- • Holding status helps track if the position is active or fully liquidated
-- • Strong entity, not dependent on assets — but updated based on asset activity
-- • Allows portfolio performance reporting and position tracking
-- ------------------------------------------------------------


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
-- #endregion 12: Invest_Asset_Holding

-- #region 13: Digital_Asset_Account
-- ------------------------------------------------------------
-- ! DIGITAL_ASSET_ACCOUNT – Subtype of Financial_Account
-- ------------------------------------------------------------
-- Stores details for digital asset wallets and accounts,
-- including wallet address, user contributions, and portfolio value.

-- Attributes:
-- - Account_ID: INT, primary key & FK to Financial_Account(Account_ID)
-- - Digital_Account_Type: VARCHAR(50), e.g., 'Crypto Wallet', 'NFT Vault', 'DeFi'
-- - Wallet_Address: VARCHAR(100), unique wallet identifier (e.g., public key)
-- - Total_User_Contribution: DECIMAL(12, 2), total funds user invested into wallet
-- - Total_Holdings_Amount: DECIMAL(12, 2), current estimated value of all assets held
-- - Digital_Portfolio_Value: DECIMAL(12, 2), optional — can mirror holdings or include staked yield

-- Design Notes:
-- • Linked 1:1 to Financial_Account by Account_ID
-- • Wallet_Address must be unique if public key based — may require hash checks
-- • Digital_Portfolio_Value may be calculated or stored for performance
-- • Digital_Account_Type should use a fixed domain or ENUM for consistency
-- • Useful for tracking decentralized assets alongside traditional accounts
-- ------------------------------------------------------------

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


-- #endregion 13: Digital_Asset_Account

-- #region 14: Digital_Asset
-- ------------------------------------------------------------
-- ! DIGITAL_ASSET – Weak Entity
-- ------------------------------------------------------------
-- Tracks every digital asset action (buy, sell, staking reward, interest, etc.)
-- tied to a specific digital asset holding. Each action updates the holding's
-- total quantity, average price, and current value.

-- Attributes:
-- - Action_ID: INT, surrogate primary key (auto-increment)
-- - Holding_ID: INT, FK to Digital_Asset_Holdings(Holding_ID)
-- - Account_ID: INT, FK to Digital_Asset_Account(Account_ID)
-- - Action_Type: VARCHAR(20), e.g., 'Buy', 'Sell', 'Staking Reward', 'Interest'
-- - Asset_Symbol: VARCHAR(15), e.g., 'BTC', 'ETH', 'SOL'
-- - Quantity: DECIMAL(18, 8), precise quantity of the digital asset
-- - Price_Per_Token: DECIMAL(18, 8), asset price at time of action
-- - Total_Price: DECIMAL(20, 2), quantity × price per token
-- - Timestamp: DATETIME, date and time of the asset movement
-- - Transaction_Fee: DECIMAL(10, 2), optional service fee (e.g., exchange fee)
-- - Gas_Fee: DECIMAL(10, 2), blockchain network fee (gas cost)
-- - Optional_Note: TEXT, optional remarks or extra data

-- Design Notes:
-- • Weak entity — must link to both a Holding and a Digital Asset Account
-- • Gas_Fee specifically models decentralized transaction costs (e.g., Ethereum)
-- • Quantity and Price_Per_Token use high precision to handle crypto decimals
-- • Action_Type should be standardized using CHECK or ENUM constraints
-- • Every action triggers an update to the related Digital Asset Holding totals
-- ------------------------------------------------------------

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



-- #endregion 14: Digital_Asset

-- #region 14: Digital_Asset_Holding
-- ------------------------------------------------------------
-- ! DIGITAL_ASSET_HOLDINGS – Strong Entity
-- ------------------------------------------------------------
-- Represents the total amount of a specific digital asset held
-- in a user's digital wallet. Groups together all actions related
-- to a single asset type and symbol for tracking growth and value.

-- Attributes:
-- - Holding_ID: INT, primary key (auto-incremented)
-- - Account_ID: INT, FK to Digital_Asset_Account(Account_ID)
-- - Digital_Asset_Type: VARCHAR(30), e.g., 'Crypto', 'NFT', 'DeFi Token'
-- - Asset_Symbol: VARCHAR(15), e.g., 'BTC', 'ETH', 'USDC', 'BAYC'
-- - Total_Quantity: DECIMAL(18, 8), total tokens or asset units held
-- - Total_Purchase_Price: DECIMAL(20, 2), total invested amount
-- - Average_Price_Per_Share: DECIMAL(18, 8), average buy cost
-- - Current_Price: DECIMAL(18, 8), latest market price per token/unit
-- - Total_Value: DECIMAL(20, 2), calculated = Total_Quantity × Current_Price
-- - Unrealized_Gain_Or_Loss: DECIMAL(20, 2), gain or loss not sold yet
-- - Realized_Gain_Or_Loss: DECIMAL(20, 2), finalized profit or loss
-- - Date_Opened: DATE, when user first acquired the asset
-- - Holding_Status: VARCHAR(20), e.g., 'Open', 'Closed', 'Partial'

-- Design Notes:
-- • Each holding belongs to one Digital Asset Account (1:M relationship)
-- • Holdings track total asset amount, market value, and gain/loss history
-- • Strong entity, aggregates actions from the Digital_Asset table
-- • Holding status identifies active vs sold-off holdings
-- • Supports digital asset portfolio reporting and analytics
-- ------------------------------------------------------------

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



-- #endregion 14: Digital_Asset_Holding






-- ------------------------------------------------------------
-- TODO: SECTION 3: INSERT SAMPLE DATA
-- ------------------------------------------------------------
-- Add sample data to test relationships, queries, and joins.
-- Populate key tables first (User, Financial Account) before dependencies.

-- [Insert sample INSERT INTO statements here]


-- ------------------------------------------------------------
-- TODO: SECTION 4: SELECT QUERIES
-- ------------------------------------------------------------
-- Run meaningful SELECT queries across one or more tables.
-- Must include aggregate functions and multi-table joins.

-- [Insert SELECT statements here]


-- ------------------------------------------------------------
-- TODO: SECTION 5: SCHEMA CHECK
-- ------------------------------------------------------------
-- Use DESC and SELECT statements to verify schema and data.

-- Example:
-- DESC User;
-- SELECT * FROM User;