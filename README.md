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

**2. What skills are required for the top-paying data analyst jobs?**
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

**3. What are the most in-demand skills for data analysts?**

```sql
SELECT
    skills,
    COUNT(job_postings_fact.job_id) skills_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    skills
ORDER BY 
    skills_count DESC
LIMIT 5
```

| Skill     | Count  |
|-----------|--------|
| SQL       | 92,628 |
| Excel     | 67,031 |
| Python    | 57,326 |
| Tableau   | 46,554 |
| Power BI  | 39,468 | 

The results above show us that SQL,Excel,Python,Tableau and Power BI are the most in demand skills for Data Analysts

**4. What are the top skills based on salary?**

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) AS average_skill_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    average_skill_salary DESC
LIMIT 25
```

[
](https://files.oaiusercontent.com/file-8VW4Uok713YmZHU5amz1UE?se=2025-01-29T19%3A37%3A50Z&sp=r&sv=2024-08-04&sr=b&rscc=max-age%3D299%2C%20immutable%2C%20private&rscd=attachment%3B%20filename%3Dc6a66776-da0f-4ebb-a677-ef673b947abd&sig=v8Hqxk/M6ZgnBIhPwF/BCgoB79evNqbNYFmDrw4KjDo%3D)![image](https://github.com/user-attachments/assets/f7b4c512-18d9-440b-8f04-4dbfaad11b23)

Some notable trends in the results are (provided by ChatGPT):

1. AI & Machine Learning Expertise
   Tensorflow,Datarobot,MxNet
   
2. Data Engineering & Big Data Tools
   Kafka, Cassandra, Airflow, Dplyr
   
3. DevOps & Cloud Infrastructure
   Terraform, VMware, GitLab, Atlassian
   
4. Programming & Scripting Languages
   Golang, Perl, Scala

**5. What are the most optimal skills to learn as a Data Analyst?**

```sql
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
```


# Learnings


# Conclusions
