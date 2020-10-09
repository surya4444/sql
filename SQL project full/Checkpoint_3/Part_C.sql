/**TODO 1: Write a procedure named “add_bill_data” to populate data into the ‘bill’  table as follows:
1. The procedure should accept booking_id as an input.
2. In case the user is an “Admin”, an exception should be raised which displays “Invalid user”. **/

CREATE OR REPLACE PROCEDURE add_bill_data (selected_booking_id IN booking.booking_id%TYPE)
IS
    role_name VARCHAR2(50);
    basic_amount NUMBER(10,2);
    vehicle_id	CHAR(5);	
	user_id	CHAR(5);
	invalid_user  EXCEPTION; 
BEGIN
    SELECT R.role_name, B.amount, B.vehicle_id, B.user_id
    INTO role_name, basic_amount, vehicle_id, user_id
    FROM booking B 
    INNER JOIN user_role UR ON UR.user_id=B.user_id 
    INNER JOIN role R ON UR.role_id=R.role_id 
    WHERE B.booking_id=selected_booking_id;
    IF role_name  = 'Employee' THEN
        Insert into  bill (BOOKING_ID,VEHICLE_ID,USER_ID,BILL_DATE,DISCOUNT,TAX_AMOUNT,TOTAL_AMOUNT,MESSAGE) 
        values (selected_booking_id,vehicle_id,user_id,to_date(sysdate,'DD-MM-RR'),basic_amount/5,basic_amount/10, basic_amount + basic_amount/10 - basic_amount/5, 'Valid Bill');
    ELSIF role_name  = 'User' THEN
        Insert into  bill (BOOKING_ID,VEHICLE_ID,USER_ID,BILL_DATE,DISCOUNT,TAX_AMOUNT,TOTAL_AMOUNT,MESSAGE) 
        values (selected_booking_id,vehicle_id,user_id,to_date(sysdate,'DD-MM-RR'),0,basic_amount/10, basic_amount + basic_amount/10,'Valid Bill');
    ELSE
        RAISE invalid_user; 
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No booking by the booking id provided. Operation aborted.');
    WHEN invalid_user THEN 
        dbms_output.put_line('Invalid user data.'); 
END;
/
--TODO 2: Add bill data for booking_id B0003.
EXECUTE add_bill_data('B0003');

/** Check the data in the bill table **/
SELECT * FROM bill;