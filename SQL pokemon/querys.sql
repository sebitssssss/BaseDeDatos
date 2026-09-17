use liga_pokemon;

select ent.nombre,
       ent.apellido,
       ciu.nombre as ciudad,
       gim.nombre as gimnasio
from ent
inner join ciu on ciu.idciu = ent.idciu
inner join gim on gim.idgim = ent.idgim
order by ent.apellido, ent.nombre;

select pok.nombre as pokemon,
       tip.nombre as tipo
from pok
inner join tip on tip.idtip = pok.idtip
order by tip.nombre, pok.nombre;

select pok.nombre as pokemon,
       pok.nivel
from pok
where pok.nivel > 50
order by pok.nivel desc;

select pok.nombre as pokemon,
       pok.nivel,
       tip.nombre as tipo,
       ent.nombre as entrenador,
       ent.apellido
from pok
inner join tip on tip.idtip = pok.idtip
inner join ent on ent.ident = pok.ident
where tip.nombre = 'Fuego'
order by pok.nivel asc;

select pok.nombre as pokemon,
       pok.nivel
from pok
where pok.ident in (
        select ent.ident
        from ent
        where ent.idciu = (
                select ciu.idciu
                from ciu
                where ciu.nombre = 'Celadon'
        )
)
order by pok.nivel desc;

select pok.nombre as pokemon,
       pok.nivel
from pok
where pok.nivel > (
        select avg(nivel)
        from pok
)
order by pok.nivel desc;

select pok.nombre as pokemon,
       pok.nivel
from pok
where pok.idpok in (
        select bat.idganador
        from bat
)
order by pok.nombre;
