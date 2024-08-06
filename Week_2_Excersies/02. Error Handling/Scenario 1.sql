CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    from_account_id IN NUMBER,
    to_account_id IN NUMBER,
    amount IN NUMBER
)
IS
    insufficient_funds EXCEPTION;
    funds_balance NUMBER;
BEGIN

    SELECT balance INTO funds_balance FROM Accounts WHERE account_id = from_account_id FOR UPDATE;
    
    IF funds_balance < amount THEN
        RAISE insufficient_funds;
    ELSE
        
        UPDATE Accounts SET balance = balance - amount WHERE account_id = from_account_id;
        UPDATE Accounts SET balance = balance + amount WHERE account_id = to_account_id;
    END IF;

    COMMIT;
EXCEPTION
    WHEN insufficient_funds THEN
        INSERT INTO ErrorLogs (message, log_time) VALUES ('FUNDS ARE INSUFFICIENT!', SYSDATE);
        ROLLBACK;
    WHEN OTHERS THEN
        INSERT INTO ErrorLogs (message, log_time) VALUES (SQLERRM, SYSDATE);
        ROLLBACK;
END SafeTransferFunds;
