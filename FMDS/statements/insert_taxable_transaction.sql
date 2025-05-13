-- ===============================
-- * Taxable Transaction - Insert Statements
-- ===============================
INSERT INTO
    Taxable_Transaction (
        Tx_ID,
        Tax_Report_ID,
        Tax_Category,
        Taxable_Amount,
        Identified_Timestamp,
        Notes
    )
VALUES (
        1,
        1,
        'Wages',
        1000.00,
        '2023-10-01 09:00:00',
        'Salary reported for September'
    ),
    (
        3,
        1,
        'Freelance Income',
        500.00,
        '2023-10-03 08:30:00',
        'Income from freelance work'
    ),
    (
        7,
        1,
        'Wages',
        1200.00,
        '2023-10-13 09:15:00',
        'October paycheck'
    ),
    (
        5,
        2,
        'Dividends',
        15.00,
        '2023-10-06 11:30:00',
        'SPY dividend reinvested'
    ),
    (
        6,
        2,
        'Investment Expense',
        300.00,
        '2023-10-06 11:20:00',
        'Robinhood premium fee - partially deductible'
    ),
    (
        17,
        2,
        'Dividends',
        35.00,
        '2023-10-17 13:30:00',
        'VOO quarterly dividend'
    ),
    (
        12,
        2,
        'Capital Gains',
        1200.00,
        '2023-10-22 10:10:00',
        'Gains from QQQ stock purchase'
    ),
    (
        9,
        3,
        'Freelance Income',
        800.00,
        '2023-10-09 17:00:00',
        'Freelance work payout'
    ),
    (
        15,
        3,
        'Interest Income',
        25.00,
        '2023-10-08 12:00:00',
        'Crypto platform interest accrued'
    ),
    (
        19,
        3,
        'Travel Expense',
        600.00,
        '2023-10-18 17:15:00',
        'Work travel charges reimbursed later'
    ),
    (
        24,
        3,
        'Capital Gains',
        300.00,
        '2023-10-25 16:30:00',
        'LTC partial sale - capital gain'
    );
-- ===============================