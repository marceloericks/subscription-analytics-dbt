select
    payment_id,

    customer_id,

    subscription_id,

    payment_date,

    amount,

    is_refund,

    case
        when is_refund = true then 0
        else amount
    end as net_revenue,

    case
        when amount < 50 then 'Low'
        when amount < 100 then 'Medium'
        else 'High'
    end as payment_tier

from {{ ref('stg_payments') }}