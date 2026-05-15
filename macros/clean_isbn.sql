{% macro clean_isbn(isbn) %}

TRANSLATE(
    REPLACE(
        {{isbn}}, '-', ''
    ), '[]""', ''
)



{% endmacro %}