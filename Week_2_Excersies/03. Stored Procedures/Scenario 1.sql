DELIMITER //

CREATE PROCEDURE ProcessMonthlyInterest()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE account_id INT;
    DECLARE balance DECIMAL(10,2);
    DECLARE cur CURSOR FOR SELECT account_id, balance FROM SavingsAccounts;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO account_id, balance;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET balance = balance + (balance * 0.01);
        UPDATE SavingsAccounts SET balance = balance WHERE account_id = account_id;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;