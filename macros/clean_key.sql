{% macro clean_key(columna) %}

    REGEXP_SUBSTR({{columna}}, 'OL[0-9]+[A-Z]')

{% endmacro %}