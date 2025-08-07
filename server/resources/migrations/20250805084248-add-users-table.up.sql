CREATE TABLE users
(id VARCHAR(20) PRIMARY KEY,
 user_name VARCHAR(60),
 email VARCHAR(60),
 admin BOOLEAN,
 last_login TIMESTAMP,
 is_active BOOLEAN,
 pass VARCHAR(300));
