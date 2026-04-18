CREATE DATABASE IF NOT EXISTS   customers;

USE customers;

DROP TABLE IF EXISTS custormer_shop1;

CREATE TABLE  custormer_shop1 (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    fechaAlta DATE,
    PRIMARY KEY (id)
)CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


INSERT INTO custormer_shop1 (nombre, correo, telefono, fechaAlta) VALUES 
('Juan Pérez', 'juan.perez@email.com', '555-123-4567', '2024-01-15');

INSERT INTO custormer_shop1 (nombre, correo, telefono, fechaAlta) VALUES 
('María García', 'maria.garcia@email.com', '555-234-5678', '2024-02-20');

INSERT INTO custormer_shop1 (nombre, correo, telefono, fechaAlta) VALUES 
('Carlos López', 'carlos.lopez@email.com', '555-345-6789', '2024-03-10'),
('Ana Martínez', 'ana.martinez@email.com', '555-456-7890', '2024-01-05'),
('Luis Rodríguez', 'luis.rodriguez@email.com', '555-567-8901', '2024-02-28'),
('Laura Sánchez', 'laura.sanchez@email.com', '555-678-9012', '2024-04-01'),
('Pedro Gómez', 'pedro.gomez@email.com', '555-789-0123', '2024-03-15');