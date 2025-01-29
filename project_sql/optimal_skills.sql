/*
Question: What are the most optimal skills to learn as a Data Analyst?
    - look for skills that are both high paying and high in demand
     -Why? Skills high in demand and high in salary can lead to us getting a job more easily while 
     also commanding a higher salary.
*/

WITH skills_demand AS
    (SELECT 
        skills_job_dim.skill_id,
        skills,
        COUNT(job_postings_fact.job_id) skills_demand
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id,
        skills
    ORDER BY
        skills_demand DESC),

    skills_pay AS
    (SELECT
        skills_job_dim.skill_id AS skill_id,
        skills,
        ROUND(AVG(salary_year_avg), 2) average_skill_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id,
        skills)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.skills_demand,
    average_skill_salary
FROM skills_demand
INNER JOIN skills_pay ON skills_demand.skill_id = skills_pay.skill_id
ORDER BY
    skills_demand DESC,
    average_skill_salary DESC
 



