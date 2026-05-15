with source as(
    select
        *
    from
        {{ ref("slv_openlibrary__formatos") }}    
)

select
    *
from
    source