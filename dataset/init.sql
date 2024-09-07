/*
    This file is used to initialize the database with the necessary tables and data.
 */
CREATE DATABASE app;

\c app;

/* Tables */
CREATE TABLE accounts
(
    id         SERIAL PRIMARY KEY,
    username   VARCHAR(255) NOT NULL,
    password   VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE profiles
(
    id         SERIAL PRIMARY KEY,
    user_id    INT          NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name  VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* Views */

/* Relationships */
ALTER TABLE profiles
    ADD FOREIGN KEY (user_id)
        REFERENCES accounts (id);

/* Indexes */
ALTER TABLE accounts
    ADD UNIQUE (username);

/* Triggers */

/* Functions */

/* Procedures */

/* Data */
COPY accounts
    FROM '/docker-entrypoint-initdb.d/data/accounts.csv'
    DELIMITER ','
    CSV HEADER;

COPY profiles
    FROM '/docker-entrypoint-initdb.d/data/profiles.csv'
    DELIMITER ','
    CSV HEADER;

/* Roles */
CREATE ROLE admin;
CREATE ROLE client;

/* Permissions */
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO client;