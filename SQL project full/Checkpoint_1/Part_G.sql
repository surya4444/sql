/**TODO 1: Find the number of bookings done by each user. Display the results in a descending order of the number of bookings done by users.
If a user has not done any bookings show the number of bookings as 0. The result should contain 2 columns - 
1. User Id 
2. Number of Bookings - showing the number of bookings done by the respective user.**/

SELECT A.user_id, COUNT(B.user_id) AS "Number of Bookings"
FROM booking B RIGHT JOIN users A
ON A.user_id = B.user_id
GROUP BY A.user_id
ORDER BY "Number of Bookings" DESC;
