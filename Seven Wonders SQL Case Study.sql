CREATE DATABASE IF Not Exists seven_wonders_db;

USE seven_wonders_db;

-- 1) Wonders Table (7 rows)
	CREATE TABLE wonders (
		wonder_id INT PRIMARY KEY,
		wonder_name VARCHAR(100),
		location VARCHAR(100),
		year_built VARCHAR(20),
		category VARCHAR(50)
	);
    
    INSERT INTO wonders (wonder_id, wonder_name, location, year_built, category) VALUES
	(1, 'Great Wall of China', 'China', '700 BC', 'Ancient'),
	(2, 'Christ the Redeemer', 'Brazil', '1931', 'Modern'),
	(3, 'Machu Picchu', 'Peru', '1450', 'Ancient'),
	(4, 'Chichen Itza', 'Mexico', '600 AD', 'Ancient'),
	(5, 'Roman Colosseum', 'Italy', '80 AD', 'Ancient'),
	(6, 'Taj Mahal', 'India', '1648', 'Medieval'),
	(7, 'Petra', 'Jordan', '312 BC', 'Ancient');
    
    SELECT * FROM wonders;
    
-- 2) Visiters Table (20 rows)
	CREATE TABLE visitors (
		visit_id INT PRIMARY KEY AUTO_INCREMENT,
		wonder_id INT,
		year INT,
		annual_visitors DECIMAL(5,2),
		FOREIGN KEY (wonder_id) REFERENCES wonders(wonder_id)
	);
    
    INSERT INTO visitors (wonder_id, year, annual_visitors) VALUES
	(1, 2023, 10.0), (1, 2022, 9.5), (1, 2021, 8.7),
	(2, 2023, 2.0), (2, 2022, 1.9), (2, 2021, 1.8),
	(3, 2023, 1.5), (3, 2022, 1.6), (3, 2021, 1.4),
	(4, 2023, 2.6), (4, 2022, 2.4), (4, 2021, 2.3),
	(5, 2023, 7.6), (5, 2022, 7.1), (5, 2021, 6.9),
	(6, 2023, 8.0), (6, 2022, 7.8), (6, 2021, 7.5),
	(7, 2023, 1.0), (7, 2022, 0.9);
    
    SELECT * FROM visitors;
    
    -- 3)Countries Table (7 rows)
	CREATE TABLE countries (
		country_id INT PRIMARY KEY,
		country_name VARCHAR(100),
		continent VARCHAR(50)
	);
    
    INSERT INTO countries (country_id, country_name, continent) VALUES
	(1, 'China', 'Asia'),
	(2, 'Brazil', 'South America'),
	(3, 'Peru', 'South America'),
	(4, 'Mexico', 'North America'),
	(5, 'Italy', 'Europe'),
	(6, 'India', 'Asia'),
	(7, 'Jordan', 'Asia');
    
    SELECT * FROM countries ;
    
    -- 4)Reviews Table (15 rows)
	CREATE TABLE reviews (
		review_id INT PRIMARY KEY AUTO_INCREMENT,
		wonder_id INT,
		rating DECIMAL(2,1),
		review_text TEXT,
		FOREIGN KEY (wonder_id) REFERENCES wonders(wonder_id)
	);
    
    INSERT INTO reviews (wonder_id, rating, review_text) VALUES
	(1, 4.8, 'Breathtaking experience, worth the climb!'),
	(1, 4.5, 'Too crowded but still amazing.'),
	(2, 4.5, 'Iconic statue, great views of Rio.'),
	(2, 4.2, 'Not as big as expected, but beautiful.'),
	(3, 4.7, 'Absolutely stunning views and history.'),
	(3, 4.3, 'Difficult hike, but rewarding.'),
	(4, 4.3, 'A historical masterpiece.'),
	(4, 4.0, 'Great but too touristy.'),
	(5, 4.6, 'Loved the architecture!'),
	(5, 4.5, 'Amazing history behind this monument.'),
	(6, 4.9, 'A must-visit destination!'),
	(6, 4.8, 'Mesmerizing beauty.'),
	(7, 4.2, 'Unique, but less tourist-friendly.'),
	(7, 4.1, 'Could be maintained better.'),
	(7, 3.9, 'Good but not much to do.');
    
SELECT * FROM reviews;

/*QUESTIONS

1) Find all wonders with their location and category ?
2) Find the total visitors for each wonder in 2023, appending 'M' using 'CONCAT' function in annual_visitors column ?
3) Find all visitor records for the Great Wall of China ?
4) Count the total number of reviews in the reviews table ?
5) Find each wonder along with its continent ?
6) Find the average annual visitors for each wonder from 2021 to 2023 ?
7) List wonders along with their average rating ?
8) Find wonders with visitor counts between 1 and 3 million in 2023 ?
9) Find reviews that contain the word ‘beautiful’ ?
10) Find wonders located in either South America or Asia ? */

-- 1) Find all wonders with their location and category ?

SELECT 
       wonder_name ,
       location,
       category
FROM 
     wonders;
  
-- 2) Find the total visitors for each wonder in 2023, appending 'M' using 'CONCAT' function in annual_visitors column ?
SELECT 
      w.wonder_name,
      CONCAT(SUM(v.annual_visitors)) AS Total_visitors_in_millions,
      v.year
	FROM visitors v
    JOIN wonders w ON v.wonder_id = w.wonder_id
    WHERE year = 2023
    GROUP BY  wonder_name;
-- 3) Find all visitor records for the Great Wall of China ?
SELECT w.wonder_name,
	   v.annual_visitors as Total_visitors_in_million,
       v.year
       FROM visitors v
       JOIN wonders w ON v.wonder_id = w.wonder_id
WHERE wonder_name = 'Great Wall of China'
GROUP BY  v.year,
		  Total_visitors_in_million;

-- 4) Count the total number of reviews in the reviews table ?

SELECT COUNT(*) AS Total_reviews FROM reviews;

-- 5) Find each wonder along with its continent ?
SELECT w.wonder_name,
       c.continent
 FROM countries c
 JOIN wonders w ON c.country_name = w.location;

-- 6) Find the average annual visitors for each wonder from 2021 to 2023 ?
SELECT w.wonder_name,
      ROUND(AVG(v.annual_visitors),2) as avg_visitors_in_millions
FROM visitors v
JOIN wonders w ON v.wonder_id = w.wonder_id
WHERE 
      year BETWEEN 2021 AND 2023
GROUP BY w.wonder_name;

-- 7) List wonders along with their average rating ?

SELECT w.wonder_name,
	ROUND(AVG(r.rating),2) as Avg_rating
FROM reviews r
JOIN wonders w ON r.wonder_id = w.wonder_id
GROUP BY w.wonder_name;

select * from visitors;

-- 8) Find wonders with visitor counts between 1 and 3 million in 2023 ?
SELECT  w.wonder_name,
        v.annual_visitors AS visitors_count_in_million
FROM visitors v 
JOIN wonders w ON v.wonder_id = w.wonder_id 
where 
      year = 2023
AND 
   v.annual_visitors BETWEEN 1 AND 3
ORDER BY 
		 v.annual_visitors DESC;
-- 9) Find reviews that contain the word ‘beautiful’ ?
SELECT *
FROM reviews
WHERE review_text LIKE '%beautiful%' ;

-- 10) Find wonders located in either South America or Asia ? 
SELECT  w.wonder_name,
        c.continent 
FROM 
	  countries c
JOIN 
      wonders w 
ON 
      c.country_name = w.location
WHERE 
      c.continent IN ('South America', 'Asia');













    
    
    