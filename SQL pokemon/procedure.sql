use liga_pokemon;

delimiter $$

create procedure subir_nivel_entrenador (in id_entrenador int, in puntos int)
begin
    update pokemon
    set pokemon.nivel = pokemon.nivel + puntos
    where pokemon.IDentrenador = id_entrenador;
end$$

create procedure registrar_batalla (in id_pokemon1 int, in id_pokemon2 int, in fecha_batalla date)
begin
    declare nivel_uno int;
    declare nivel_dos int;
    declare id_ganador int;

    select pokemon.nivel into nivel_uno
    from pokemon
    where pokemon.IDpokemon = id_pokemon1;

    select pokemon.nivel into nivel_dos
    from pokemon
    where pokemon.IDpokemon = id_pokemon2;

    if nivel_uno >= nivel_dos then
        set id_ganador = id_pokemon1;
    else
        set id_ganador = id_pokemon2;
    end if;

    insert into batalla (fecha, IDpokemon1, IDpokemon2, IDganador)
    values (fecha_batalla, id_pokemon1, id_pokemon2, id_ganador);

    update pokemon
    set pokemon.nivel = pokemon.nivel + 2
    where pokemon.IDpokemon = id_ganador;
end$$

delimiter ;

call subir_nivel_entrenador(1, 5);

call registrar_batalla(3, 11, '2025-06-01');
