select
    customer_id,

    trim(customer_name) as customer_name,

    lower(trim(email)) as email,

    case
        when country is null
            then 'Unknown'

        when country in ('USA', 'US')
            then 'United States'

        when country = 'CA'
            then 'Canada'

        when country = 'UK'
            then 'United Kingdom'

        else country
    end as country,

    try_cast(signup_date as date) as signup_date

from {{ ref('raw_customers') }}