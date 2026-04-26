/* QUESTION: What are the most optimal skills to learn ie(it's high in deman and a high-paying skill)?
-- Identify skills in high demand and associated with high average salaries for Data Scientist roles
-- Concentrate on remote job positions with specified salaries
--WHY? Target skills that offer job security(high demand) and financial benefits(high salaries),
    offering strategic insights for career development in Data Science
*/

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY 
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY 
     demand_count DESC,
    avg_salary DESC
   
   
LIMIT 25;