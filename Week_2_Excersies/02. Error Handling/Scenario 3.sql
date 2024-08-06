CREATE OR REPLACE PROCEDURE AddNewCustomer (
    customer_id IN NUMBER, 
    customer_name IN VARCHAR2, 
    customer_email IN VARCHAR2
)
IS
    customer_exists EXCEPTION;
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Customers WHERE id = customer_id;
    
    IF v_count > 0 THEN
        RAISE customer_exists;
    ELSE
        INSERT INTO Customers (id, name, email) VALUES (customer_id, customer_name, customer_email);
    END IF;

    COMMIT;
EXCEPTION
    WHEN customer_exists THEN
        INSERT INTO ErrorLogs (message, log_time) VALUES ('Customer ID already exists', SYSDATE);
        ROLLBACK;
    WHEN OTHERS THEN
        INSERT INTO ErrorLogs (message, log_time) VALUES (SQLERRM, SYSDATE);
        ROLLBACK;
END AddNewCustomer;
