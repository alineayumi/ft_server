
-- Creating a db to wordpress and a user that has access to it
CREATE DATABASE wordpress;
CREATE USER 'wordpress'@'localhost';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY '123456';
FLUSH PRIVILEGES;

-- https://mariadb.com/kb/en/grant/
-- You can create a user that has privileges similar to the default root accounts by executing the following:
CREATE USER 'admin'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY '123456' WITH GRANT OPTION;
-- A user account can grant the PROXY privilege for any other user account if the granter has the PROXY privilege 
-- for the ''@'%' anonymous user account, like this:
GRANT PROXY ON ''@'%' TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit