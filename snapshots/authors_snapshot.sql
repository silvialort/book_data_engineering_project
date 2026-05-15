{% snapshot authors_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='id_autor',
        strategy='timestamp',
        updated_at='ol_last_modified'
    )
}}

select
    id_autor,
    nombre_autor,
    fecha_nacimiento,
    fecha_fallecimiento,
    ol_created_at,
    ol_last_modified
from 
    {{ ref('slv_openlibrary__autores') }}

{% endsnapshot %}