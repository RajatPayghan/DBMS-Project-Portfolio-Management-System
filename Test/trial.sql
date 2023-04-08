SELECT
    ((tot_sum - (amt_sum * act_sum / _count)) / sqrt((amt_sum_sq - pow(amt_sum, 2.0) / _count) * (act_sum_sq - pow(act_sum, 2.0) / _count))) AS "Corr Coef Using Pearson"


FROM(
SELECT
    sum("Amount") AS amt_sum,
    sum("Activities") AS act_sum,
    sum("Amount" * "Amount") AS amt_sum_sq,
    sum("Activities" * "Activities") AS act_sum_sq,
    sum("Amount" * "Activities") AS tot_sum,
    count(*) as _count

FROM(
SELECT
    DATE_TRUNC('day', p.payment_date)::DATE AS "Day",
    SUM(p.amount) AS "Amount",
    COUNT(DISTINCT a.activity_id) AS "Activities"
FROM
    public.payments p
    INNER JOIN public.subscriptions s ON p.subscription_id = s.subscription_id
    INNER JOIN public.users u ON s.user_id = u.user_id
    INNER JOIN public.activity a ON a.user_id = u.user_id

GROUP BY 1) as a

) as b

GROUP BY tot_sum, amt_sum, act_sum, _count, amt_sum_sq, act_sum_sq


