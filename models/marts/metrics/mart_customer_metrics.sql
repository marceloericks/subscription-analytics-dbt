with customer_revenue as (

    select
        customer_id,

        sum(net_revenue) as total_revenue,

        count(*) as payment_count,

        sum(
            case
                when is_refund = true then 1
                else 0
            end
        ) as refund_count

    from {{ ref('fct_payments') }}

    group by customer_id

),

customer_subscriptions as (

    select
        customer_id,

        plan,

        active_subscription_flag as is_active

    from {{ ref('fct_subscriptions') }}

    where active_subscription_flag = 1

)

select
    c.customer_id,

    c.customer_name,

    c.email,

    c.country,

    c.signup_date,

    coalesce(r.total_revenue, 0) as total_revenue,

    coalesce(r.payment_count, 0) as payment_count,

    coalesce(r.refund_count, 0) as refund_count,

    case
        when coalesce(r.payment_count, 0) = 0 then 0
        else round(r.total_revenue / r.payment_count, 2)
    end as average_payment_value,

    case
        when coalesce(r.payment_count, 0) = 0 then 0
        else round(r.refund_count * 1.0 / r.payment_count, 4)
    end as refund_rate,

    coalesce(s.is_active, 0) as is_active,

    s.plan

from {{ ref('dim_customers') }} c

left join customer_revenue r
    on c.customer_id = r.customer_id

left join customer_subscriptions s
    on c.customer_id = s.customer_id