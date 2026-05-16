{% snapshot resenyas_snapshot_timestamp %}

    {{
        config(
          target_schema='snapshots',
          unique_key='id_resenya',
          strategy='timestamp',
          updated_at='last_modified',
          hard_deletes='new_record'
        )
    }}

    select * from {{ ref('slv_goodreads__resenyas') }}

{% endsnapshot %}