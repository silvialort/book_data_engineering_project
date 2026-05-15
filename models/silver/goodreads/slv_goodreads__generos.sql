with 

source as (

    select 
        distinct TRIM(UPPER(gender)) as genero
    from 
        {{ source('goodreads', 'users_goodreads') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['genero']) }} as id_genero,
    genero
from 
    source