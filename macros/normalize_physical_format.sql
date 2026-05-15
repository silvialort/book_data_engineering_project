{% macro normalize_physical_format (columna) %}

    CASE 
        WHEN {{columna}} LIKE '%TAPA DURA%' 
        OR {{columna}}  LIKE '%HARDCOVER%' 
        OR {{columna}}  LIKE '%COPERTINA RIGIDA%'
        OR {{columna}}  LIKE '%LEATHER%'
        OR {{columna}} = 'LIBRARY BINDING'
        THEN 'TAPA DURA'


        WHEN {{columna}} LIKE '%BLANDA%'
        OR {{columna}} LIKE '%SOFTCOVER%'
        OR {{columna}} LIKE '%RÚSTICA%'
        OR {{columna}} LIKE '%RUSTICA%'
        OR {{columna}} LIKE '%RUSTICO%'
        OR {{columna}} LIKE '%TAPA BRANDA%'
        OR {{columna}} LIKE '%PAPERB%'        
        OR {{columna}} LIKE '%SOFTCOVER%'
        OR {{columna}} LIKE '%BROSSURA%'
        OR {{columna}} LIKE '%TRADE%'
        OR {{columna}} = 'BROCHÉ'      

        THEN 'TAPA BLANDA'

        WHEN {{columna}} LIKE '%BOLSILLO%'
        OR {{columna}} LIKE '%POCKET%'
        OR {{columna}} = 'TASCHENBUCH'

        THEN 'BOLSILLO'

        WHEN {{columna}} LIKE '%KINDLE%'
        OR {{columna}} LIKE '%ELECTRONIC%'
        OR {{columna}} LIKE '%ELECTRÓNICO%'
        OR {{columna}} LIKE '%EBOOK%'
        OR {{columna}} LIKE '%E-BOOK%'
        OR {{columna}} LIKE '%EPUB%'
        OR {{columna}} LIKE '%PDF%'
        OR {{columna}} LIKE '%DIGITAL%'
        OR {{columna}} LIKE '%ONLINE%'

        THEN 'EBOOK'

        WHEN {{columna}} LIKE '%CD%'
        THEN 'CD'

        WHEN {{columna}} LIKE '%STAPLE%'
        THEN 'GRAPADO'

        WHEN {{columna}} = 'AUDIOBOOK'
        THEN 'AUDIOLIBRO'

        WHEN {{columna}} LIKE '%RING%'
        OR {{columna}} LIKE '%SPIRAL%'
        THEN 'ANILLADO'

        WHEN {{columna}} LIKE '%BOARD BOOK%'
        OR {{columna}} LIKE '%FOAM BOOK%'
        THEN 'CARTONÉ'

        WHEN {{columna}} LIKE  '%LOOSE%'
        THEN 'HOJAS SUELTAS'
    
        WHEN {{columna}} LIKE '%POP%'
        OR {{columna}} LIKE '%DESPLEGABLE%'
        THEN 'LIBRO DESPLEGABLE'

        WHEN {{columna}} LIKE '%FLEXIBOUND%'
        OR {{columna}} = 'VINYL BOUND'
        THEN 'FLEXIBLE'

        WHEN {{columna}} = 'PAMPHLET'
        THEN 'FOLLETO'

        WHEN {{columna}} = 'BATH BOOK'
        OR {{columna}} = 'RAG BOOK'
        OR {{columna}} = 'NOVELTY BOOK'
        THEN 'LIBRO INFANTIL'

        ELSE {{columna}}


    END AS descripcion_formato

{% endmacro %}