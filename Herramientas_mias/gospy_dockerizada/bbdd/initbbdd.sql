CREATE DATABASE IF NOT EXISTS dbgospy;

USE dbgospy;

DROP TABLE IF EXISTS cpumodelnamegospy;

CREATE TABLE  cpumodelnamegospy(
    modelname VARCHAR(255) NOT NULL,
    idmodel INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (idmodel)
)CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



DROP TABLE IF EXISTS cpuinfogospy;

CREATE TABLE cpuinfogospy (
    idtable INT NOT NULL AUTO_INCREMENT,
    idmodel INT,
    modelname VARCHAR(255),
    procesor INT,
    cpumhz INT,
    cachesize VARCHAR(255),
    cpucores INT,
    coreid INT,
    PRIMARY KEY (idtable),
    CONSTRAINT fk_cpuinfo_modelname FOREIGN KEY (idmodel) REFERENCES cpumodelnamegospy (idmodel)
)CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP TABLE IF EXISTS raminfogospy;

CREATE TABLE raminfogospy (
    idtable INT NOT NULL AUTO_INCREMENT,
    unidadmedida VARCHAR(15),
    total VARCHAR(255),
    disponible VARCHAR(255),
    swaptotal VARCHAR(255),
    swaplibre VARCHAR(255),
    cache VARCHAR(255),
    swapcache VARCHAR(255),
    fecha DATETIME,
    PRIMARY KEY (idtable)
)CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
