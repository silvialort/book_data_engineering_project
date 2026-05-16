with source as(
    select
        *
    from
        {{ ref("slv_openlibrary__generos") }}
)

select
    *
from
    source