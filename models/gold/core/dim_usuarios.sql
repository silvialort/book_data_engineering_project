with source as (
    select
        id_usuario,
        id_genero,
        edad,
        id_pais,
        id_provincia        
    from
        {{ ref("slv_goodreads__usuarios") }}    
)

select
    *
from
    source