insert into percorso_treni
select b.cod_treno, a.progresivo, a.cod_stazione, a.ora_partenza, a.ora_arrivo, a.costo
from app_percorrenza a, treno b
where b.numero_treno = a.num_treno;

commit;
