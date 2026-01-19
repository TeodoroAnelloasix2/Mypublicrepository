CREATE DATABASE IF NOT EXISTS go_login;

USE go_login;

CREATE TABLE IF NOT EXISTS usuarios(
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(100) NOT NULL,
    cell varchar(50) NOT NULL,
    password varchar(255) NOT NULL,
    PRIMARY KEY (id)
)ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_unicode_ci;


INSERT INTO usuarios (nombre, cell, password)
VALUES
('User Test', '600123456', 'hashed_password_1');