select
    subscription_id,

    customer_id,

    plan,

    status,

    start_date,

    end_date,

    case
        when status = 'active' then 1
        else 0
    end as active_subscription_flag

from {{ ref('stg_subscriptions') }}