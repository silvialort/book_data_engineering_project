with 

source as (

    select 
        * 
    from 
        {{ source('openlibrary', 'brz_openlibrary__editions_raw') }}
    where 
        isbn_13 is not null
    qualify row_number() over (
        partition by isbn_13
        order by last_modified desc
    ) = 1


),

clean_table as (

    select
        {{ clean_key('key') }} as id_edicion,
        UPPER(title) as titulo,
        UPPER(subtitle) as subtitulo,
        {{ clean_datetime('publish_date') }} AS fecha_publicacion,        
        CAST(number_of_pages AS INT) AS num_paginas,
        physical_dimensions,
        physical_format,
        {{ clean_key('languages') }} as lengua_publicacion,        
        publishers,
        series,
        REPLACE(isbn_13, '-', '') AS isbn,
        publish_places,
        publish_country,             
        weight,                              
        works,                
        translated_from, 
        {{ clean_timestamp('created') }} as ol_created_at,
        {{ clean_timestamp('last_modified') }} as ol_last_modified

    from source

)

select * from clean_table