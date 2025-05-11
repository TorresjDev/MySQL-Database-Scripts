-- ===============================
-- * Insert Credit Report Data
-- ===============================
INSERT INTO
    Credit_Report (
        User_ID,
        Credit_Bureau_Name,
        Credit_Score,
        Report_Date,
        Credit_Description
    )
VALUES (
        1,
        'Equifax',
        720,
        '2023-01-15',
        'Good credit history'
    ),
    (
        1,
        'Experian',
        710,
        '2023-01-15',
        'Good credit history'
    ),
    (
        1,
        'TransUnion',
        715,
        '2023-01-15',
        'Good credit history'
    ),
    (
        3,
        'Equifax',
        680,
        '2023-02-20',
        'Average credit history'
    ),
    (
        3,
        'Experian',
        690,
        '2023-02-20',
        'Average credit history'
    ),
    (
        3,
        'TransUnion',
        685,
        '2023-02-20',
        'Average credit history'
    ),
    (
        5,
        'Equifax',
        750,
        '2023-03-10',
        'Excellent credit history'
    ),
    (
        5,
        'Experian',
        740,
        '2023-03-10',
        'Excellent credit history'
    ),
    (
        5,
        'TransUnion',
        745,
        '2023-03-10',
        'Excellent credit history'
    );
-- ===============================