CREATE TABLE `app_percorrenza` (
  `num_treno` varchar(15) DEFAULT NULL,
  `progresivo` decimal(2,0) DEFAULT NULL,
  `nome_stazione` varchar(80) DEFAULT NULL,
  `ora_partenza` time DEFAULT NULL,
  `ora_arrivo` time DEFAULT NULL,
  `costo` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `app_posti` (
  `num_treno` decimal(10,0) NOT NULL,
  `posti_1_classe` decimal(3,0) DEFAULT NULL,
  `posti_2_classe` decimal(3,0) DEFAULT NULL,
  PRIMARY KEY (`num_treno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

