with 

source as (

    select
        distinct 
        original_key,
        authors
    from
        {{ source('openlibrary', 'works') }}        
),

flatten_table as (
    select
        {{ clean_key('original_key') }} as id_obra,
        f.value:author:key::string as autor
    from source, 
        {{ convert_array_to_rows('authors') }} f
),

clean_data as (
    select
        {{ dbt_utils.generate_surrogate_key(['id_obra']) }} as id_obra,
        {{ clean_key('autor') }} as original_autor_key
    from flatten_table
)


select 
    id_obra,
    {{ dbt_utils.generate_surrogate_key(['original_autor_key']) }} as id_autor
from 
    clean_data


