{% macro normalize_series(columna, valor = 'name') %}

{% if valor == 'name' %}

TRIM(
    REGEXP_REPLACE(
        REGEXP_REPLACE({{ columna }}, '\\s*\\(#\\s*\\d+\\s*\\)\\s*$', ''),
        '\\s*(--\\s*(V\\.?|VOL\\.?|NO\\.?|Nº)?\\s*\\d+|#\\s*\\d+|\\d+\\s*$)',
        ''
    )
)

{% elif valor == 'number' %}

TRY_TO_NUMBER(
    REGEXP_SUBSTR(
        {{ columna }},
        '(\\(#\\s*\\d+\\s*\\)|--\\s*(V\\.?|VOL\\.?|NO\\.?|Nº)?\\s*\\d+|#\\s*\\d+|\\b\\d+\\s*$)',
        1,
        1,
        'i',
        2
    )
)

{% endif %}

{% endmacro %}