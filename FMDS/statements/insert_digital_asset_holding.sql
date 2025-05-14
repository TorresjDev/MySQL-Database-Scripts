-- ===============================
-- * Digital Asset Holding - Insert Statement
-- ===============================
INSERT INTO
    Digital_Asset_Holding (
        Account_ID,
        Digital_Asset_Type,
        Digital_Asset_Symbol,
        Digital_Asset_Name,
        Total_Quantity,
        Total_Purchase_Price,
        Average_Price_Per_Share,
        Current_Price,
        Holdings_Value,
        Unrealized_Gain_Or_Loss,
        Realized_Gain_Or_Loss,
        Date_Opened,
        Holding_Status
    )
VALUES (
        13,
        'Crypto',
        'BTC',
        'Bitcoin',
        2.5,
        100000.00,
        40000.00,
        45000.00,
        112500.00,
        12500.00,
        0.00,
        '2023-01-01',
        'Active'
    ),
    (
        13,
        'Crypto',
        'ETH',
        'Ethereum',
        10.0,
        20000.00,
        2000.00,
        2500.00,
        25000.00,
        5000.00,
        0.00,
        '2023-02-01',
        'Active'
    ),
    (
        4,
        'Digital Art',
        'NFT',
        'CryptoPunk #1234',
        1.0,
        500000.00,
        500000.00,
        600000.00,
        600000.00,
        100000.00,
        0.00,
        '2023-03-01',
        'Active'
    ),
    (
        8,
        'Crypto',
        'SOL',
        'Solana',
        50.0,
        5000.00,
        100.00,
        120.00,
        6000.00,
        1000.00,
        0.00,
        '2023-04-01',
        'Active'
    ),
    (
        8,
        'Digital Art',
        'NFT',
        'Bored Ape #5678',
        1.0,
        200000.00,
        200000.00,
        250000.00,
        250000.00,
        50000.00,
        0.00,
        '2023-05-01',
        'Active'
    );
-- ===============================