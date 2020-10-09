--TODO  1: Insert records into the ‘booking’ table. 
INSERT INTO  BOOKING 
VALUES ('B0007', TO_DATE('21-05-20','DD-MM-RR'),TO_DATE('29-05-20','DD-MM-RR'),TO_DATE('25-05-20','DD-MM-RR'),3000.00,'L0001','V0003','U0004');
INSERT INTO  BOOKING 
VALUES ('B0008',TO_DATE('21-04-20','DD-MM-RR'),TO_DATE('29-04-20','DD-MM-RR'),TO_DATE('10-04-20','DD-MM-RR'),2000.00,'L0002','V0003','U0002');
INSERT INTO  BOOKING  
VALUES ('B0009',TO_DATE('11-04-20','DD-MM-RR'),TO_DATE('20-04-20','DD-MM-RR'),TO_DATE('10-04-20','DD-MM-RR'),1000.00,'L0003','V0002','U0003');
INSERT INTO  BOOKING  
VALUES ('B0010',TO_DATE('21-07-20','DD-MM-RR'),TO_DATE('29-07-20','DD-MM-RR'),TO_DATE('10-07-20','DD-MM-RR'),3000.00,'L0001','V0001','U0002');
INSERT INTO  BOOKING 
VALUES ('B0011',TO_DATE('11-07-20','DD-MM-RR'),TO_DATE('20-07-20','DD-MM-RR'),TO_DATE('10-07-20','DD-MM-RR'),5000.00,'L0003','V0003','U0005');
INSERT INTO  BOOKING 
VALUES ('B0012',TO_DATE('11-08-20','DD-MM-RR'),TO_DATE('23-08-20','DD-MM-RR'),TO_DATE('10-08-20','DD-MM-RR'),5000.00,'L0001','V0003','U0002');


/**TODO 2:  You need to calculate the percentage change in the number of pickups from the company website in the subsequent months for the 
year 2020. Show the results only for months where there are some pickups in both compared months. For eg - include only those months, where 
both compared months have pickups(>0). The result should contain two columns - 
1. Month Number : The month number of the earlier months being compared.
2. Percent Change : The percentage change in the number of pickups between the month mentioned in the first column and its next month. 
**/ 
SELECT EXTRACT( MONTH FROM TO_DATE(A.pickup_date,'DD-MM-RR')) AS "Month Number", 
    ROUND((COUNT(DISTINCT(B.BOOKING_ID))- COUNT(DISTINCT(A.BOOKING_ID))) * 100 / COUNT(DISTINCT(A.BOOKING_ID)), 2) AS "Percent Change"
FROM booking A, booking B 
WHERE EXTRACT( YEAR FROM TO_DATE(B.pickup_date,'DD-MM-RR')) = EXTRACT( YEAR FROM TO_DATE(A.pickup_date,'DD-MM-RR')) 
AND EXTRACT( MONTH FROM TO_DATE(A.pickup_date,'DD-MM-RR')) = EXTRACT( MONTH FROM TO_DATE(B.pickup_date,'DD-MM-RR')) - 1 
AND EXTRACT( YEAR FROM TO_DATE(B.pickup_date,'DD-MM-RR'))=2020 GROUP BY EXTRACT( MONTH FROM TO_DATE(A.pickup_date,'DD-MM-RR'));
