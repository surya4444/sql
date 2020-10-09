/**TODO  3: Find the list of all unique id of users who have performed any of the following operations in the website:
1. Made a request 
2. Booked a vehicle 
3. Signed up on the platform. 
The result should only contain the user_id displayed as “ID”. **/
SELECT user_id AS "ID"
FROM users
UNION 
SELECT user_id AS "ID"
FROM request
UNION
SELECT user_id AS "ID"
FROM booking;