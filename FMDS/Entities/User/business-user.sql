-- ---------------------------------------------------------
-- ? BUSINESS_USER – Weak Entity
CREATE TABLE Business_User (
    Business_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    EIN VARCHAR(15) UNIQUE NOT NULL,
    Business_Name VARCHAR(100) NOT NULL,
    Business_Founded_Date DATE NOT NULL,
    Business_Phone VARCHAR(15),
    Business_Email VARCHAR(100),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Business_User PRIMARY KEY (Business_ID),
    CONSTRAINT FK_User_Business FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);
-- ---------------------------------------------------------
-- * Business User Insert Statement
INSERT INTO Business_User (User_ID, EIN, Business_Name, Business_Founded_Date, Business_Phone, Business_Email, Age_Of_Business)
VALUES
(1, '12-3456789', 'Tech Innovations LLC', '2015-06-01', '555-1234', 'tech@example.com'),
(2, '98-7654321', 'Green Solutions Inc.', '2018-03-15', '555-5678', 'green@example.com'),
(3, '11-2233445', 'Health & Wellness Co.', '2020-01-10', '555-9876', 'health@example.com'),
(4, '22-3344556', 'Finance Gurus Ltd.', '2017-11-20', '555-4321', 'finance@example.com'),
(5, '33-4455667', 'Travel Adventures Corp.', '2019-08-30', '555-8765', 'travel@example.com'),
(6, '44-5566778', 'Foodies Delight LLC', '2021-05-25', '555-2345', 'foodies@example.com')
-- ---------------------------------------------------------
-- * Business User Select Statement
SELECT * FROM Business_User;