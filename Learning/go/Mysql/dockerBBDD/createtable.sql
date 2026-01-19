CREATE DATABASE IF NOT EXISTS DB1;

USE DB1;

DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    fechaAlta DATE,
    PRIMARY KEY (id)
)CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


INSERT INTO clientes (nombre, correo, telefono, fechaAlta) VALUES
('Laura Gomez', 'laura.gomez@example.com', '+34 612 345 678', '2024-12-01'),
('Carlos Ruiz', 'carlos.ruiz@example.com', '+34 611 222 333', '2025-01-15'),
('Mara Lopez', 'mara.lopez@example.com', '+34 610 999 888', '2025-06-07'),
('Javier Martínez', 'javier.martinez@example.com', '+34 613 777 444', '2024-11-20'),
('Ana Fernández', 'ana.fernandez@example.com', '+34 615 555 222', '2025-02-28');
