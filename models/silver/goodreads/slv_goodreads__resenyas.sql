with 

source as (

    select * from {{ source('goodreads', 'reviews') }}

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

select * from renamed