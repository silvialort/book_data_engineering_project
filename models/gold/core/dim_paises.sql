with source as(
    select
        *
    from
        {{ ref("slv__paises") }}
)

select
    *
from
    source