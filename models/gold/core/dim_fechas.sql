with dates as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2022-01-01' as date)",
        end_date="cast('2030-12-31' as date)"
    ) }}

),

final as (

    select
          date_day                                  as date
        , year(date_day)                            as year
        , month(date_day)                           as month
        , monthname(date_day)                       as month_name
        , day(date_day)                             as day
        , dayofweek(date_day)                       as number_week_day
        , dayname(date_day)                         as week_day
        , quarter(date_day)                         as quarter
        , weekiso(date_day)                         as week_of_year
        , year(date_day) * 100 + month(date_day)    as year_month
        , year(date_day) * 10000
            + month(date_day) * 100
            + day(date_day)                         as date_id
        , case
            when dayofweek(date_day) in (0, 6) then true
            else false
          end                                       as is_weekend

    from dates

)

select * from final