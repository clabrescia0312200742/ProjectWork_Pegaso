DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InserisciPostiTreno`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE train_num decimal(10);
    DECLARE first_class_seats decimal(3);
    DECLARE second_class_seats decimal(3);
    DECLARE conta_posti decimal(3);
    DECLARE codice_posto decimal(10);

    -- Dichiarazione del cursore per scorrere le righe di app_posti_treno
    DECLARE cur CURSOR FOR 
        SELECT num_treno, posti_1_classe, posti_2_classe FROM app_posti;

    -- Gestione della condizione di fine cursore
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Apertura del cursore
    OPEN cur;

    -- Inizio del ciclo per scorrere le righe
    SET codice_posto =1;

    read_loop: LOOP
        -- Lettura dei dati dalla riga corrente
        FETCH cur INTO train_num, first_class_seats, second_class_seats;

        -- Uscita dal ciclo se non ci sono più righe
        IF done THEN
            LEAVE read_loop;
        END IF;
        
		SET conta_posti = 1;
        WHILE conta_posti <= first_class_seats DO
            INSERT INTO posto_treno (cod_posto, classe_descrizione, numero_posto, cod_treno) 
            VALUES (codice_posto, 'Prima Classe', conta_posti, train_num); -- o qualsiasi altro tipo di posto
            SET conta_posti = conta_posti + 1;
            SET codice_posto = codice_posto + 1;
        END WHILE;
        
		SET conta_posti = 1;
        WHILE conta_posti <= second_class_seats DO
            INSERT INTO posto_treno (cod_posto, classe_descrizione, numero_posto, cod_treno) 
            VALUES (codice_posto, 'Seconda Classe', conta_posti, train_num); -- o qualsiasi altro tipo di posto
            SET conta_posti = conta_posti + 1;
            SET codice_posto = codice_posto + 1;
        END WHILE;

    END LOOP;

    -- Chiusura del cursore
    CLOSE cur;
    commit;
END$$
DELIMITER ;
