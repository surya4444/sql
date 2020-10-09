/**TODO  1: Find the total count of vehicles booked on 25-May-2020, by their vehicle_id and display them in descending order of their 
number of bookings. The query should return the following columns: 
1. Vehicle_id
2. Total number of times that vehicle was booked on 25th May 2020 As Number of Bookings.**/
SELECT B.vehicle_id, COUNT(B.vehicle_id) AS "Number of Bookings" FROM booking B 
WHERE B.booking_date = '25-MAY-2020'
GROUP BY B.vehicle_id 
ORDER BY COUNT(B.vehicle_id) DESC;