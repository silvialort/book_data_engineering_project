{% macro clean_datetime(columna) %}

    COALESCE(

        -- formato ISO: 2023-08-14
        TRY_TO_DATE({{ columna }}, 'YYYY-MM-DD'),

        -- formato DD/MM/YYYY
        TRY_TO_DATE({{ columna }}, 'DD/MM/YYYY'),

        -- formato Jun 30, 2091
        TRY_TO_DATE({{ columna }}, 'MON DD, YYYY'),

        -- formato Jun 02, 2022
        TRY_TO_DATE({{ columna }}, 'MON DD, YYYY'),

        -- formato Español: "Mayo de 2025"
        TRY_TO_DATE(
            REGEXP_REPLACE(
                REGEXP_REPLACE(
                    LOWER({{ columna }}),
                    'enero', 'jan'
                ),
                'febrero|marzo|abril|mayo|junio|julio|agosto|septiembre|octubre|noviembre|diciembre',
                CASE
                    WHEN LOWER({{ columna }}) LIKE '%febrero%' THEN 'feb'
                    WHEN LOWER({{ columna }}) LIKE '%marzo%' THEN 'mar'
                    WHEN LOWER({{ columna }}) LIKE '%abril%' THEN 'apr'
                    WHEN LOWER({{ columna }}) LIKE '%mayo%' THEN 'may'
                    WHEN LOWER({{ columna }}) LIKE '%junio%' THEN 'jun'
                    WHEN LOWER({{ columna }}) LIKE '%julio%' THEN 'jul'
                    WHEN LOWER({{ columna }}) LIKE '%agosto%' THEN 'aug'
                    WHEN LOWER({{ columna }}) LIKE '%septiembre%' THEN 'sep'
                    WHEN LOWER({{ columna }}) LIKE '%octubre%' THEN 'oct'
                    WHEN LOWER({{ columna }}) LIKE '%noviembre%' THEN 'nov'
                    WHEN LOWER({{ columna }}) LIKE '%diciembre%' THEN 'dec'
                END
            ) || '-01',
            'MON-YYYY-DD'
        )

    )

{% endmacro %}