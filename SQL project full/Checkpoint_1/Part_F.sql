/**TODO 1:  Find all users and their vehicle information irrespective of whether they have their vehicles registered in the  
website or not. The vehicle information should be displayed as null/empty for the users who haven’t registered any vehicle and are 
just renting cars. Also, the information should be displayed in ascending order of user id.**/

SELECT * 
FROM users U 
LEFT JOIN vehicle V 
ON U.user_id = V.user_id 
ORDER BY U.user_id;