CREATE TABLE `app_posti` (
  `num_treno` decimal(10,0) NOT NULL,
  `posti_1_classe` decimal(3,0) DEFAULT NULL,
  `posti_2_classe` decimal(3,0) DEFAULT NULL,
  PRIMARY KEY (`num_treno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into app_posti values (1, 100,300);
insert into app_posti values (2, 80,250);
insert into app_posti values (3, 20,150);
insert into app_posti values (4, 30,200);
insert into app_posti values (5, 10,100);
insert into app_posti values (6, 100,300);
insert into app_posti values (7, 80,250);
insert into app_posti values (8, 20,150);
insert into app_posti values (9, 30,200);
insert into app_posti values (10, 10,100);
insert into app_posti values (11, 100,300);
insert into app_posti values (12, 10,100);
insert into app_posti values (13, 30,200);
insert into app_posti values (14, 10,100);
insert into app_posti values (15, 100,300);
insert into app_posti values (16, 80,250);
insert into app_posti values (17, 10,100);
insert into app_posti values (18, 30,200);
insert into app_posti values (19, 10,100);
insert into app_posti values (20, 100,300);
insert into app_posti values (21, 80,250);
insert into app_posti values (22, 10,100);
insert into app_posti values (23, 30,200);
insert into app_posti values (24, 100,300);
insert into app_posti values (25, 80,250);
insert into app_posti values (26, 10,100);
insert into app_posti values (27, 30,200);
insert into app_posti values (28, 100,300);
insert into app_posti values (29, 80,250);
insert into app_posti values (30, 10,100);

commit;
