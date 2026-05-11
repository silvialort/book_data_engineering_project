with 

source as (

    select * from {{ source('openlibrary', 'authors') }}    

),

clean_fields as (
    select
        {{ clean_key('id_autor') }} as id_autor,
        UPPER(TRIM(name)) as nombre_autor,
        {{ normalize_year('birth_date') }} as fecha_nacimiento,
        {{ normalize_year('death_date') }} as fecha_fallecimiento,
        {{ clean_timestamp('created_at') }} as ol_created_at,
        {{ clean_timestamp('last_modified') }} as ol_last_modified
    from source
),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['id_autor']) }} as id_autor,
        nombre_autor,
        fecha_nacimiento,
        fecha_fallecimiento,
        ol_created_at,
        ol_last_modified
    from clean_fields

)

select * from renamed