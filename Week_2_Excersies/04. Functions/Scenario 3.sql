CREATE OR REPLACE FUNCTION HasSufficientBalance (
    account_id IN NUMBER,
    amount IN NUMBER
) RETURN BOOLEAN
IS
    current_balance NUMBER;
BEGIN
    SELECT balance INTO current_balance FROM Accounts WHERE account_id = account_id;
    IF current_balance >= amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    WHEN OTHERS THEN
        RETURN FALSE;
        
END HasSufficientBalance;

