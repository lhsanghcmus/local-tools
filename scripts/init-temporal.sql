-- Create temporal user
CREATE USER temporal WITH PASSWORD :'temporal_password';

-- Create temporal database with temporal user as owner
CREATE DATABASE temporal WITH OWNER temporal;

-- Grant necessary privileges to temporal user
GRANT ALL PRIVILEGES ON DATABASE temporal TO temporal; 