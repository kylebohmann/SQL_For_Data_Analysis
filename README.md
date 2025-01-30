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
WHERE 
    skills_demand > 50 AND
    average_skill_salary > 90000
ORDER BY
    skills_demand DESC,
    average_skill_salary DESC
```

Here's a table summarizing the skills, their demand, and the corresponding average salary:  

| Skill ID | Skill        | Demand | Average Salary ($) |
|----------|-------------|--------|--------------------|
| 0        | SQL         | 3083   | 96,435.33         |
| 1        | Python      | 1840   | 101,511.85        |
| 182      | Tableau     | 1659   | 97,978.08         |
| 5        | R           | 1073   | 98,707.80         |
| 183      | Power BI    | 1044   | 92,323.60         |
| 186      | SAS         | 500    | 93,707.36         |
| 61       | SQL Server  | 336    | 96,191.42         |
| 79       | Oracle      | 332    | 100,964.19        |
| 74       | Azure       | 319    | 105,399.62        |
| 76       | AWS         | 291    | 106,439.84        |
| 8        | Go          | 288    | 97,266.97         |
| 215      | Flow        | 271    | 98,019.82         |
| 185      | Looker      | 260    | 103,855.35        |
| 80       | Snowflake   | 241    | 111,577.72        |
| 92       | Spark       | 187    | 113,001.94        |
| 22       | VBA         | 185    | 93,844.97         |
| 189      | SAP         | 183    | 92,446.21         |
| 9        | JavaScript  | 153    | 91,805.12         |
| 233      | Jira        | 145    | 107,931.30        |
| 97       | Hadoop      | 140    | 110,888.27        |
| 4        | Java        | 135    | 100,213.87        |
| 197      | SSRS        | 129    | 91,536.86         |
| 201      | Alteryx     | 124    | 105,579.57        |
| 2        | NoSQL       | 108    | 108,331.04        |
| 75       | Databricks  | 102    | 112,880.74        |
| 194      | SSIS        | 102    | 97,234.75         |
| 187      | Qlik        | 100    | 100,932.78        |
| 204      | Visio       | 99     | 101,035.82        |
| 141      | Express     | 96     | 108,221.35        |
| 93       | Pandas      | 90     | 110,767.07        |
| 78       | Redshift    | 90     | 107,968.80        |
| 15       | MATLAB      | 89     | 99,908.55         |
| 26       | C           | 89     | 98,714.56         |
| 77       | BigQuery    | 84     | 105,237.60        |
| 81       | GCP         | 78     | 113,065.48        |
| 184      | DAX         | 75     | 99,548.74         |
| 210      | Git         | 74     | 112,249.64        |
| 96       | Airflow     | 71     | 116,387.26        |
| 56       | MySQL       | 71     | 101,381.40        |
| 14       | C#          | 71     | 97,247.74         |
| 13       | C++         | 68     | 105,695.51        |
| 200      | Cognos      | 66     | 90,407.22         |
| 234      | Confluence  | 62     | 114,153.12        |
| 16       | T-SQL       | 60     | 95,722.65         |
| 3        | Scala       | 59     | 115,479.53        |
| 216      | GitHub      | 59     | 101,498.36        |
| 169      | Linux       | 58     | 114,883.20        |
| 94       | NumPy       | 54     | 107,397.56        |

When asking for what skills are most optimal we are looking at skills that are both high in demand and high in salary. From the results we can see that the most commond tools are SQL, Python, Tableau R and Power BI. Once you learn those you may see some additional benefit in salary by learning Spark, Snowflake, Databricks amongst others as they are higher in salary and still somewhat high in demand. 

# Learnings

**CTEs and Subquerries**: Use of temporary results sets and combining information allowed for some deeper insights into data analyst job market.

**ChatGPT**: ChatGPT was super useful in summarizing trends in the data and in creating visualizations. For example it was able to identify trends amongst the skills that are top paying and group them into categories. 

# Conclusions

From the questions we asked at the start of this project, here are my takeaways:

1) The top paying data analyst jobs can range anywhere from 184000 to 650000, while the majorits of salaries tend to be between 70000-100000. This indicates that at the top end of analysts there is a high level of compensation associated with data analyst positions.

2) For the top paying data analyst jobs the skills that come up most often are SQL, Tableau and Python. This indicates that even at the high end of data analyst jobs these foundational skills are still incredibly important

3) The most in demand skills for data analysts in general are SQL, Excel, Python, Tableau and PowerBI. From this we can takeaway that for those who are looking to get into data analytics these skills are going to be the most important as they have the highest number of employers listing them.

4) 
