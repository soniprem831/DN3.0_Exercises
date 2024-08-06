DELIMITER //

CREATE PROCEDURE TransferFunds(IN source_account_id INT, IN destination_account_id INT, IN amount DECIMAL(10,2))
BEGIN
    DECLARE current_balance DECIMAL(10,2);
    SELECT balance INTO current_balance FROM Accounts WHERE account_id = source_account_id;
    IF current_balance >= amount THEN
        UPDATE Accounts SET balance = balance - amount WHERE account_id = source_account_id;
        UPDATE Accounts SET balance = balance + amount WHERE account_id = destination_account_id;
    ELSE
        SIGNAL SQLSTATE '5000' SET MESSAGE_TEXT = 'INSUFFICIENT FUNDS IN SOURCE ACCOUNT';
    END IF;
    
END //

DELIMITER ;
