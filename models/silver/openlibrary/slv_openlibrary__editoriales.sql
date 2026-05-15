with 

source as (

    select 
        distinct TRIM(UPPER(publishers)) as publishers
    from 
        {{ source('openlibrary', 'editions') }}
    where publishers is not null

),

flatten_table as (
    select
        f.value::string as editorial 
    from source, 
    {{ convert_array_to_rows('publishers') }} f
),

roles as (
    select
        {{ normalize_editorial('editorial') }},
        {{ determine_group_imprint('editorial') }}
    from flatten_table
)


select
    distinct
    {{ dbt_utils.generate_surrogate_key(['descripcion_editorial']) }} as id_editorial,
    descripcion_editorial,
    rol_editorial
 from roles