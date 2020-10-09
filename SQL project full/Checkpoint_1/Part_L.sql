--TODO 1:  Insert the record into the ‘user_role’ table. 
INSERT INTO  user_role (ROLE_ID,USER_ID) 
VALUES ('RL003','U0008');

/**TODO 2: Create a view name ‘materialized_user_view’ which displays the details of the user along with the user's role information for 
those users who are either ‘Employee’ or ‘User’. **/
CREATE MATERIALIZED VIEW MV_User 
BUILD DEFERRED REFRESH COMPLETE
ON DEMAND AS
SELECT U.first_name, U.last_name, R.role_name FROM users U 
INNER JOIN user_role UR ON U.user_id=UR.user_id 
INNER JOIN role R ON UR.role_id=R.role_id 
WHERE R.role_name IN ('User','Employee');

--TODO 3:  Get the data into the view
SELECT * 
FROM MV_User;

BEGIN
DBMS_SNAPSHOT.REFRESH('MV_User');
END;

SELECT * 
FROM MV_User;
