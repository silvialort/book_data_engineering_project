with source_resenyas as (
    select
        id_resenya,
        id_usuario,
        isbn,
        valoracion,
        created_at
    from
        {{ ref("fct_resenyas") }}
),

source_ediciones as (
    select
        id_edicion,    
        isbn
    from
        {{ ref("fct_tendencia_editorial") }}
),

bridge_generos as (
    select
        *
    from
        {{ ref("brg_ediciones_generos") }}
),

source_usuarios as(
    select
        id_usuario,
        id_genero,
        edad,
        id_pais
    from
        {{ ref("dim_usuarios") }}
),

join_tables as (
    select        
        u.id_pais,
        g.id_genero,
        count(r.id_resenya) as total_resenyas,
        avg(r.valoracion) as media_valoracion
    from
        source_resenyas r

    inner join 
        source_ediciones e ON e.isbn = r.isbn
    inner join 
        bridge_generos bg ON e.id_edicion = bg.id_edicion
    inner join 
        generos g ON bg.id_genero = g.id_genero
    inner join 
        usuarios u ON r.id_usuario = u.id_usuario
    group by
        u.id_pais, g.id_genero

)

select
    *
from
    join_tables