with source_reviews as(

    select
        *
    from
        {{ ref("slv_goodreads__resenyas") }}    

),

source_editions as (
    select
        *
    from
        {{ ref("slv_openlibrary__ediciones") }}
),

source_users as (
    select
        *
    from
        {{ ref("dim_usuarios") }}
)



select
    r.id_resenya,
    r.id_usuario,
    r.isbn,
    r.valoracion,
    r.created_at,
    e.id_lengua_publicacion,
    e.id_formato,
    u.edad,
    u.id_pais,
    u.id_provincia,
    u.id_genero

from
    source_reviews r
    inner join source_editions e ON r.isbn = e.isbn
    inner join source_users u ON u.id_usuario = s.id_usuario
    