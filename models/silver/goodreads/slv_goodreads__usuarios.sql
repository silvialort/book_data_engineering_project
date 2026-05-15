with 

source as (

    select
        id_user, 
        email, 
        UPPER(TRIM(gender)) AS gender,
        country,
        age,        
        UPPER(TRIM(province)) as province
    from
        {{ source('goodreads', 'users_goodreads') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['email']) }} as id_usuario,	    
        {{ dbt_utils.generate_surrogate_key(['gender']) }} as id_genero,
	    CAST(age AS INT) as edad,
	    {{ dbt_utils.generate_surrogate_key(['country']) }} as id_pais,
	    {{ dbt_utils.generate_surrogate_key(['province']) }} as id_provincia,
	    email,
        id_user as original_id

    from source

)

select * from renamed