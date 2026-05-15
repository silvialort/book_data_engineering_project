with 

source as (

    select
        distinct 
        key as original_key,
        subjects
    from
        {{ source('openlibrary', 'editions') }}
),

flatten_table as (
    select
        {{ clean_key('original_key') }} as id_edicion,
        TRIM(UPPER(f.value::string)) as genero
    from source, 
        {{ convert_array_to_rows('subjects') }} f
)

select 
    {{ dbt_utils.generate_surrogate_key(['id_edicion']) }} as id_edicion,
    {{ dbt_utils.generate_surrogate_key(['genero'])}} as id_genero
from 
    flatten_table



