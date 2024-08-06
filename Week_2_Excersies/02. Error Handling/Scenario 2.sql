CREATE OR REPLACE PROCEDURE UpdateSalary (
    employee_id IN NUMBER,
    percentage IN NUMBER
)
IS
    employee_not_found EXCEPTION;
    v_count NUMBER;
    
BEGIN
    SELECT COUNT(*) INTO v_count FROM Employees WHERE id = employee_id FOR UPDATE;
    
    IF v_count = 0 THEN
        RAISE employee_not_found;
    ELSE
        UPDATE Employees 
        SET salary = salary + (salary * (percentage / 100)) 
        WHERE id = employee_id;
    END IF;
    COMMIT;

EXCEPTION
    WHEN employee_not_found THEN

        INSERT INTO ErrorLogs (message, log_time) VALUES ('Employee ID not found', SYSDATE);
        ROLLBACK;
    WHEN OTHERS THEN
        INSERT INTO ErrorLogs (message, log_time) VALUES (SQLERRM, SYSDATE);
        ROLLBACK;


END UpdateSalary;
