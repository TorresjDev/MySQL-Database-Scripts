-- ===============================
-- * Taxable Transaction - Associative Entity
-- ===============================
CREATE TABLE Taxable_Transaction (
    Tx_ID INT NOT NULL,
    Tax_Report_ID INT NOT NULL,
    Tax_Category VARCHAR(50), -- e.g., 'Capital Gains', 'Interest', 'Wages'
    Taxable_Amount DECIMAL(12, 2), -- Portion of this transaction considered taxable
    Identified_Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Notes TEXT,
    CONSTRAINT PK_Taxable_Transaction PRIMARY KEY (Tx_ID),
    CONSTRAINT FK_Tx_Tax FOREIGN KEY (Tx_ID) REFERENCES Transaction (Transaction_ID),
    CONSTRAINT FK_Tax_Report_Join FOREIGN KEY (Tax_Report_ID) REFERENCES Tax_Report (Tax_Report_ID)
);
-- ===============================