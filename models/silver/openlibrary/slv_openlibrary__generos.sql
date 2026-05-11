with 

source as (

    select 
        distinct subjects 
    from 
        {{ source('openlibrary', 'brz_openlibrary__editions_raw') }}

),

renamed as (

    select        
        TRIM(UPPER(f.value::string)) as genero
    from
        source,
    {{ convert_array_to_rows('subjects') }} f

),

prepared as (

    select
        -- importante hacerlo aquí también porque al separar los subjects en nuevas rows se han podido generar duplicados 
        distinct 
        {{ dbt_utils.generate_surrogate_key(['genero'])}} as id_genero, 
        genero
    from 
        renamed
        

)

select * from prepared