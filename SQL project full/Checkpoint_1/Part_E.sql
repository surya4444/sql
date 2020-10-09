--TODO 1:  Insert records into the ‘city’ table. 
INSERT INTO  CITY (CITY_ID,CITY_NAME) 
VALUES ('C0002','Bangalore');
INSERT INTO  CITY (CITY_ID,CITY_NAME) 
VALUES ('C0003','Delhi');
INSERT INTO  CITY (CITY_ID,CITY_NAME) 
VALUES ('C0004','Kolkata');

--TODO 2:  Insert the below records into the ‘location’ table. 
INSERT INTO  LOCATION (LOCATION_ID,LOCATION_NAME,ADDRESS,CITY_ID,PINCODE) 
VALUES ('L0005','Bangalore Railway station', 'Kempegowda, Sevashrama, Bengaluru','C0002','500023');
INSERT INTO  LOCATION (LOCATION_ID,LOCATION_NAME,ADDRESS,CITY_ID,PINCODE) 
VALUES ('L0006','New Delhi Railway station', 'Bhavbhuti Marg, Ratan Lal Market, Kamla Market, Ajmeri Gate','C0003','110006');


/**TODO 3:  Find out the count of bookings per city. Include only those cities which have at least 1 booking. The result should contain two 
columns -
1. City name
2. Number of Bookings - showing the number of bookings done in the respective city. **/
SELECT C.city_name, COUNT(C.city_name) AS "Number of Bookings" 
FROM city C 
INNER JOIN location L 
ON C.city_id = L.city_id 
INNER JOIN booking B 
ON L.location_id = B.location_id 
GROUP BY C.city_name;