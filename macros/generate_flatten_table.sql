{% macro generate_flatten_table(columna, fields, origen, tabla) %}

select
{% for field in fields %}
    {{ columna }}:{{ field.name }}::{{ field.type }} as 
        {% if field.output_name %}
            {{ field.output_name }}
        {% else %}
            {{ field.name }}
        {% endif %}
    {% if not loop.last %},{% endif %}
{% endfor %}

from {{ source(origen, tabla) }}

{% endmacro %}