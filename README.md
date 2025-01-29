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
LIMIT 10;```

/*
Here's the breakdown of the top data analyst jobs in 2023:
Wide Salary Range: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
Diverse Employers: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
Job Title Variety: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.


# Learnings

# Conclusions
