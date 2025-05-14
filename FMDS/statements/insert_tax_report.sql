-- ===============================
-- * Tax Report - Insert Statements
-- ===============================
INSERT INTO
    Tax_Report (
        User_ID,
        Tax_Year,
        Filing_Status,
        Spouse_Income,
        Num_Dependents,
        Tax_Notes
    )
VALUES (
        1,
        2023,
        'Single',
        NULL,
        0,
        'Standard income filing'
    ),
    (
        3,
        2023,
        'Married Filing Jointly',
        45000.00,
        2,
        'Includes spouse income and dependents'
    ),
    (
        5,
        2023,
        'Head of Household',
        NULL,
        1,
        'Freelance work + family support'
    );
-- ===============================