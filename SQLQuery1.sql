-- Table
SELECT * FROM Survey_Data_CSV

-- Count of respondents by department
SELECT Department, COUNT(*) AS 'No. of respondents' 
FROM Survey_Data_CSV 
GROUP BY Department;

-- Average job satisfaction and number of respondents by department
SELECT Department, 
       AVG(Job_satisfaction) AS 'Average job satisfaction', 
       COUNT(*) AS 'No. of respondents'
FROM Survey_Data_CSV 
GROUP BY Department;

-- Average work engagement by job level
SELECT Job_level, AVG(Work_engagement) FROM Survey_Data_CSV GROUP BY Job_level;

-- Correlation analysis between job satisfaction and compensation
WITH Stats AS (
    SELECT 
        COUNT(*) AS n,
        SUM(CAST(Job_satisfaction AS FLOAT)) AS sum_x,
        SUM(CAST(Compensation AS FLOAT)) AS sum_y,
        SUM(CAST(Job_satisfaction AS FLOAT) * CAST(Compensation AS FLOAT)) AS sum_xy,
        SUM(CAST(Job_satisfaction AS FLOAT) * CAST(Job_satisfaction AS FLOAT)) AS sum_xx,
        SUM(CAST(Compensation AS FLOAT) * CAST(Compensation AS FLOAT)) AS sum_yy
    FROM Survey_Data_CSV
    WHERE ISNUMERIC(Job_satisfaction) = 1 AND ISNUMERIC(Compensation) = 1
)
SELECT 
    (n * sum_xy - sum_x * sum_y) / 
    SQRT((n * sum_xx - sum_x * sum_x) * (n * sum_yy - sum_y * sum_y)) AS correlation_coefficient
FROM Stats;

-- No of employees in each job level
SELECT 
    Job_level,
    COUNT(*) AS Number_of_Employees
FROM 
    Survey_Data_CSV
GROUP BY 
    Job_level;

-- Job satisfaction by department and job level
SELECT 
    Department,
    Job_level,
    AVG(CAST(Job_satisfaction AS FLOAT)) AS Avg_Job_Satisfaction
FROM 
    Survey_Data_CSV
WHERE 
    ISNUMERIC(Job_satisfaction) = 1
GROUP BY 
    Department, Job_level
ORDER BY 
    Department, Job_level;

-- Job satisfaction for officers vs workman with number of respondents
SELECT 
    Officer_Workman,
    COUNT(*) AS No_of_Respondents,
    AVG(CAST(Job_satisfaction AS FLOAT)) AS Avg_Job_Satisfaction
FROM 
    Survey_Data_CSV
WHERE 
    ISNUMERIC(Job_satisfaction) = 1
GROUP BY 
    Officer_Workman;

-- Correlation between job satisfaction and work engagement
WITH Stats AS (
    SELECT 
        COUNT(*) AS n,
        SUM(CAST(Job_satisfaction AS FLOAT)) AS sum_x,
        SUM(CAST(Work_engagement AS FLOAT)) AS sum_y,
        SUM(CAST(Job_satisfaction AS FLOAT) * CAST(Work_engagement AS FLOAT)) AS sum_xy,
        SUM(CAST(Job_satisfaction AS FLOAT) * CAST(Job_satisfaction AS FLOAT)) AS sum_xx,
        SUM(CAST(Work_engagement AS FLOAT) * CAST(Work_engagement AS FLOAT)) AS sum_yy
    FROM Survey_Data_CSV
    WHERE ISNUMERIC(Job_satisfaction) = 1 AND ISNUMERIC(Work_engagement) = 1
)
SELECT 
    (n * sum_xy - sum_x * sum_y) / 
    SQRT((n * sum_xx - sum_x * sum_x) * (n * sum_yy - sum_y * sum_y)) AS correlation_coefficient
FROM Stats;


-- Analyze fairness of performance appraisal
SELECT 
    Performance_appraisal_fair,
    COUNT(*) AS Responses
FROM 
    Survey_Data_CSV
GROUP BY 
    Performance_appraisal_fair;

--Identify most requested future training topics
SELECT 
    Future_training_topics,
    COUNT(*) AS Number_of_Requests
FROM 
    Survey_Data_CSV
GROUP BY 
    Future_training_topics
ORDER BY 
    Number_of_Requests DESC;

-- Likelihood of employees recommending the company
SELECT 
    Recommendation,
    COUNT(*) AS Responses
FROM 
    Survey_Data_CSV
GROUP BY 
    Recommendation;

