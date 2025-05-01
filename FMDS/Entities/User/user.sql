-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? USERS
-- ---------------------------------------------------------
-- -- * User - Supertype
CREATE TABLE User (
    User_ID INT NOT NULL AUTO_INCREMENT,
    Full_Name VARCHAR(100) NOT NULL,
    Date_Of_Birth DATE NOT NULL,
    SSN CHAR(11) UNIQUE NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone_Number VARCHAR(15) NOT NULL,
    Address_Line_1 VARCHAR(100) NOT NULL,
    Address_Line_2 VARCHAR(100),
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State CHAR(2) NOT NULL,
    Zip_Code VARCHAR(10) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Has_Business BOOLEAN DEFAULT FALSE,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_User PRIMARY KEY (User_ID)
) Comment="Personal User Entity";
-- -------------------------------------------------------------
-- -- * Business_User - Subtype of User
CREATE TABLE Business_User (
    Business_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    EIN VARCHAR(15) UNIQUE NOT NULL,
    Business_Name VARCHAR(100) NOT NULL,
    Start_Of_Business DATE NOT NULL,
    Business_Phone VARCHAR(15),
    Business_Email VARCHAR(100),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Business_User PRIMARY KEY (Business_ID),
    CONSTRAINT FK_User_Business FOREIGN KEY (User_ID) REFERENCES User(User_ID)
) Comment="Business User Entity";
-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- ? Insert Statements
-- -------------------------------------------------------------
-- -- * User Insert Statement w/no SSN && no Business
INSERT INTO User (Full_Name, Date_Of_Birth, Email, Phone_Number, Address_Line_1, Address_Line_2, Street, City, State, Zip_Code, Country)
VALUES
('Alice Johnson', '1995-02-20', 'alice.johnson@gmail.com', '555-123-4567', '123', NULL, 'Main St', 'New York', 'NY', '10001', 'USA'),
('Bob Smith', '1985-07-15', 'bob.smith@outlook.com', '555-987-6543', '456', 'bldg 200', 'Oak St', 'Los Angeles', 'CA', '90001', 'USA');
-- ('David Brown', '1992-03-10', 'david.brown@gmail.com', '555-555-5555', '789', NULL, 'Elm St', 'Chicago', 'IL', '60601', 'USA'),
-- ('Eva Garcia', '1988-12-05', 'eva.garcia@outlook.com', '555-111-2222', '321', NULL, 'Oak St', 'Houston', 'TX', '77001', 'USA');
-- -------------------------------------------------------------
-- -- * User Insert Statement w/SSN && no Business
INSERT INTO User (Full_Name, Date_Of_Birth, SSN, Email, Phone_Number, Address_Line_1, Address_Line_2, Street, City, State, Zip_Code, Country)
VALUES
('Frank Miller', '1990-09-30', '123-45-6789', 'frank.miller@gmail.com', '555-777-8888', '654', NULL, 'Pine St', 'Seattle', 'WA', '98101', 'USA'),
('Henry Thompson', '1988-04-20', '555-12-3456', 'henry.thompson@outlook.com', '555-222-2222', '567', NULL, 'Spruce St', 'Boston', 'MA', '02101', 'USA');
-- -------------------------------------------------------------
-- -- * User Insert Statement w/Business && no SSN
INSERT INTO User (Full_Name, Date_Of_Birth, Email, Phone_Number, Address_Line_1, Address_Line_2, Street, City, State, Zip_Code, Country, Has_Business)
VALUES
('Jack Lee', '1987-06-25', 'jack.lee@gmail.com', '555-666-6666', '234', 'suite 100', 'Fir St', 'Denver', 'CO', '80201', 'USA', TRUE),
('Kate Walker', '1991-10-05', 'kate.walker@outlook.com', '555-888-8888', '678', NULL, 'Willow St', 'Phoenix', 'AZ', '85001', 'USA', TRUE);
-- -------------------------------------------------------------
-- -- * User Insert Statement w/Business && w/SSN
INSERT INTO User (Full_Name, Date_Of_Birth, SSN, Email, Phone_Number, Address_Line_1, Address_Line_2, Street, City, State, Zip_Code, Country, Has_Business)
VALUES
('Liam Harris', '1985-05-15', '333-22-1111', 'liam.harris@gmail.com', '555-999-9999', '432', 'suite 500', 'Birch St', 'San Diego', 'CA', '92101', 'USA', TRUE),
('Mia Young', '1994-01-30', '222-11-3333', 'mia.young@outlook.com', '555-777-7777', '876', NULL, 'Maple St', 'Dallas', 'TX', '75201', 'USA', TRUE);
-- -------------------------------------------------------------
-- -- * Business User Insert Statement if User_ID has Business set to TRUE
INSERT INTO Business_User (User_ID, EIN, Business_Name, Start_Of_Business, Business_Phone, Business_Email)
SELECT u.User_ID, bu.EIN, bu.Business_Name, bu.Start_Of_Business, bu.Business_Phone, bu.Business_Email
FROM (
      SELECT 5 AS User_ID, '12-3456789' AS EIN, 'Tech Solutions' AS Business_Name, '2010-01-01' AS Start_Of_Business, '555-123-4567' AS Business_Phone, 'tech.solutions@gmail.com' AS Business_Email
      UNION ALL
      SELECT 6, '98-7654321', 'Green Energy', '2012-03-15', '555-987-6543', 'green.energy@outlook.com'
      UNION ALL
      SELECT 7, '11-2233445', 'Health Services', '2015-06-20', '555-555-5555', 'health.services@gmail.com'
      UNION ALL
      SELECT 8, '22-3344556', 'Travel Agency', '2018-09-10', '555-111-2222', 'travel.agency@outlook.com'
) AS bu
JOIN User u ON bu.User_ID = u.User_ID
WHERE u.Has_Business = TRUE;
-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- ? Select Statements
SELECT * FROM User;
SELECT * FROM User WHERE Has_Business = TRUE;
SELECT * FROM User WHERE SSN IS NOT NULL;
SELECT * FROM Business_User;
-- ------------------------------------------------------------
-- -- * Select All Users By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
    CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select Users with no SSN & no Business By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u WHERE u.SSN IS NULL AND u.Has_Business = FALSE ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select Users with SSN & no Business By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u WHERE u.SSN IS NOT NULL AND u.Has_Business = FALSE ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select Users with business & no SSN By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address, u.SSN
FROM User u WHERE u.SSN IS NULL AND u.Has_Business = TRUE ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select Users with business & SSN By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u WHERE u.SSN IS NOT NULL AND u.Has_Business = TRUE ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select All User Data with SSN ONLY By User_ID Ascending
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth, u.SSN, u.Email, u.Phone_Number,
   CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u WHERE u.SSN IS NOT NULL ORDER BY u.User_ID ASC;
-- ------------------------------------------------------------
-- -- * Select All User Data with Business Data
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth,  u.Email, u.Phone_Number, CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address,
       bu.Business_ID, bu.EIN, bu.Business_Name, bu.Start_Of_Business, bu.Business_Phone, bu.Business_Email
FROM User u LEFT JOIN Business_User bu ON u.User_ID = bu.User_ID WHERE u.Has_Business = TRUE ORDER BY u.User_ID DESC;
-- ------------------------------------------------------------
-- -- * Select All User Data with No Business Data
SELECT u.User_ID, u.Full_Name, u.Date_Of_Birth,  u.Email, u.Phone_Number, CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address
FROM User u LEFT JOIN Business_User bu ON u.User_ID = bu.User_ID WHERE u.Has_Business = FALSE ORDER BY u.User_ID DESC;
