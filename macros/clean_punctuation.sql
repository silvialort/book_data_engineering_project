{% macro clean_punctuation(columna) %}

TRIM(
    REGEXP_REPLACE(
        {{ columna }},
        '[\\s\\.,;/:\\-–—]+$',
        ''
    )
)

{% endmacro %}