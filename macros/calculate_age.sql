{% macro calculate_age(date_of_birth, as_of_date='CURRENT_DATE') %}

    DATEDIFF('YEAR', {{ date_of_birth }}, {{ as_of_date }})
    - CASE 
        WHEN DATEADD(
            'YEAR',
            DATEDIFF('YEAR', {{ date_of_birth }}, {{ as_of_date }}),
            {{ date_of_birth }}
        ) > {{ as_of_date }}
        THEN 1
        ELSE 0
    END

{% endmacro %}