CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    current_balance NUMBER;
BEGIN
    IF :NEW.transaction_type = 'WITHDRAWAL' THEN
        SELECT balance INTO current_balance FROM Accounts WHERE account_id = :NEW.account_id FOR UPDATE;
        IF :NEW.amount > current_balance THEN
            RAISE_APPLICATION_ERROR(-20001, 'Withdrawal amount exceeds current balance.');
        END IF;
    ELSIF :NEW.transaction_type = 'DEPOSIT' THEN
        IF :NEW.amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Deposit amount must be positive.');
        END IF;
    END IF;
END CheckTransactionRules;
/
