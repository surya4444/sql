--TODO 1: Write a block to delete all the invalid bills from the bill table.
BEGIN
  FOR bill IN (SELECT BOOKING_ID FROM bill where message='Invalid Bill')
  LOOP
    DELETE FROM bill WHERE BOOKING_ID =bill.BOOKING_ID;
    dbms_output.put_line('Invalid bill with BOOKING_ID: ' || bill.BOOKING_ID || ' was deleted');
  END LOOP;
END;
/
