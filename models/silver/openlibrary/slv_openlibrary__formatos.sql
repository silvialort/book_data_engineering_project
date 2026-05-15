with 

source as (

    select 
        distinct TRIM(UPPER(physical_format)) as physical_format
    from 
        {{ source('openlibrary', 'editions') }}
    where 
        physical_format is not null

),

renamed as (

    select 
        {{ normalize_physical_format('physical_format') }}
    from
        source
),

prepared as (

    select
        distinct        
        {{ dbt_utils.generate_surrogate_key(['descripcion_formato'])}} as id_formato, 
        descripcion_formato
    from 
        renamed
        

)

select * from prepared