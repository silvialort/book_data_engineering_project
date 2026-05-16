with 

source as (

    select 
        * 
    from 
        {{ source('openlibrary', 'editions') }}    
),

parse_series as (
    select
        distinct
        original_key,
        TRIM(UPPER(s.value::string)) as series
    from
        {{ source('openlibrary', 'editions') }},
        {{ convert_array_to_rows('series') }} s
    where series is not null
),

parse_lengua as (
    select
            distinct
            original_key,
            TRIM(UPPER(REGEXP_SUBSTR(l.value:key::string, '[^/]+$'))) as lengua_publicacion
        from
            {{ source('openlibrary', 'editions') }},
            {{ convert_array_to_rows('languages') }} l
    where languages is not null
),

parse_country as (
    select 
        distinct
        original_key,
        upper(trim(publish_country)) as pais
    from
        {{ source('openlibrary', 'editions') }}
    where publish_country is not null
),

parse_translated_from as (

    select
        distinct
        original_key,
        TRIM(UPPER(REGEXP_SUBSTR(t.value:key::string, '[^/]+$'))) as lengua_traduccion
    from
        {{ source('openlibrary', 'editions') }},
        {{ convert_array_to_rows('translated_from') }} t
    where translated_from is not null
),


clean_table as (

    select
        o.original_key as id,
        UPPER(title) as titulo,
        UPPER(subtitle) as subtitulo,
        {{ clean_datetime('publish_date') }} AS fecha_publicacion,
        CAST(number_of_pages AS INT) AS num_paginas,
        UPPER(TRIM('physical_format')) AS formato_fisico,
        TRIM((REGEXP_SUBSTR(l.lengua_publicacion, '[^/]+$'))) as lengua_publicacion,
        {{ normalize_series('s.series', 'name') }} as nombre_serie,
        {{ normalize_series('s.series', 'number') }} as num_serie,        
        {{ clean_isbn('isbn_13') }} AS isbn,            
        c.pais,
        {{ clean_key('works') }} as id_obra,         
        TRIM((REGEXP_SUBSTR(t.lengua_traduccion, '[^/]+$'))) as lengua_traduccion,        
        {{ clean_timestamp('created_at') }} as ol_created_at,
        {{ clean_timestamp('last_modified') }} as ol_last_modified,
        revision

    from source o
        left join parse_translated_from t ON t.original_key = o.original_key
        left join parse_series s ON s.original_key = o.original_key
        left join parse_lengua l ON l.original_key = o.original_key
        left join parse_country c ON c.original_key = o.original_key

),

surrogates as (
    select
        {{ dbt_utils.generate_surrogate_key(['id'])}} as id_edicion,
        titulo,
        subtitulo,
        CAST(fecha_publicacion AS TIMESTAMP_NTZ) as fecha_publicacion,
        num_paginas,        
        {{ normalize_physical_format('formato_fisico') }},
        {{ nullable_surrogate_key(['lengua_publicacion'])}} as id_lengua_publicacion,        
        {{ nullable_surrogate_key(['nombre_serie'])}} as id_serie,
        CAST(num_serie AS INT) as num_serie,        
        isbn,
        {{ nullable_surrogate_key(['pais'])}} as id_pais,    
        {{ nullable_surrogate_key(['id_obra'])}} as id_obra,
        {{ nullable_surrogate_key(['lengua_traduccion'])}} as id_traduccion,         
        ol_created_at,
        ol_last_modified,
        revision

    from clean_table
)

select 
    id_edicion,
    titulo,
    subtitulo,
    fecha_publicacion,
    num_paginas,
    {{ nullable_surrogate_key(['descripcion_formato']) }} as id_formato,
    id_lengua_publicacion,
    id_serie,
    num_serie,
    isbn,
    id_pais,
    id_obra,
    id_traduccion,
    ol_created_at,
    ol_last_modified,
    revision

from surrogates