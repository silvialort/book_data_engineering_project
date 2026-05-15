with source as (
    select
        id_autor,
        nombre_autor,
        fecha_nacimiento,
        fecha_fallecimiento        
    from
        {{ ref("slv_openlibrary__autores") }}
    qualify row_number() over (
        partition by id_autor
            order by ol_last_modified desc
    ) = 1
)

select
    *
from
    source