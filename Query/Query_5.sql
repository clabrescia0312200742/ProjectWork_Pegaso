/**********************************************************
Query 5 - Elenco treni e percorrenze
La query fornisce l'elenco completo dei treni con la 
percorrenza in termini di fermate, con gli orari di arrivo 
e partenza per ogni fermata
**********************************************************/

select a.tipologia_treno, a.numero_treno, a.nome_treno,
       b.prg_fermata, c.nome_stazione, b.ora_arrivo, b.ora_partenza
from treno a, percorso_treni b, stazione c
where a.cod_treno > 0
and b.cod_treno = a.cod_treno
and c.cod_stazione = b.cod_stazione
order by a.tipologia_treno, a.numero_treno, b.prg_fermata;