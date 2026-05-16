with source_reviews as(

    select
        *
    from
        {{ ref("slv_goodreads__resenyas") }}    

)

select
    id_resenya,
    id_usuario,
    isbn,
    valoracion,
    created_at
from
    source_reviews    
    