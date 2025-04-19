/****************************************************************** 
Query 2 - Storico prenotazioni

La query, per il cliente in input, elenca tutte le prenotazioni e 
biglietti registrati ed emessi per il cliente            
********************************************************************/

SET @cliente = 1;

select a.cod_cliente, a.cognome_cliente, a.nome_cliente, b.cod_prenotazione,
       ifnull(c.numero_biglietto, 'Solo prenotazione'), date(d.data_partenza), 
       i.tipologia_treno, i.cod_treno, i.numero_treno, g.nome_stazione partenza,
       time(l.ora_partenza), h.nome_stazione arrivo, time(m.ora_arrivo)
from cliente a, itinerario d, tratta e, posto_treno f , stazione g, 
     stazione h, treno i, percorso_treni l, percorso_treni m, prenotazione b 
left join biglietto c on b.cod_prenotazione = c.cod_prenotazione
where a.cod_cliente = @cliente
and   b.cod_cliente = a.cod_cliente
and   d.cod_itinerario = b.cod_itinerario
and   e.cod_itinerario = d.cod_itinerario
and   g.cod_stazione = e.cod_stazione_partenza
and   h.cod_stazione = e.cod_stazione_arrivo
and   f.cod_posto = e.cod_posto_treno
and   i.cod_treno = e.cod_treno
and   l.cod_treno = e.cod_treno
and   l.prg_fermata = e.prg_fermata_partenza
and   l.cod_stazione = e.cod_stazione_partenza
and   m.cod_treno = e.cod_treno
and   m.prg_fermata = e.prg_fermata_arrivo
and   m.cod_stazione = e.cod_stazione_arrivo
order by date(d.data_partenza), b.cod_prenotazione,
       ifnull(c.numero_biglietto, 'Solo prenotazione'), time(l.ora_partenza);
