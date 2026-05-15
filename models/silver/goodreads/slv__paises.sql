with source_editions as (
    select 
        distinct upper(trim(publish_country)) as pais 
    from
        {{ source('openlibrary', 'editions') }}
),

source_users as (
    select
        distinct upper(trim(country)) as pais
    from
        {{ source('goodreads', 'users_goodreads')}}
),

union_table as (
    select
        *
    from
        source_editions
    UNION
    select
        *
    from
        source_users
)

select 
    distinct 
    {{ dbt_utils.generate_surrogate_key(['pais']) }} as id_pais,
    pais
from
    union_table