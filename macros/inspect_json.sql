{% macro inspect_json(columna, origen, tabla) %}

with source as ( 
    select 
        {{ columna }} 
    from 
        {{ source(origen, tabla) }} 
), 

flattened as ( 
    select 
        ed.path, 
        ed.key, 
        typeof(ed.value) as type_data, 
        ed.value 
    from 
        source, 
        lateral flatten( input => {{ columna }}, recursive => true ) ed 
) 
        
select 
    distinct 
    path, 
    key, 
    type_data 
from 
    flattened 
order by 
    path 
    
{% endmacro %}