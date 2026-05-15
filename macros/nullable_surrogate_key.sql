{% macro nullable_surrogate_key(id) %}

    CASE
        WHEN {{ id[0] }} IS NULL THEN NULL
        ELSE {{ dbt_utils.generate_surrogate_key(id) }}
    END

{% endmacro %}