CREATE SCHEMA infra;

CREATE TABLE infra.datacenters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);

CREATE TABLE infra.servers (
    id SERIAL PRIMARY KEY,
    hostname VARCHAR(100) NOT NULL UNIQUE,
    ip_address INET NOT NULL UNIQUE,
    datacenter_id INT REFERENCES infra.datacenters(id)
);

CREATE TABLE infra.admins (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE infra.services (
    id SERIAL PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    port INT CHECK (port > 0 AND port < 65536)
);

CREATE TABLE infra.incidents (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    severity VARCHAR(10) CHECK (severity IN ('LOW','MEDIUM','HIGH')),
    server_id INT REFERENCES infra.servers(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
