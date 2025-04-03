update treno a
set a.posti_1_classe = (select count(b.cod_posto)
                      from posto_treno b
                      where b.cod_treno = a.cod_treno
                      and b.classe_descrizione = 'Prima classe')
where a.cod_treno > 0
and exists (select 'x'
                      from posto_treno b
                      where b.cod_treno = a.cod_treno
                      and b.classe_descrizione = 'Prima classe');



update treno a
set a.posti_2_classe = (select count(b.cod_posto)
                      from posto_treno b
                      where b.cod_treno = a.cod_treno
                      and b.classe_descrizione = 'Seconda classe')
where a.cod_treno > 0
and exists (select 'x'
                      from posto_treno b
                      where b.cod_treno = a.cod_treno
                      and b.classe_descrizione = 'Seconda classe');
                      
commit;

