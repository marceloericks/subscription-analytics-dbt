with subscriptions as (

    select
        subscription_id,
        customer_id,

        case
            when lower(plan) = 'basic'
                then 'Basic'

            when lower(plan) = 'pro'
                then 'Pro'

            else 'Enterprise'
        end as plan,

        case
            when lower(status) in ('canceled', 'cancelled')
                then 'cancelled'

            else 'active'
        end as status,

        try_cast(start_date as date) as start_date,

        try_cast(end_date as date) as end_date

    from {{ ref('raw_subscriptions') }}

),

deduplicated as (

    select *,
           row_number() over (
               partition by subscription_id
               order by start_date desc
           ) as rn
    from subscriptions

)

select
    subscription_id,
    customer_id,
    plan,
    status,
    start_date,
    end_date
from deduplicated
where rn = 1