/****************************************************************** 
Query 1 - Biglietti disponibili

La query, dato uno specifico treno e una data, elenca i posti 
disponibili in funzione del totale dei posti presenti sul treno e 
quelli occupati attraverso l'acquisto dei biglietti            
********************************************************************/

SET @treno = 23;
SET @dt_viaggio = '2024-11-01';

select c.cod_treno, c.tipologia_treno, c.numero_treno, c.nome_treno, date(@dt_viaggio),
       c.posti_1_classe totali_1_classe, ifnull(z.occupati_1_classe,0) occupati_1, 
       c.posti_2_classe totali_2_classe, ifnull(z.occupati_2_classe,0) occupati_2
from treno c
left join (
select b.cod_treno, count(e.cod_posto) occupati_1_classe, count(f.cod_posto) occupati_2_classe
from itinerario a, prenotazione g, biglietto h, tratta b
left join posto_treno e on b.cod_treno = e.cod_treno and b.cod_posto_treno = e.cod_posto 
                                         and e.classe_descrizione='Prima Classe'
left join posto_treno f on b.cod_treno = f.cod_treno and b.cod_posto_treno = f.cod_posto 
                                         and f.classe_descrizione='Seconda Classe'
where a.cod_itinerario = b.cod_itinerario
and   date(a.data_partenza) = date(@dt_viaggio)
and   g.cod_itinerario = a.cod_itinerario
and   h.cod_prenotazione = g.cod_prenotazione
group by b.cod_treno) z on c.cod_treno = z.cod_treno
where c.cod_treno = @treno
order by 2, 3, 1;
