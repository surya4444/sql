/**TODO 1: Write a function ‘available_vehicles’ which lists the count of all the available vehicles. 
    A vehicle is deemed to be available if the user has registered the vehicle, and the vehicle is available for renting. Also, that 
    vehicle should be approved by the admin as well. **/

CREATE OR REPLACE FUNCTION available_vehicles
RETURN NUMBER
IS
   vehicle_count NUMBER(10);
BEGIN
   SELECT COUNT(*)
   INTO vehicle_count
   FROM request RQ WHERE RQ.request_status_id='RE002' AND RQ.activity_id='A0002';
   RETURN vehicle_count;
END;
/

--TODO 2: Call the available_vehicles function and display the number of available vehicles in the application.

SET SERVEROUTPUT ON
DECLARE 
   e NUMBER(10); 
BEGIN 
   e := available_vehicles(); 
   dbms_output.put_line('No. of available vehicles: ' || e); 
END;