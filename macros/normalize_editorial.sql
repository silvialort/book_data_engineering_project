{% macro normalize_editorial(publisher) %}

CASE
    WHEN {{publisher}} LIKE '%PENGUIN%' OR {{publisher}} LIKE '%RANDOM HOUSE%' THEN 'PENGUIN RANDOM HOUSE'
    WHEN {{publisher}} LIKE '%PLANETA%' THEN 'GRUPO PLANETA'
    WHEN {{publisher}} LIKE '%HARPERCOLLINS%' OR {{publisher}} LIKE '%HARPER COLLINS%' THEN 'HARPER COLLINS'
    WHEN {{publisher}} LIKE '%ANAYA%' THEN 'ANAYA'
    WHEN {{publisher}} LIKE '%SM%' THEN 'SM'
    ELSE
        {{publisher}}
END AS descripcion_editorial

{% endmacro %}