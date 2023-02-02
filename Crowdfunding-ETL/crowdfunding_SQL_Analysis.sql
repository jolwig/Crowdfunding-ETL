-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT COUNT(campaign.outcome), backers.cf_id
FROM campaign
INNER JOIN backers
ON backers.cf_id=campaign.cf_id
WHERE campaign.outcome = 'live'
GROUP BY backers.cf_id
ORDER BY COUNT(campaign.outcome) DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT * FROM backers;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT backers.first_name,
	backers.last_name,
	backers.email,
	campaign.goal - campaign.pledged as amount_left_to_raise
INTO email_contacts_remaining_goal
FROM backers
RIGHT JOIN campaign
ON Backers.cf_id = campaign.cf_id
WHERE campaign.outcome = 'live'
ORDER BY amount_left_to_raise DESC;

-- Check the table
DROP TABLE raise;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT backers.first_name,
	backers.last_name,
	backers.email,
	campaign.cf_id, 
	campaign.company_name,
	campaign.description,
	campaign.end_date,
	email_contacts_remaining_goal.amount_left_to_raise as Left_of_Goal
INTO email_backers_remaining_goal_amount
FROM backers
INNER JOIN campaign
ON backers.cf_id = campaign.cf_id
INNER JOIN email_contacts_remaining_goal
ON email_contacts_remaining_goal.email = backers.email
ORDER BY backers.email DESC;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;
