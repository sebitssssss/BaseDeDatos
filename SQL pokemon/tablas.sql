drop database if exists liga_pokemon;
create database liga_pokemon;
use liga_pokemon;

create table ciu (
    idciu int auto_increment primary key,
    nombre varchar(40) not null,
    region varchar(40) not null
);

create table lid (
    idlid int auto_increment primary key,
    nombre varchar(40) not null,
    apellido varchar(40) not null
);

create table gim (
    idgim int auto_increment primary key,
    nombre varchar(60) not null,
    idciu int not null,
    idlid int not null,
    constraint fk_gim_ciu foreign key (idciu) references ciu(idciu),
    constraint fk_gim_lid foreign key (idlid) references lid(idlid)
);

create table ent (
    ident int auto_increment primary key,
    nombre varchar(40) not null,
    apellido varchar(40) not null,
    fecha_nac date null,
    idciu int not null,
    idgim int not null,
    constraint fk_ent_ciu foreign key (idciu) references ciu(idciu),
    constraint fk_ent_gim foreign key (idgim) references gim(idgim)
);

create table tip (
    idtip int auto_increment primary key,
    nombre varchar(30) not null unique
);

create table pok (
    idpok int auto_increment primary key,
    nombre varchar(40) not null,
    nivel int not null default 1,
    idtip int not null,
    ident int not null,
    constraint fk_pok_tip foreign key (idtip) references tip(idtip),
    constraint fk_pok_ent foreign key (ident) references ent(ident)
);

create table bat (
    idbat int auto_increment primary key,
    fecha date not null,
    idpok1 int not null,
    idpok2 int not null,
    idganador int not null,
    constraint fk_bat_pok1 foreign key (idpok1) references pok(idpok),
    constraint fk_bat_pok2 foreign key (idpok2) references pok(idpok),
    constraint fk_bat_ganador foreign key (idganador) references pok(idpok)
);
