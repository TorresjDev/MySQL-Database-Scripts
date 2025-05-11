-- ===============================
-- * Credit Account - Insert Statement
-- ===============================
INSERT INTO
    Credit_Account (
        Account_ID,
        Credit_Card_Number,
        Credit_Limit,
        Interest_Rate,
        Billing_Cycle_Due_Date,
        Card_Expiration_Date
    )
VALUES (
        5,
        '4111111111111111',
        5000.00,
        18.99,
        '2024-05-10',
        '2027-05'
    ),
    (
        10,
        '5500000000000004',
        10000.00,
        15.99,
        '2024-06-15',
        '2026-06'
    ),
    (
        18,
        '4111111111111111',
        10000.00,
        18.99,
        '2024-05-10',
        '2027-05'
    );
-- ===============================