-- =====================================
-- Generic Stored Procedure Template (MySQL)
-- =====================================

-- A stored procedure is a pre-coded SQL that can be saved and reused.
-- Useful for logic encapsulation, security, and reducing repeated code.
-- Always change the delimiter temporarily before using semicolons inside SQL logic.

DELIMITER $$

CREATE PROCEDURE Generic_Procedure_Template (
    IN input_param1 INT,            -- Input parameter 1 (can be any data type)
    IN input_param2 VARCHAR(100),   -- Input parameter 2 (example: user name or text)
    OUT output_param VARCHAR(255)   -- Output parameter to return processed results
)
BEGIN
    -- =====================================
    -- If needed: Declare Local Variables
    -- Syntax: DECLARE var_name TYPE DEFAULT value;
    -- =====================================
    DECLARE exit_condition BOOLEAN DEFAULT FALSE;
    DECLARE counter INT DEFAULT 0;
    DECLARE temp_result VARCHAR(255);

    -- =====================================
    -- Example IF-ELSE Logic
    -- Syntax: IF condition THEN ... ELSE ... END IF;
    -- =====================================
    IF input_param1 > 100 THEN
        SET temp_result = CONCAT('High Value: ', input_param2);
    ELSE
        SET temp_result = CONCAT('Low Value: ', input_param2);
    END IF;

    -- =====================================
    -- Example LOOP Block
    -- LOOPs must include a LEAVE statement to avoid infinite loops.
    -- Use ITERATE to skip the current iteration.
    -- =====================================
    loop_label: LOOP
        IF counter >= input_param1 THEN
            LEAVE loop_label;               -- Exit loop when counter exceeds limit
        END IF;

        SET counter = counter + 1;

        IF (counter MOD 2) = 1 THEN
            ITERATE loop_label;             -- Skip odd numbers
        END IF;

        -- Optional logic inside loop
        -- Example: Accumulate data, perform actions, etc.
    END LOOP;

    -- =====================================
    -- Output Assignment
    -- Use SET to assign final result to output parameter
    -- =====================================
    SET output_param = temp_result;

END $$

-- Resetting delimiter to default after the stored procedure is created
DELIMITER ;

-- =====================================
-- To Call This Procedure:
-- SET @output = '';
-- CALL Generic_Procedure_Template(120, 'Test Name', @output);
-- SELECT @output;  -- Shows the value returned in output_param
