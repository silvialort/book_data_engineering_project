{% macro convert_array_to_rows(columna) %}

    LATERAL FLATTEN(
    input => PARSE_JSON({{columna}})
        
    )


{% endmacro %}