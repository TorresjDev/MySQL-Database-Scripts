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
);
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
);
-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- ? Insert Statements
-- -------------------------------------------------------------
-- -- * User Insert Statements
INSERT INTO User (User_ID, Full_Name, Date_Of_Birth, SSN, Email, Phone_Number, Address_Line_1, Address_Line_2, Street, City, State, Zip_Code, Country, Has_Business)
VALUES
(1, 'Alice Johnson', '1990-03-15', '123-45-6789', 'alice.johnson@email.com', '123-456-7890', '123', NULL, 'Main St', 'New York', 'NY', '10001', 'USA', TRUE),
(2, 'Brian Lee', '1985-07-20', NULL, 'brian.lee@email.com', '321-654-9870', '456', NULL, 'Elm St', 'Dallas', 'TX', '75001', 'USA', FALSE),
(3, 'Carlos Rivera', '1988-12-05', '987-65-4321', 'carlos.rivera@email.com', '789-654-1230', '789', NULL, 'Oak St', 'Houston', 'TX', '77002', 'USA', TRUE),
(4, 'Diana Blake', '1995-04-22', NULL, 'diana.blake@email.com', '147-258-3690', '321', NULL, 'Pine St', 'San Antonio', 'TX', '78205', 'USA', TRUE),
(5, 'Ethan Hunt', '1992-11-11', '135-45-6279', 'ethan.hunt@email.com', '123-456-7890', '423', NULL, 'Maple St', 'Austin', 'TX', '73301', 'USA', FALSE);
-- -------------------------------------------------------------
-- -- * Business User Insert Statements
INSERT INTO Business_User (User_ID, EIN, Business_Name, Start_Of_Business, Business_Phone, Business_Email)
VALUES
(1, '12-3456789', 'Tech Innovations', '2010-01-01', '5551234567', 'tech.innovations@gmail.com'),
(3, '14-3475189', 'Rivera Consulting LLC', '2015-06-01', '8882223333', 'contact@riveraconsult.com'),
(4, '98-7654321', 'Blake Design Studio', '2018-09-15', '8664449999', 'hello@blakedesigns.com');
-- -------------------------------------------------------------
-- -------------------------------------------------------------
-- ? Select Statements
SELECT * FROM User;
SELECT * FROM Business_User;
SELECT * FROM User WHERE Has_Business = TRUE;
SELECT * FROM User WHERE SSN IS NOT NULL;
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
