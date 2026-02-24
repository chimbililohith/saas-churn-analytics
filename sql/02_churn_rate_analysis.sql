WITH monthly_cohorts AS (
    SELECT
        DATE_TRUNC('month', signup_date) AS cohort_month,
        COUNT(customer_id) AS total_customers,
        COUNT(churn_date) AS churned_customers
    FROM customers
    GROUP BY 1
)
SELECT
    cohort_month,
    total_customers,
    churned_customers,
    ROUND(churned_customers::DECIMAL / total_customers * 100, 2) AS churn_rate_pct,
    ROUND(
        AVG(churned_customers::DECIMAL / total_customers * 100)
        OVER (ORDER BY cohort_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
    2) AS rolling_3m_churn
FROM monthly_cohorts
ORDER BY cohort_month;