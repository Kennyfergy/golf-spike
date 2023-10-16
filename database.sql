
-- Users Table
CREATE TABLE users (
    id serial PRIMARY KEY,
    username varchar(255) NOT NULL UNIQUE,
    email varchar(255) NOT NULL UNIQUE,
    password varchar(255) NOT NULL,
    logged_in boolean NOT NULL DEFAULT false,
    user_handicap decimal NOT NULL DEFAULT 0.0,
    is_admin boolean NOT NULL,
    is_male boolean NOT NULL DEFAULT false
);

-- User Courses Table
CREATE TABLE user_courses (
    id serial PRIMARY KEY,
    user_id integer NOT NULL,
    course_name varchar(255) NOT NULL,
    course_location varchar(255) NOT NULL,
    men_course_rating decimal NOT NULL,
    men_course_slope integer NOT NULL,
    men_front_9_par integer NOT NULL,
    men_back_9_par integer NOT NULL,
    women_course_rating decimal NOT NULL,
    women_course_slope integer NOT NULL,
    women_front_9_par integer NOT NULL,
    women_back_9_par integer NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- User Rounds Table
CREATE TABLE user_rounds (
    id serial PRIMARY KEY,
    user_id integer NOT NULL,
    date timestamp NOT NULL,
    front_9_score integer NOT NULL,
    back_9_score integer NOT NULL,
    course_id integer NOT NULL,
    course_handicap decimal NOT NULL DEFAULT 0.0,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (course_id) REFERENCES user_courses (id)
);

-- Admin Courses Table, not used for base goals
CREATE TABLE admin_courses (
    id serial PRIMARY KEY,
    user_id integer NOT NULL,
    course_name varchar(255) NOT NULL,
    course_location varchar(255) NOT NULL,
    men_course_rating decimal NOT NULL,
    men_course_slope integer NOT NULL,
    men_front_9_par integer NOT NULL,
    men_back_9_par integer NOT NULL,
    women_course_rating decimal NOT NULL,
    women_course_slope integer NOT NULL,
    women_front_9_par integer NOT NULL,
    women_back_9_par integer NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

--test data
INSERT INTO users (username, email, password, logged_in, user_handicap, is_admin, is_male)
VALUES ('user1', 'user1@email.com', 'password123', false, 15.0, false, true),
       ('user2', 'user2@email.com', 'password456', false, 10.0, false, false);


INSERT INTO user_courses (user_id, course_name, course_location, men_course_rating, men_course_slope, men_front_9_par, men_back_9_par, women_course_rating, women_course_slope, women_front_9_par, women_back_9_par)
VALUES (1, 'Pine Valley Golf Course', 'New Jersey, USA', 72.8, 155, 36, 35, 78.2, 148, 37, 36),
       (2, 'Augusta National Golf Club', 'Georgia, USA', 76.2, 148, 37, 36, 80.1, 145, 38, 37);


INSERT INTO user_rounds (user_id, date, front_9_score, back_9_score, course_id, course_handicap)
VALUES 
(1, '2023-09-01 08:00:00', 40, 42, 1, 12.0),
(1, '2023-09-05 09:00:00', 38, 40, 1, 11.5),
(1, '2023-09-10 07:30:00', 37, 39, 1, 11.0),
(1, '2023-09-15 08:15:00', 39, 41, 1, 12.5),
(1, '2023-09-20 09:15:00', 41, 43, 1, 13.0),
(1, '2023-09-25 08:45:00', 40, 42, 2, 14.0),
(1, '2023-10-01 08:00:00', 39, 38, 2, 13.5),
(1, '2023-10-05 09:00:00', 40, 39, 2, 13.0),
(1, '2023-10-10 07:30:00', 38, 40, 2, 12.5),
(1, '2023-10-15 08:15:00', 37, 39, 2, 12.0),
(2, '2023-09-02 08:00:00', 36, 38, 1, 9.0),
(2, '2023-09-06 09:00:00', 37, 37, 1, 8.5),
(2, '2023-09-11 07:30:00', 35, 36, 1, 8.0),
(2, '2023-09-16 08:15:00', 38, 38, 1, 8.5),
(2, '2023-09-21 09:15:00', 36, 37, 1, 9.0),
(2, '2023-09-26 08:45:00', 37, 37, 2, 9.5),
(2, '2023-10-02 08:00:00', 36, 36, 2, 9.0),
(2, '2023-10-06 09:00:00', 35, 36, 2, 8.5),
(2, '2023-10-11 07:30:00', 37, 37, 2, 9.0),
(2, '2023-10-16 08:15:00', 38, 38, 2, 9.5);

--third user test data

INSERT INTO users (username, email, password, user_handicap, is_admin, is_male)
VALUES ('JaneDoe', 'jane@example.com', 'securepassword', 20.0, false, false);

INSERT INTO user_rounds (user_id, date, front_9_score, back_9_score, course_id, course_handicap)
VALUES 
  ((SELECT id FROM users WHERE username = 'JaneDoe'), NOW(), 45, 47, 1, 31),
  ((SELECT id FROM users WHERE username = 'JaneDoe'), NOW(), 46, 48, 1, 31),
  ((SELECT id FROM users WHERE username = 'JaneDoe'), NOW(), 44, 49, 1, 31),
  ((SELECT id FROM users WHERE username = 'JaneDoe'), NOW(), 43, 46, 1, 31),
  ((SELECT id FROM users WHERE username = 'JaneDoe'), NOW(), 45, 47, 1, 31),
  ((SELECT id FROM users WHERE username = 'JaneDoe'), NOW(), 46, 45, 1, 31),
  ((SELECT id FROM users WHERE username = 'JaneDoe'), NOW(), 44, 46, 1, 31),
  ((SELECT id FROM users WHERE username = 'JaneDoe'), NOW(), 43, 48, 1, 31),
  ((SELECT id FROM users WHERE username = 'JaneDoe'), NOW(), 45, 47, 1, 31),
  ((SELECT id FROM users WHERE username = 'JaneDoe'), NOW(), 46, 44, 1, 31);


~~~~~~~~~~~~~~~~~~~~~~~~~~~
  --sql text, some kind of works, still inaccurate calculations
--handicap index formula
WITH HandicapDifferentials AS (
    SELECT
        r.user_id,
        (CASE
             WHEN u.is_male THEN (r.front_9_score + r.back_9_score - c.men_course_rating) * 113 / c.men_course_slope
             ELSE (r.front_9_score + r.back_9_score - c.women_course_rating) * 113 / c.women_course_slope
         END) AS differential
    FROM user_rounds r
    JOIN users u ON r.user_id = u.id
    JOIN user_courses c ON r.course_id = c.id
    WHERE r.user_id = 3
    ORDER BY r.date DESC
    LIMIT 20
),
BestEightDifferentials AS (
    SELECT differential
    FROM HandicapDifferentials
    ORDER BY differential ASC
    LIMIT 8
)
SELECT 
    ROUND(AVG(differential) * 0.96, 1) AS handicap_index
FROM BestEightDifferentials;

--course handicap
-- Assuming we already have the Handicap Index (as calculated in the previous query)
WITH HandicapIndex AS (
    WITH HandicapDifferentials AS (
    SELECT
        r.user_id,
        (CASE
             WHEN u.is_male THEN (r.front_9_score + r.back_9_score - c.men_course_rating) * 113 / c.men_course_slope
             ELSE (r.front_9_score + r.back_9_score - c.women_course_rating) * 113 / c.women_course_slope
         END) AS differential
    FROM user_rounds r
    JOIN users u ON r.user_id = u.id
    JOIN user_courses c ON r.course_id = c.id
    WHERE r.user_id = 1
    ORDER BY r.date DESC
    LIMIT 20
),
BestEightDifferentials AS (
    SELECT differential
    FROM HandicapDifferentials
    ORDER BY differential ASC
    LIMIT 8
)
SELECT 
    ROUND(AVG(differential) * 0.96, 1) AS handicap_index
FROM BestEightDifferentials
),

CourseData AS (
    SELECT
        user_id,
        (CASE
            WHEN u.is_male THEN men_course_rating
            ELSE women_course_rating
        END) AS course_rating,
        (CASE
            WHEN u.is_male THEN men_course_slope
            ELSE women_course_slope
        END) AS slope_rating,
        (CASE
            WHEN u.is_male THEN men_front_9_par + men_back_9_par
            ELSE women_front_9_par + women_back_9_par
        END) AS course_par
    FROM user_courses
    JOIN users u ON user_courses.user_id = u.id
    WHERE course_id = 2
)

SELECT
    ROUND((h.handicap_index * c.slope_rating) / 113 + (c.course_rating - c.course_par), 1) AS course_handicap
FROM HandicapIndex h, CourseData c;

WITH HandicapDifferential AS (
    SELECT
        username,
        ((CASE
            WHEN is_male THEN (front_9_score + back_9_score) - men_course_rating
            ELSE (front_9_score + back_9_score) - women_course_rating
        END) / 
        (CASE 
            WHEN is_male THEN men_course_slope
            ELSE women_course_slope
        END) * 113) AS differential
    FROM user_rounds
    JOIN user_courses ON user_rounds.course_id = user_courses.id
    JOIN users ON user_rounds.user_id = users.id
)

, RankedDifferentials AS (
    SELECT
        username,
        differential,
        ROW_NUMBER() OVER (PARTITION BY username ORDER BY differential) AS r
    FROM HandicapDifferential
)

SELECT
    username,
    AVG(differential) * 0.96 AS handicap_index
FROM RankedDifferentials
WHERE r <= 8 -- Consider only the 8 lowest differentials
GROUP BY username;

WITH HandicapDifferential AS (
    SELECT
        user_rounds.user_id,
        ((CASE
            WHEN is_male THEN (front_9_score + back_9_score) - men_course_rating
            ELSE (front_9_score + back_9_score) - women_course_rating
        END) / 
        (CASE 
            WHEN is_male THEN men_course_slope
            ELSE women_course_slope
        END) * 113) AS differential
    FROM user_rounds
    JOIN user_courses ON user_rounds.course_id = user_courses.id
    JOIN users ON user_rounds.user_id = users.id
)

, RankedDifferentials AS (
    SELECT
        user_id,
        differential,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY differential) AS r,
        COUNT(*) OVER (PARTITION BY user_id) AS total_rounds
    FROM HandicapDifferential
)

, DifferentialsToConsider AS (
    SELECT
        user_id,
        differential,
        total_rounds,
        r,
        CASE
            WHEN total_rounds <= 3 THEN 1
            WHEN total_rounds BETWEEN 4 AND 5 THEN 2
            WHEN total_rounds BETWEEN 6 AND 7 THEN 3
            WHEN total_rounds BETWEEN 8 AND 9 THEN 4
            WHEN total_rounds BETWEEN 10 AND 11 THEN 5
            WHEN total_rounds BETWEEN 12 AND 13 THEN 6
            WHEN total_rounds BETWEEN 14 AND 15 THEN 7
            WHEN total_rounds = 16 THEN 8
            WHEN total_rounds = 17 THEN 9
            WHEN total_rounds = 18 THEN 10
            WHEN total_rounds = 19 THEN 11
            ELSE 12
        END AS num_diffs_to_consider
    FROM RankedDifferentials
)

SELECT
    user_id,
    (SUM(differential) / num_diffs_to_consider) * 0.96 AS handicap_index
FROM DifferentialsToConsider
WHERE r <= num_diffs_to_consider
GROUP BY user_id, num_diffs_to_consider;