--TODO 1:  Insert records into the ‘role’ table. 
INSERT INTO  ROLE  
VALUES ('RL003','Employee');

/**TODO 2: Provide a combined list of all users and roles. If a role doesn’t exist for a user let it be null/empty and similarly if no 
users belong  to a role, keep the user information null/empty. **/
SELECT * 
FROM users U 
FULL OUTER JOIN user_role UR 
ON U.user_id = UR.user_id 
FULL OUTER JOIN role R 
ON UR.role_id = r.role_id;