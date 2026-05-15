with source as(
    select
        *
    from
        {{ ref("slv_openlibrary__lenguas") }}    
)

select
    *
from
    source