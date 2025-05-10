-- ---------------------------------------------------------
-- *  Credit Report Super Type Entity
-- ---------------------------------------------------------
CREATE TABLE Credit_Report (
      Credit_Report_ID INT NOT NULL AUTO_INCREMENT,
      User_ID INT NOT NULL,
      Credit_Bureau_Name VARCHAR(50) NOT NULL CHECK (Credit_Bureau_Name IN ('Equifax', 'Experian', 'TransUnion')),
      Credit_Score INT NOT NULL CHECK (Credit_Score BETWEEN 300 AND 850),
      Report_Date DATE NOT NULL,
      Credit_Description TEXT,
      Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      CONSTRAINT PK_Credit_Report PRIMARY KEY (Credit_Report_ID),
      CONSTRAINT FK_User_Credit FOREIGN KEY (User_ID) REFERENCES User(User_ID),
      CONSTRAINT UQ_User_Bureau_Date UNIQUE (User_ID, Credit_Bureau_Name, Report_Date)
);