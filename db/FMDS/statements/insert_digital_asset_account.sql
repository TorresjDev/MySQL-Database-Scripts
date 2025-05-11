-- ===============================
-- * Digital Asset Account - Insert Statement
-- ===============================
INSERT INTO
    Digital_Asset_Account (
        Account_ID,
        Digital_Account_Type,
        Wallet_Address,
        Total_User_Contribution,
        Total_Digital_Assets_Value,
        Total_Dividends_Earned,
        Total_Interest_Earned
    )
VALUES (
        4,
        'Crypto Wallet',
        '0xA1B2C3D4E5F6G7H8I9J0',
        3200.00,
        4100.00,
        85.00,
        22.50
    ),
    (
        8,
        'Crypto Wallet',
        '0xB1C2D3E4F5G6H7I8J9K0',
        5000.00,
        6000.00,
        150.00,
        30.00
    ),
    (
        13,
        'Hardware Wallet',
        '0xC1D2E3F4G5H6I7J8K9L0',
        7000.00,
        8000.00,
        200.00,
        40.00
    ),
    (
        17,
        'Business Crypto Wallet',
        '0xA1B2C3D4E5F6G7H8I9J0',
        15000.00,
        20000.00,
        300.00,
        50.00
    );
-- ===============================