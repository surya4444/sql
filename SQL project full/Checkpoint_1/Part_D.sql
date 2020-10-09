/**TODO 4: Create a single index named ‘users_name_index’ on first name and last name columns of users table in the same order as mentioned below:
1. First name 
2. Last name. **/
CREATE INDEX users_name_index
ON users (first_name, last_name);