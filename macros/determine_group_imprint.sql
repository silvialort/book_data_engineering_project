{% macro determine_group_imprint(publisher) %}

case
    when {{publisher}} like '%PENGUIN%'
        or {{publisher}} like '%PLANETA%'
        or {{publisher}} like '%HARPERCOLLINS%'
        or {{publisher}} like '%RANDOM HOUSE%'
        or {{publisher}} like '%ANAYA%'
        or {{publisher}} like '%SM%'
    then 'GRUPO EDITORIAL'
    else 'EDITORIAL'
end as rol_editorial

{% endmacro %}