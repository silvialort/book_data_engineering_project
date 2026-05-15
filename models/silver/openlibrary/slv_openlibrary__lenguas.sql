with 

source as (

    select 
        distinct languages
    from 
        {{ source('openlibrary', 'editions') }}
    where 
        languages is not null

    union all

    select 
        distinct translated_from as languages
    from 
        {{ source('openlibrary', 'editions') }}
    where 
        translated_from is not null


),

renamed as (

    select        
        TRIM(UPPER(REGEXP_SUBSTR(f.value:key::string, '[^/]+$'))) as lengua
    from
        source,
    {{ convert_array_to_rows('languages') }} f
),

prepared as (

    select        
        distinct 
        {{ dbt_utils.generate_surrogate_key(['lengua'])}} as id_lengua_publicacion, 
        lengua as lengua_publicacion
    from 
        renamed
        

)

select * from prepared