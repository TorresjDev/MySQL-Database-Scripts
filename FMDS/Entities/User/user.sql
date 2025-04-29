
-- ? USER – Strong Entity

-- * User Table
CREATE TABLE User (
    User_ID INT NOT NULL AUTO_INCREMENT,
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
    Has_business BOOLEAN DEFAULT FALSE,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_User PRIMARY KEY (User_ID)
) Comment="Personal User Entity";

--
-- * User Insert Statement
INSERT INTO User (Date_Of_Birth, SSN, Full_Name, Email, Phone_Number, Address_Line_1, Address_Line_2, Street, City, State, Zip_Code, Country, Has_business)
VALUES
('1985-05-15', '123-45-6789', 'John Doe', 'john@example.com', '555-1234', '123 Main St', NULL, 'Main Street', 'New York', 'NY', '10001', 'USA', FALSE),
('1990-08-20', NULL, 'Jane Smith', 'jane@example.com', '555-5678', '456 Elm St', NULL, 'Elm Street', 'Los Angeles', 'CA', '90001', 'USA', FALSE),
('1982-12-30', '555-55-5555', 'Alice Johnson', 'alice@example.com', '555-9876', '789 Oak St', NULL, 'Oak Street', 'Chicago', 'IL', '60601', 'USA', TRUE),
('1975-03-10', '444-44-4444', 'Bob Brown', 'bob@example.com', '555-4321', '321 Pine St', NULL, 'Pine Street', 'Houston', 'TX', '77001', 'USA', FALSE),
('1995-07-25', '222-22-2222', 'Charlie Davis', 'charlie@example.com', '555-8765', '654 Maple St', NULL, 'Maple Street', 'Miami', 'FL', '33101', 'USA', TRUE),
('1988-11-05', NULL, 'Diana Wilson', 'diana@example.com', '555-2345', '987 Cedar St', NULL, 'Cedar Street', 'San Francisco', 'CA', '94101', 'USA', FALSE),
('1992-01-15', NULL, 'Ethan Martinez', 'ethan@example.com', '555-6789', '234 Birch St', NULL, 'Birch Street', 'Seattle', 'WA', '98101', 'USA', FALSE),
('1980-09-30', NULL, 'Fiona Garcia', 'fiona@example.com', '555-3456', '567 Walnut St', NULL, 'Walnut Street', 'Boston', 'MA', '02101', 'USA', TRUE),
('1983-04-20', '888-88-8888', 'George Martinez', 'george@example.com', '555-7654', '890 Cherry St', NULL, 'Cherry Street', 'Denver', 'CO', '80201', 'USA', FALSE),
('1991-06-15', '999-99-9999', 'Hannah Lee', 'hannah@example.com', '555-2345', '345 Spruce St', NULL, 'Spruce Street', 'Phoenix', 'AZ', '85001', 'USA', TRUE);



-- * User Select Statement
SELECT * FROM User;

-- DELETE ALL ROWS FROM USER TABLE 
DELETE FROM User WHERE User_ID > 0;

DROP TABLE User;