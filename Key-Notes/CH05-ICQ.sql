-- ! CH05 - Exercise on Table Creation and Record Insertion

-- Create the database for the exercise 
CREATE DATABASE CH05_ICQ;

-- Use the database for the exercise
USE CH05_ICQ;


-- Create the tables D_T && E_T
-- ! QUESTION:
-- WHY USE CONSTRAINT METHOD FOR PRIMARY KEY AND NOT DIRECTLY ASSIGNING PRIMARY KEY VIA: D_ID INTEGER NOT NULL PRIMARY KEY?

-- D_T table 
CREATE TABLE D_T (
   D_ID INTEGER NOT NULL,
   D_NAME VARCHAR(5),
   CONSTRAINT D_T_PK PRIMARY KEY (D_ID) -- Defines D_ID as the primary key; D_T_PK is the constraint's name.
);

-- E_T table
CREATE TABLE E_T (
   E_ID INTEGER NOT NULL,
   E_NAME VARCHAR(25),
   D_ID INTEGER,
   SALARY INTEGER,
   SP_ID INTEGER,
   CONSTRAINT E_T_PK PRIMARY KEY (E_ID), -- Defines E_ID as the primary key referencing E_T table; E_T_PK is the constraint's name.
   CONSTRAINT E_T_FK FOREIGN KEY (D_ID) REFERENCES D_T(D_ID), -- D_ID is a foreign key referencing D_T table; E_T_FK is the constraint's name.
   CONSTRAINT E_T_FK2 FOREIGN KEY (SP_ID) REFERENCES E_T(E_ID) -- E_T_FK2 is a self-referencing foreign key constraint for SP_ID in E_T table.
);

-- Insert data into the tables
INSERT INTO D_T (D_ID, D_NAME, MANAGER_ID) VALUES (1, 'IT', 5);
INSERT INTO D_T (D_ID, D_NAME, MANAGER_ID) VALUES (2, 'HR', 3);
INSERT INTO D_T (D_ID, D_NAME, MANAGER_ID) VALUES (3, "HQ", 2);

INSERT INTO E_T (E_ID, E_NAME, D_ID, SALARY, SP_ID) VALUES (5, 'JOHN SMITH', 1, 90000, NULL);
INSERT INTO E_T (E_ID, E_NAME, D_ID, SALARY, SP_ID) VALUES (3, 'JANE DOE', 2, 80000, 5);
INSERT INTO E_T (E_ID, E_NAME, D_ID, SALARY, SP_ID) VALUES (2, 'JACK BROWN', 3, 75000, 3);
INSERT INTO E_T (E_ID, E_NAME, D_ID, SALARY, SP_ID) VALUES (4, 'JILL WHITE', 1, 100000, 2);

ALTER TABLE D_T ADD CONSTRAINT D_T_FK1 FOREIGN KEY (MANAGER_ID) REFERENCES E_T(E_ID); -- Add foreign key constraint to D_T table

SELECT * FROM D_T; -- Select all records from D_T table

SELECT * FROM E_T; -- Select all records from E_T table

--