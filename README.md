# Introduction 
This project comes via SQL for Data Analytics at (/https://lukebarousse.com/). In this project we are doing a dive into the data job market! We'll be focusing on data analyst positions with the goal of uncovering some insights about what are some of the top paying jobs, in-demand skills, and where high demand skills meet high paying salaries in data analytics. 

SQL queries: click here to view [project_sql](/project_sql/)

# Background
We want to answer a handful of questions about the job market for data analytics so that we can not only find a job in the data analytics world but we can also look to add skills that are highly valuable to employers. These are a list of questions we looked to answer:

**1. What are the top-paying data analyst jobs?**

**2. What skills are required for the top-paying data analyst jobs?**

**3. What are the most in-demand skills for data analysts?**

**4. What are the top skills based on salary?**

**5. What are the most optimal skills to learn as a Data Analyst?**

# Tools I Used
To do my dive into the data analyst job market I utilized the following analytics tools

**SQL:** The primary tool used to run my analysis. Allowed me to query across multiple datasets.

**PostgresSQL:** Preffered RDBMS used to run queries

**Visual Studio Code:** Preffered code editor to make edits to SQL scripts and view results

**Git & GitHub:**: Tool used to store and and version SQL query result and analysis. Also where I am posting final analysis documentation

# Analysis
My analysis was focused primarily on answering 5 questions about the data analyst job market. Listed below are the questions we want answered, How we wrote our SQL to answere those questions, and takeaways from the results. For some of our results we enlisted the help of ChatGPT to analyze the results to better identify trends in the data. 

**1. What are the top-paying data analyst jobs?**
```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

Here's the breakdown of the top data analyst jobs in 2023:

**Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.

**Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.

**Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

2. What skills are required for the top-paying data analyst jobs?
```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for data analysts in 2023, based on job postings:

SQL is leading with a bold count of 8.
Python follows closely with a bold count of 7.
Tableau is also highly sought after, with a bold count of 6.
Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.


[
](https://files.oaiusercontent.com/file-VPYhZYX2dPdvTF4pdYZEhf?se=2025-01-29T19%3A10%3A26Z&sp=r&sv=2024-08-04&sr=b&rscc=max-age%3D299%2C%20immutable%2C%20private&rscd=attachment%3B%20filename%3D7de0c5d4-a426-4fe6-ba84-4db8eead5ddf&sig=s5pobrQupVWiRJ4FnxxU8CjTxozzyuzncIuUt2ikSxA%3D)![image](https://github.com/user-attachments/assets/dfea8d3c-a2d4-4975-9bd3-b7c40b1549dc)


# Learnings

# Conclusions
