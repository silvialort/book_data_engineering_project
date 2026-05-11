with 

source as (

    select * from {{ source('openlibrary', 'works') }}

),

clean_table as (

    select
        {{ clean_key('key') }} as id_obra,
        UPPER(title) as titulo,
        UPPER(subtitle) as subtitulo,                        
        {{ clean_key('original_languages') }} as idioma_original,        
        {{ normalize_year('first_publish_date') }} as fecha_original_publicacion,
        {{ clean_timestamp('created_at') }} as ol_created_at,
        {{ clean_timestamp('last_modified') }} as ol_last_modified

    from source

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['id_obra']) }} as id_obra,
        CASE 
            WHEN subtitulo IS NOT NULL THEN CONCAT(titulo, ': ' , subtitulo) 
            ELSE titulo
        END AS titulo_completo,
        idioma_original,        
        fecha_original_publicacion,
        ol_created_at,
        ol_last_modified

    from clean_table

)



select * from renamed