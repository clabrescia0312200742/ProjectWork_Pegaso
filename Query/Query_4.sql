/****************************************************************** 
Query 4 - Elenco treni per tratta

La query, in funzione delle stazioni di partenza e arrivo in input, 
fornisce l'elenco di tutti i treni disponibili e relativi cambi, se 
necessari            
********************************************************************/

SET @stazione_partenza = 'Taranto';
SET @stazione_arrivo   = 'Brindisi';
select b.cod_treno, b.cod_stazione, b.ora_partenza partenza,
       a.nome_stazione, d.cod_treno, z.nome_stazione cambio, d.cod_stazione, 
       d.ora_arrivo arrivo, c.nome_stazione
from percorso_treni b, (select a.cod_stazione cod_stazione_partenza, a.nome_stazione
                        from stazione a
                        where a.nome_stazione = @stazione_partenza) a,
	 percorso_treni d, (select c.cod_stazione cod_stazione_arrivo, c.nome_stazione
                        from stazione c
                        where c.nome_stazione = @stazione_arrivo) c, 
                        stazione z
where b.cod_treno > 0 and b.prg_fermata > 0 and b.cod_stazione = a.cod_stazione_partenza
and d.cod_treno > 0 and d.prg_fermata > 0 and d.cod_stazione = c.cod_stazione_arrivo
and (( d.cod_treno = b.cod_treno
and d.prg_fermata > b.prg_fermata
and z.cod_stazione = c.cod_stazione_arrivo) or
(d.cod_treno <> b.cod_treno
and z.cod_stazione in (select f.cod_stazione -- Determina le coincidenze (cambi)
            from percorso_treni e, percorso_treni f  
            where e.cod_treno = b.cod_treno
            and f.cod_treno = d.cod_treno
            and e.cod_stazione = f.cod_stazione
            and time(e.ora_arrivo) < time(f.ora_partenza)
            and e.prg_fermata > b.prg_fermata
            and f.prg_fermata < d.prg_fermata)
and not exists(select 'x'  -- elimina utilizzo di cambi nei diretti
               from percorso_treni g
               where g.cod_treno = b.cod_treno
               and   g.cod_stazione = d.cod_stazione) 
))
order by partenza, arrivo;
