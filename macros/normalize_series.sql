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

COALESCE(

    TRY_TO_NUMBER(
        REGEXP_SUBSTR(
            {{ columna }},
            '\\(#\\s*(\\d+)\\s*\\)',
            1,
            1,
            'i',
            1
        )
    ),

    TRY_TO_NUMBER(
        REGEXP_SUBSTR(
            {{ columna }},
            '--\\s*(V\\.?|VOL\\.?|NO\\.?|Nº)?\\s*(\\d+)',
            1,
            1,
            'i',
            2
        )
    ),

    TRY_TO_NUMBER(
        REGEXP_SUBSTR(
            {{ columna }},
            '#\\s*(\\d+)',
            1,
            1,
            'i',
            1
        )
    ),

    TRY_TO_NUMBER(
        REGEXP_SUBSTR(
            {{ columna }},
            '(\\d+)\\s*$',
            1,
            1,
            'i',
            1
        )
    )

)


{% endif %}

{% endmacro %}