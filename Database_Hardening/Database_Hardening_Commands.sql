CREATE USER 'webuser'@'localhost' IDENTIFIED BY 'StrongPassword123!';

GRANT SELECT, INSERT, UPDATE ON dvwa.* TO 'webuser'@'localhost';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'webuser'@'localhost';