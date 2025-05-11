-- ===============================
-- *  User - Super Type Entity
-- ===============================
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
-- ===============================