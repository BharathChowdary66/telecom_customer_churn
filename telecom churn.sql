--Basic Churn Rate
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND((SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END)::decimal / COUNT(*) * 100), 2) AS churn_rate_percentage
FROM "telecom churn";

--Churn by Gender
SELECT 
    "Gender",
    COUNT(*) AS total_users,
    SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END) AS churned,
    ROUND((SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END)::decimal / COUNT(*) * 100), 2) AS churn_percentage
FROM "telecom churn"
GROUP BY "Gender"
ORDER BY churn_percentage DESC;

--Churn by Contract Type
SELECT 
    "Contract",
    COUNT(*) AS total_users,
    SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END) AS churned,
    ROUND((SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END)::decimal / COUNT(*) * 100), 2) AS churn_rate
FROM "telecom churn"
GROUP BY "Contract"
ORDER BY churn_rate DESC;

--Churn Reason Frequency
SELECT 
    "Churn Reason",
    COUNT(*) AS frequency
FROM "telecom churn"
WHERE "Churn Value" = 1
GROUP BY "Churn Reason"
ORDER BY frequency DESC
LIMIT 10;

--Churn by Monthly Charges Bucket
SELECT 
    CASE 
        WHEN "Monthly Charges" < 30 THEN 'Low < $30'
        WHEN "Monthly Charges" BETWEEN 30 AND 70 THEN 'Medium $30-$70'
        ELSE 'High > $70'
    END AS billing_segment,
    COUNT(*) AS total_users,
    SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END) AS churned,
    ROUND((SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END)::decimal / COUNT(*) * 100), 2) AS churn_rate
FROM "telecom churn"
GROUP BY billing_segment
ORDER BY churn_rate DESC;

--Churn by Age Group (Based on Senior Citizen Flag)

SELECT 
    CASE 
        WHEN "Senior Citizen" = 'Yes' THEN 'Senior (60+)'
        ELSE 'Adult (<60)'
    END AS age_group,
    COUNT(*) AS total_users,
    SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END) AS churned_users,
    ROUND((SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END)::decimal / COUNT(*) * 100), 2) AS churn_rate
FROM "telecom churn"
GROUP BY age_group;

--Churn by State (Top 10 Worst)
SELECT 
    "State",
    COUNT(*) AS total_users,
    SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END) AS churned_users,
    ROUND((SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END)::decimal / COUNT(*) * 100), 2) AS churn_rate
FROM "telecom churn"
GROUP BY "State"
HAVING COUNT(*) > 50 -- avoid tiny groups
ORDER BY churn_rate DESC
LIMIT 10;

--Service-Based Churn (Internet Plans)
SELECT 
    "Internet Service",
    COUNT(*) AS total_users,
    SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END) AS churned,
    ROUND((SUM(CASE WHEN "Churn Value" = 1 THEN 1 ELSE 0 END)::decimal / COUNT(*) * 100), 2) AS churn_rate
FROM "telecom churn"
GROUP BY "Internet Service"
ORDER BY churn_rate DESC;

SELECT 
    "Churn Reason",
    COUNT(*) AS frequency
FROM "telecom churn"
WHERE "Churn Value" = 1
GROUP BY "Churn Reason"
ORDER BY frequency DESC;






