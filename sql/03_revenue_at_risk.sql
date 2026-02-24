WITH churn_risk AS (
    SELECT
        plan_tier,
        COUNT(*) AS total_customers,
        COUNT(churn_date) AS churned,
        SUM(mrr) AS total_mrr,
        SUM(CASE WHEN churn_date IS NOT NULL THEN mrr ELSE 0 END) AS lost_mrr,
        ROUND(AVG(last_login_days_ago), 1) AS avg_days_inactive
    FROM customers
    GROUP BY plan_tier
)
SELECT
    *,
    ROUND(churned::DECIMAL / total_customers * 100, 2) AS churn_rate_pct,
    RANK() OVER (ORDER BY lost_mrr DESC) AS revenue_risk_rank
FROM churn_risk;