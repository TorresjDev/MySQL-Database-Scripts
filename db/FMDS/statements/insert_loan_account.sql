-- ===============================
-- * Loan Account - Insert Statement
-- ===============================
INSERT INTO
    Loan_Account (
        Account_ID,
        Loan_Amount,
        Loan_Term,
        Interest_Rate,
        Exp_Monthly_Payment,
        Start_Date,
        Exp_End_Date
    )
VALUES (
        1,
        15000.00,
        120,
        5.25,
        160.00,
        '2021-09-01',
        '2031-09-01'
    ),
    (
        2,
        20000.00,
        60,
        4.75,
        400.00,
        '2022-10-01',
        '2027-10-01'
    ),
    (
        19,
        50000.00,
        120,
        5.25,
        550.00,
        '2023-01-01',
        '2033-01-01'
    );
-- ===============================