DECLARE
    CURSOR c_accounts IS
        SELECT AccountID, Balance
        FROM Accounts;
    
    v_accountID Accounts.AccountID%TYPE;
    v_balance Accounts.Balance%TYPE;
    v_annual_fee NUMBER := 50; 

BEGIN
    OPEN c_accounts;
    
    LOOP
        FETCH c_accounts INTO v_accountID, v_balance;
        EXIT WHEN c_accounts%NOTFOUND;
        UPDATE Accounts
        SET Balance = v_balance - v_annual_fee
        WHERE AccountID = v_accountID;
        DBMS_OUTPUT.PUT_LINE('Applied fee to AccountID: ' || v_accountID);
    END LOOP;
    
    CLOSE c_accounts;
END;
/
