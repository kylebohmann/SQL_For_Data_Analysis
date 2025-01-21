/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/


WITH top_paying_jobs AS
    (SELECT 
        job_id,
        name AS company_name,
        job_title,
        job_title_short,
        job_work_from_home,
        ROUND(salary_year_avg, 0) AS salary_year_avg
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10)   

SELECT 
    top_paying_jobs.job_id,
    company_name,
    job_title,
    salary_year_avg,
    skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;

/* I asked chatgpt to analyze the results of the query to see whcih skills showed up most often
in these high paying job postings and here is what it found:

The dataset contains columns for job_id, company_name, job_title, salary_year_avg, and skills. The skills column lists individual skills associated with these job postings. To determine which skills appear most frequently, I'll analyze the skills column. ​​

The most frequently mentioned skills in the dataset are:

SQL – 8 mentions
Python – 7 mentions
Tableau – 6 mentions
R – 4 mentions
Snowflake – 3 mentions
Pandas – 3 mentions
Excel – 3 mentions
Azure – 2 mentions
Bitbucket – 2 mentions
Go – 2 mentions
These are the skills most associated with the top-paying data analyst roles in this dataset. 
*/
