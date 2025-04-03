/****************************************************************** 
Query 7 - Elenco passeggeri tratta

La query, sulla base delle informazioni in input di stazione di 
partenza e stazione di arrivo e di data partenza, fornisce 
l’elenco di tutti i passeggeri che hanno un biglietto valido. 
Il biglietto è estratto ed è considerato nell’elenco se occupa 
il posto per l’intera tratta o anche solo parzialmente.          
********************************************************************/

SET @treno = 23;
SET @dt_viaggio = '2024-11-01';
SET @stazione_partenza = 'Bari Centrale';
--  SET @stazione_arrivo   = 'Milano Centrale';
SET @stazione_arrivo   = 'Firenze Santa Maria Novella';

select l.cod_treno, l.tipologia_treno, l.nome_treno, l.numero_treno, m.cod_posto, m.classe_descrizione, 
       m.numero_posto, r.nome_stazione stazione_partenza, n.cod_treno_2 codice_treno_cambio, 
       t.nome_stazione stazione_cambio, s.nome_stazione stazione_arrivo
from treno l, posto_treno m, stazione r, stazione s, stazione t,
	(select a.cod_treno cod_treno_1, a.prg_fermata, a.cod_stazione cod_stazione_par_1, c.cod_treno cod_treno_2, 
			c.cod_stazione cod_stazione_arr_2, c.prg_fermata prg_arr_2_tratto, f.prg_fermata prg_par_2_tratto, 
			f.cod_stazione cod_stazione_arr_1, e.prg_fermata prg_arr_1_tratto
	from percorso_treni a, stazione b, percorso_treni c, stazione d, percorso_treni e, percorso_treni f
	where (b.nome_stazione = @stazione_partenza and d.nome_stazione = @stazione_arrivo
	and a.cod_stazione = b.cod_stazione and c.cod_stazione = d.cod_stazione
	and a.cod_treno <> c.cod_treno and e.cod_treno = a.cod_treno and f.cod_treno = c.cod_treno
	and exists (select 'x' from percorso_treni h
				where h.cod_treno = a.cod_treno	and h.cod_stazione = e.cod_stazione)
	and exists (select 'x' from percorso_treni i
				where i.cod_treno = c.cod_treno and i.cod_stazione = f.cod_stazione)
	and e.cod_stazione = f.cod_stazione and time(e.ora_arrivo) < time(f.ora_partenza)
	and e.prg_fermata > a.prg_fermata and f.prg_fermata < c.prg_fermata
	and not exists(select 'x'  
				   from percorso_treni g
				   where g.cod_treno = a.cod_treno and g.cod_stazione = c.cod_stazione))
	or               
	((b.nome_stazione = @stazione_partenza and d.nome_stazione = @stazione_arrivo
	and a.cod_stazione = b.cod_stazione and c.cod_stazione = d.cod_stazione
	and a.cod_treno = c.cod_treno and a.prg_fermata < c.prg_fermata
	and e.cod_treno = a.cod_treno and f.cod_treno = a.cod_treno
	and f.prg_fermata = a.prg_fermata and e.cod_treno = c.cod_treno
	and e.prg_fermata = c.prg_fermata))) n
where n.cod_treno_1 = @treno and l.cod_Treno = n.cod_treno_1
and m.cod_treno = l.cod_Treno 
and not exists (select 'x' from tratta o, itinerario p, prenotazione q, biglietto u
            where o.cod_treno = @treno and o.cod_posto_treno = m.cod_posto
            and ((n.prg_fermata < o.prg_fermata_partenza and n.prg_arr_1_tratto <= o.prg_fermata_arrivo and 
                                                     n.prg_arr_1_tratto >= o.prg_fermata_partenza) 
			    or
                 (n.prg_fermata >= o.prg_fermata_partenza and n.prg_arr_1_tratto <= o.prg_fermata_arrivo and 
                            n.prg_fermata < o.prg_fermata_arrivo and n.prg_arr_1_tratto > o.prg_fermata_partenza) 
				or
                 (n.prg_fermata >= o.prg_fermata_partenza and n.prg_arr_1_tratto > o.prg_fermata_arrivo and 
                                                    n.prg_fermata <= o.prg_fermata_arrivo))
			 and p.cod_itinerario = o.cod_itinerario and date(p.data_partenza)= date(@dt_viaggio)
             and q.cod_itinerario = p.cod_itinerario and u.cod_prenotazione = q.cod_prenotazione
             and u.stato_biglietto = 'A')
and r.cod_stazione = n.cod_stazione_par_1 and s.cod_stazione = n.cod_stazione_arr_2
and t.cod_stazione = n.cod_stazione_arr_1
order by r.nome_stazione, s.nome_stazione, n.cod_treno_2, m.classe_descrizione, m.numero_posto;
