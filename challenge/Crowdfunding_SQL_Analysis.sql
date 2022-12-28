-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

SELECT cmp.backers_count, cmp.cf_id, cmp.outcome
FROM campaign as cmp
WHERE (cmp.outcome = 'live')
ORDER BY cmp.backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

SELECT COUNT(b.backer_id), b.cf_id
FROM backers as b
GROUP BY b.cf_id
ORDER BY COUNT(b.cf_id) DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT c.first_name, c.last_name, c.email, (cmp.goal - cmp.pledged) as remaining_goal_amount
INTO email_contacts_remaining_goal_amount
FROM campaign as cmp
INNER JOIN contacts as c
ON (cmp.contact_id = c.contact_id)
WHERE (cmp.outcome = 'live')
ORDER BY remaining_goal_amount DESC;

-- Check the table

SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT b.email, b.first_name, b.last_name, cmp.cf_id, cmp.company_name, cmp.description, (cmp.goal - cmp.pledged) as left_of_goal 
INTO email_backers_remaining_goal_amount
FROM campaign as cmp
INNER JOIN backers as b
ON (cmp.cf_id = b.cf_id)
WHERE (cmp.outcome = 'live')
ORDER BY b.last_name, b.email;

-- Check the table

SELECT * FROM email_backers_remaining_goal_amount;

