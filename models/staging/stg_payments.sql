with payments as (

    select
        payment_id,

        subscription_id,

        customer_id,

        try_cast(payment_date as date) as payment_date,

        try_cast(amount as decimal(10,2)) as amount

    from {{ ref('raw_payments') }}

),

cleaned as (

    select
        payment_id,
        subscription_id,
        customer_id,
        payment_date,
        amount,

        case
            when amount < 0 then true
            else false
        end as is_refund

    from payments

    where customer_id is not null

)

select *
from cleaned