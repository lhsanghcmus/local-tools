-- \set defines a variable in psql
\set temporal_password '''' :temporal_password ''''

-- Now use it in SQL
CREATE USER temporal WITH PASSWORD :temporal_password;
CREATE DATABASE temporal WITH OWNER temporal;
CREATE DATABASE temporal_visibility WITH OWNER temporal;
GRANT ALL PRIVILEGES ON DATABASE temporal TO temporal; 
GRANT ALL PRIVILEGES ON DATABASE temporal_visibility TO temporal;
