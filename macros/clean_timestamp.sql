{% macro clean_timestamp(columna) %}

    CAST(
        REGEXP_SUBSTR(
            {{columna}}, '"value":"([^"]+)"', 1, 1, 'e', 1
        ) 
    AS TIMESTAMP_NTZ)

{% endmacro %}