with source as (
    select
        id_obra,
        titulo_completo,
        idioma_original
        fecha_original_publicacion
    from
        {{ ref("slv_openlibrary__obras") }}
    qualify row_number() over (
        partition by id_obra
            order by ol_last_modified desc
    ) = 1
)

select
    *
from
    source