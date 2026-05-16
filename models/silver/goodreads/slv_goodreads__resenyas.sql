with 

source as (

    select * from {{ source('goodreads', 'reviews') }}
    
    {% if is_incremental() %}
        WHERE last_modified > (
            SELECT MAX(last_modified)
                FROM {{ this }}
        )
    {% endif %}
),

renamed as (

    select
        user_id,
        isbn,
        rating as valoracion,
        rating_description as descripcion_valoracion,
        publish_date as created_at,
        last_modified

    from source

)

select
    {{dbt_utils.generate_surrogate_key(['user_id', 'isbn', 'created_at'])}} as id_resenya,
    {{dbt_utils.generate_surrogate_key(['user_id'])}} as id_usuario,
    isbn,
    valoracion,    
    created_at,
    last_modified

 from renamed