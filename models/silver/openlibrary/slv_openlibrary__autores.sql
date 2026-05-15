with 

source as (

    select * from {{ source('openlibrary', 'authors') }}
),

clean_fields as (
    select
        {{ clean_key('original_key') }} as id_autor,
        UPPER(TRIM(name)) as nombre_autor,
        {{ normalize_year('birth_date') }} as fecha_nacimiento,
        {{ normalize_year('death_date') }} as fecha_fallecimiento,
        {{ clean_timestamp('ol_created_at') }} as ol_created_at,
        {{ clean_timestamp('ol_last_modified') }} as ol_last_modified,
        revision as revision
    from source
),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['id_autor']) }} as id_autor,
        nombre_autor,
        fecha_nacimiento,
        fecha_fallecimiento,
        ol_created_at,
        ol_last_modified,
        revision as revision
    from clean_fields

)

select * from renamed