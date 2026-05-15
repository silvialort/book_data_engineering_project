with 

source as (

    select 
        distinct series
    from 
        {{ source('openlibrary', 'editions') }}
    where 
        series is not null

),

renamed as (

    select 
        TRIM(UPPER(f.value::string)) as serie
    from
        source,
    {{ convert_array_to_rows('series') }} f
),

normalize_series as( 

    select
        {{ normalize_series('serie', 'name') }} as nombre_serie
    from renamed

),

clean_table as (
    select
        {{ clean_punctuation('nombre_serie') }} as nombre_serie
    from normalize_series
)

select distinct 
    {{ dbt_utils.generate_surrogate_key(['nombre_serie']) }} as id_serie,
    nombre_serie
from 
    clean_table