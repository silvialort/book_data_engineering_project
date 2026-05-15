with source as(

    select
        *
    from
        {{ ref("slv_openlibrary__ediciones") }}
    qualify row_number() over (
        partition by id_edicion
            order by ol_last_modified desc
    ) = 1

)

select 
    id_edicion,
    titulo,
    fecha_publicacion,
    id_formato,
    id_lengua_publicacion,
    id_serie,
    num_serie,
    isbn,
    id_pais,
    id_obra,
    id_traduccion
    
from source