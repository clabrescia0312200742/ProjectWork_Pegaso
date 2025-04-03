/****************************************************************** 
Query 3 - Validità biglietto

La query, dato un biglietto in input, verifica la sua validità sia 
in termini di esistenza che temporale. La query altro non è che la
verifica che il sistema effettua nel processo di verifica del 
biglietto da parte del controllore di treno. In caso di biglietto
valido la query restituisce i dati anagrafici del cliente e i dati
della prenotazione            
********************************************************************/

SET @biglietto = 'PFY5V';
SET @treno = 23;
SET @dt_viaggio = date('2024-05-01');

select a.numero_biglietto, date(a.data_biglietto) dt_biglietto, a.canale_acquisto_biglietto,
       c.cognome_cliente, c.nome_cliente 
from biglietto a, prenotazione b, cliente c
where a.numero_biglietto = @biglietto
and   date(a.data_biglietto) = date(@dt_viaggio)
and   a.stato_biglietto = 'A'
and   b.cod_prenotazione = a.cod_prenotazione
and   c.cod_cliente = b.cod_cliente
and exists (select 'x'
			from tratta d
            where d.cod_itinerario = b.cod_itinerario
            and   d.cod_treno = @treno);
