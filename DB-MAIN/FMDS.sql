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


-- ------------------------------------------------------------
-- USER – Strong Entity
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
    SSN VARCHAR(11) NULL,
    User_Type VARCHAR(20),
    CONSTRAINT PK_User PRIMARY KEY (User_ID)
);

-- ------------------------------------------------------------
-- BUSINESS_USER – Weak Entity
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
    Start_Of_Business DATE NOT NULL,
    Business_Phone VARCHAR(15),
    Business_Email VARCHAR(100),
    Age_Of_Business INT,
    CONSTRAINT PK_Business_User PRIMARY KEY (Business_ID),
    CONSTRAINT FK_User_Business FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);


-- ------------------------------------------------------------
-- CREDIT_REPORT – Strong Entity
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