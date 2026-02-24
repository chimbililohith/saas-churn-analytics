CREATE TABLE customers_table (
    customer_id INT PRIMARY KEY,
    company_name VARCHAR(100),
    plan_tier VARCHAR(20),
    mrr DECIMAL(10,2),
    signup_date DATE,
    churn_date DATE,
    country VARCHAR(50),
    num_users INT,
    support_tickets INT,
    last_login_days_ago INT,
    nps_score INT
);