{% macro normalize_year(columna) %}

    CASE
        -- 4 dígitos
        WHEN REGEXP_LIKE({{ columna }}, '^[0-9]{4}$')
            THEN TRY_TO_NUMBER({{ columna }})

        -- 4 dígitos + AD
        WHEN REGEXP_LIKE({{ columna }}, '^[0-9]{4}\s+AD$')
            THEN TRY_TO_NUMBER(REGEXP_SUBSTR({{ columna }}, '[0-9]{4}'))

        -- 4 dígitos + BC
        WHEN REGEXP_LIKE({{ columna }}, '^[0-9]{4}\s+BC$')
            THEN -TRY_TO_NUMBER(REGEXP_SUBSTR({{ columna }}, '[0-9]{4}'))

        -- Últimos 3 o 4 dígitos
        WHEN REGEXP_LIKE({{ columna }}, '[0-9]{3,4}$')
            THEN
                CASE
                    WHEN {{ columna }} ILIKE '%BC%'
                        THEN -TRY_TO_NUMBER(
                            REGEXP_SUBSTR({{ columna }}, '[0-9]{3,4}$')
                        )
                    ELSE
                        TRY_TO_NUMBER(
                            REGEXP_SUBSTR({{ columna }}, '[0-9]{3,4}$')
                        )
                END

        -- Fecha mal formateada, devolvemos null
        ELSE NULL
    END

{% endmacro %}