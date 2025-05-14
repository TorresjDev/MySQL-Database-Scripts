-- ===============================
-- * Digital Asset - Insert Statement
-- ===============================
INSERT INTO
    Digital_Asset (
        Holding_ID,
        Account_ID,
        Action_Type,
        Quantity,
        Price_Per_Token,
        Yield_Amount,
        Gas_Fee,
        Transaction_Fee,
        TIMESTAMP,
        Optional_Note
    )
VALUES (
        1,
        13,
        'Purchase',
        0.5,
        40000.00,
        NULL,
        0.50,
        2.00,
        '2023-01-15 10:00:00',
        'Purchased Bitcoin'
    ),
    (
        1,
        13,
        'Sale',
        0.2,
        45000.00,
        NULL,
        0.50,
        2.00,
        '2023-02-15 10:00:00',
        'Sold Bitcoin for profit'
    ),
    (
        2,
        13,
        'Purchase',
        1.0,
        2000.00,
        NULL,
        0.50,
        2.00,
        '2023-03-15 10:00:00',
        'Purchased Ethereum'
    ),
    (
        3,
        4,
        'Purchase',
        1.0,
        500000.00,
        NULL,
        0.50,
        2.00,
        '2023-04-15 10:00:00',
        'Purchased CryptoPunk #1234'
    ),
    (
        4,
        8,
        'Purchase',
        25.0,
        100.00,
        NULL,
        0.50,
        2.00,
        '2023-05-15 10:00:00',
        'Purchased Solana'
    ),
    (
        5,
        8,
        'Sale',
        10.0,
        120.00,
        NULL,
        0.50,
        2.00,
        '2023-06-15 10:00:00',
        'Sold Solana for profit'
    );
-- ===============================