/**--------------------------------------------------------------------------------------------------------------------------------------

                            CHECKPOINT 2

--------------------------------------------------------------------------------------------------------------------------------------**/

--TODO 1: Create a table named "bill" to store the data of the final bill received by the customer. 
CREATE TABLE bill (
    booking_id	CHAR(5)	PRIMARY KEY,
    vehicle_id	CHAR(5)	NOT NULL,	
    user_id	CHAR(5)	NOT NULL,
    bill_date	DATE NOT NULL,	
    discount NUMBER(10,2)	DEFAULT 0,
    tax_amount	NUMBER(10,2)	NOT NULL,
    total_amount	NUMBER(10,2)	NOT NULL,
    message VARCHAR2(50),
	CONSTRAINT fk_bill_booing
	FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
	CONSTRAINT fk_bill_user
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT fk_bill_vehicle
	FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id)	
);


/** TODO 2: Write an anonymous block to populate data in the "bill" table created above where the booking_id is ‘B00001’ as follows:
The data in the bill table should be populated by getting the respective data from the booking table for the id ‘BL001’ 
The rest of the data as per calculation. 
In case the user role is “Employee”, then they should avail 20% discount otherwise, no discount. 
A user with a role as “Admin” is not allowed to do any bookings. In case the user doesn’t belong to the “Employee” or “User” role, the bill table should be populated with the message ‘Invalid Bill’, else with ‘Valid Bill’. 
In case, the user role doesn’t belong to any of these roles, raise an exception to display ‘Invalid user data.’
Note: The bill_date should be SYSDATE.**/
DECLARE
    role_name VARCHAR2(50);
    basic_amount NUMBER(10,2);
    selected_booking_id	CHAR(5);
    vehicle_id	CHAR(5);	
    user_id	CHAR(5);
    invalid_user  EXCEPTION; 
BEGIN
    selected_booking_id:='B0001';
    SELECT R.role_name, B.amount, B.vehicle_id, B.user_id
    INTO role_name, basic_amount, vehicle_id, user_id
    FROM booking B INNER JOIN user_role UR ON UR.user_id=B.user_id INNER JOIN role R ON UR.role_id=R.role_id WHERE B.booking_id=selected_booking_id;
    IF role_name  = 'Employee' THEN
        Insert into  bill (BOOKING_ID,VEHICLE_ID,USER_ID,BILL_DATE,DISCOUNT,TAX_AMOUNT,TOTAL_AMOUNT,MESSAGE) 
        values (selected_booking_id,vehicle_id,user_id,to_date(sysdate,'DD-MM-RR'),basic_amount/5,basic_amount/10, basic_amount + basic_amount/10 - basic_amount/5, 'Valid Bill');
    ELSIF role_name  = 'User' THEN
        Insert into  bill (BOOKING_ID,VEHICLE_ID,USER_ID,BILL_DATE,DISCOUNT,TAX_AMOUNT,TOTAL_AMOUNT,MESSAGE) 
        values (selected_booking_id,vehicle_id,user_id,to_date(sysdate,'DD-MM-RR'),0,basic_amount/10, basic_amount + basic_amount/10,'Valid Bill');
    ELSIF role_name  = 'Admin' THEN 
        Insert into  bill (BOOKING_ID,VEHICLE_ID,USER_ID,BILL_DATE,DISCOUNT,TAX_AMOUNT,TOTAL_AMOUNT,MESSAGE) 
        values (selected_booking_id,vehicle_id,user_id,to_date(sysdate,'DD-MM-RR'),0,basic_amount/10, basic_amount + basic_amount/10,'Invalid Bill');
    ELSE
    RAISE invalid_user; 
    END IF;
    EXCEPTION
    WHEN invalid_user THEN 
        dbms_output.put_line('Invalid user data.'); 
END;
/

/** Display the bill table **/
SELECT * FROM bill;



