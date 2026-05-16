with source as (

    select distinct
        id_edicion,
        id_genero
    from {{ ref('slv_openlibrary__ediciones_generos') }}

),

final as (

    select
        id_edicion,
        id_genero
    from source

)

select 
    *
from 
    final