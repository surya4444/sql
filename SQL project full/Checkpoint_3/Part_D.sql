/**TODO 1: Sometimes customers might return their car later than the expected return date. In order to include this in our database, add the 
following column to the booking table:
     1. Actual Drop Off date - It represents the actual date when the customer returned the vehicle. It should store DATE. The default value 
     for this should be NULL and once the user returns the vehicle, it should be updated with the return date. 
**/

ALTER TABLE booking ADD actual_dropoff_date DATE;
SELECT * FROM booking;
/**TODO 2:  Write a trigger ‘generate_bill_trigger’ that is invoked when an update statement is called on the booking table to update 
the actual return date and vehicle status for the booking. This trigger     should generate a bill, which means it should insert data in 
the bill table based on the updated actual return date. If discrepancy (such as actual return date is even before the pickup date) is found,
ensure using raise_application_error that the update statement doesn’t run. **/

CREATE OR REPLACE TRIGGER generate_bill_trigger
    BEFORE UPDATE ON booking
    FOR EACH ROW
DECLARE
    discount bill.discount%TYPE;
    tax_amount bill.tax_amount%TYPE;
    total_amount bill.total_amount%TYPE;
    c_role_name VARCHAR2(50);
invalid_user  EXCEPTION;
CURSOR c_user is
SELECT R.role_name
    FROM user_role UR INNER JOIN role R ON UR.role_id=R.role_id WHERE UR.user_id=:new.user_id;
BEGIN
    dbms_output.put_line('begin');
    IF to_date(:new.actual_dropoff_date, 'DD-MM_RR') - to_date(:new.pickup_date, 'DD-MM-RR') < 0 THEN
        dbms_output.put_line(to_date(:new.actual_dropoff_date, 'DD-MM_RR') - to_date(:new.pickup_date, 'DD-MM-RR'));
        raise_application_error(-20113, 'Invalid return date or vehicle status. Operation aborted.');
    ELSE
        OPEN c_user;
        FETCH c_user INTO c_role_name;
        IF c_role_name  = 'Employee' THEN
            discount:= :new.amount/5;
        ELSIF c_role_name  = 'User' THEN
            discount:=0;
        ELSE
            discount:=0;
            RAISE invalid_user;
        END IF;
        CLOSE c_user;    
        tax_amount:= :new.amount/10;
        total_amount:= :new.amount + tax_amount - discount;
        Insert into  bill (BOOKING_ID,VEHICLE_ID,USER_ID,BILL_DATE,DISCOUNT,TAX_AMOUNT,TOTAL_AMOUNT,MESSAGE)
        values (:new.booking_id,:new.vehicle_id,:new.user_id,to_date(sysdate,'DD-MM-RR'),discount,tax_amount,total_amount,'Valid Bill');
    END IF;
EXCEPTION
       WHEN invalid_user THEN
        dbms_output.put_line('Invalid user data.');
END;
/

--TODO 3: Update an entry in the booking table with actual return date as 21-06-20 for booking with id B0002.
UPDATE booking SET actual_dropoff_date = TO_DATE('21-06-20','DD-MM-RR') WHERE booking_id='B0002';

--TODO 4: Show the bill table to ensure that the bill was generated for booking ID B0002.
SELECT * FROM bill;