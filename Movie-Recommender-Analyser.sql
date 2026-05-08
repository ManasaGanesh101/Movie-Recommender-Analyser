create database movie_database;
use movie_database;

CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  name VARCHAR(100),
  age INT
);

CREATE TABLE Movies (
  movie_id INT PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(100)
);

CREATE TABLE Ratings (
  user_id INT,
  movie_id INT,
  rating FLOAT,
  PRIMARY KEY (user_id, movie_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

CREATE TABLE Watch_History (
  user_id INT,
  movie_id INT,
  watch_date DATE,
  PRIMARY KEY (user_id, movie_id, watch_date),
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

#populating the tables
INSERT INTO Users VALUES
(1, 'Alice', 21),
(2, 'Bob', 23),
(3, 'Charlie', 22),
(4, 'David', 24),
(5, 'Emma', 20),
(6, 'Frank', 25),
(7, 'Grace', 23),
(8, 'Helen', 22),
(9, 'Ivy', 21),
(10, 'Jack', 24),
(11, 'Karan', 22),
(12, 'Liya', 23),
(13, 'Manoj', 25),
(14, 'Nina', 20),
(15, 'Omar', 26);

INSERT INTO Movies VALUES
(1, 'Inception', 'Sci-Fi'),
(2, 'Interstellar', 'Sci-Fi'),
(3, 'The Dark Knight', 'Action'),
(4, 'Avengers', 'Action'),
(5, 'Titanic', 'Romance'),
(6, 'The Notebook', 'Romance'),
(7, 'Joker', 'Drama'),
(8, 'Fight Club', 'Drama'),
(9, 'Toy Story', 'Animation'),
(10, 'Frozen', 'Animation'),
(11, 'Conjuring', 'Horror'),
(12, 'It', 'Horror'),
(13, 'Doctor Strange', 'Sci-Fi'),
(14, 'Iron Man', 'Action'),
(15, 'Shutter Island', 'Thriller'),
(16, 'Gone Girl', 'Thriller'),
(17, 'La La Land', 'Romance'),
(18, 'The Godfather', 'Drama'),
(19, 'Coco', 'Animation'),
(20, 'Insidious', 'Horror'),
(21, 'Parasite', 'Drama'),
(22, 'John Wick', 'Action');

INSERT INTO Ratings VALUES
#User 1 (Sci-Fi + Action)
(1,1,5),(1,2,5),(1,3,4),(1,4,4),
#User 2 (Sci-Fi + Action)
(2,1,4),(2,2,5),(2,3,5),(2,4,4),
#User 3 (Romance)
(3,5,5),(3,6,4),
#User 4 (Drama + Action)
(4,3,4),(4,7,5),(4,8,4),
#User 5 (Animation)
(5,9,5),(5,10,4),
#User 6 (Horror)
(6,11,5),(6,12,4),
#User 7 (Mixed Sci-Fi + Drama)
(7,1,4),(7,2,4),(7,7,5),
#User 8 (Mixed)
(8,4,5),(8,8,4),(8,10,4),
#User 9 (Sci-Fi + Action)
(9,1,5),(9,2,4),(9,13,5),(9,14,4),(9,22,5),
#User 10 (Romance + Drama)
(10,5,4),(10,6,5),(10,17,5),(10,18,4),(10,21,5),
#User 11 (Thriller)
(11,15,5),(11,16,4),(11,7,4),
#User 12 (Animation + Family)
(12,9,5),(12,10,5),(12,19,5),
#User 13 (Horror)
(13,11,5),(13,12,4),(13,20,5),
#User 14 (Mixed)
(14,1,4),(14,3,5),(14,7,4),(14,18,5),
#User 15 (Action heavy)
(15,3,5),(15,4,5),(15,14,4),(15,22,5);

INSERT INTO Watch_History VALUES
(1,1,'2026-04-01'),(1,2,'2026-04-02'),(1,3,'2026-04-03'),(1,4,'2026-04-04'),
(2,1,'2026-04-02'),(2,2,'2026-04-03'),(2,3,'2026-04-04'),(2,4,'2026-04-05'),
(3,5,'2026-04-01'),(3,6,'2026-04-02'),
(4,3,'2026-04-03'),(4,7,'2026-04-04'),(4,8,'2026-04-05'),
(5,9,'2026-04-01'),(5,10,'2026-04-02'),
(6,11,'2026-04-03'),(6,12,'2026-04-04'),
(7,1,'2026-04-05'),(7,2,'2026-04-06'),(7,7,'2026-04-06'),
(8,4,'2026-04-02'),(8,8,'2026-04-03'),(8,10,'2026-04-04'),
(9,1,'2026-04-07'),(9,2,'2026-04-08'),(9,13,'2026-04-08'),(9,22,'2026-04-09'),
(10,5,'2026-04-07'),(10,6,'2026-04-08'),(10,17,'2026-04-09'),(10,21,'2026-04-09'),
(11,15,'2026-04-06'),(11,16,'2026-04-07'),(11,7,'2026-04-08'),
(12,9,'2026-04-07'),(12,10,'2026-04-07'),(12,19,'2026-04-08'),
(13,11,'2026-04-08'),(13,12,'2026-04-09'),(13,20,'2026-04-09'),
(14,1,'2026-04-07'),(14,3,'2026-04-08'),(14,18,'2026-04-09'),
(15,3,'2026-04-06'),(15,4,'2026-04-07'),(15,22,'2026-04-08');



#Key Tasks
#1. Top rated movies
#explanation: -- top rated movies are defined by the ones with the highest avg ratings from all viewers in db.
#so we perform inner join on tables movies and ratings to get user ratings for each movie.
#then we group by each movie and order by the avg rating using the aggregate function, AVG of the rating column in table Ratings 

SELECT m.title, AVG(r.rating) AS avg_rating
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY m.movie_id
ORDER BY avg_rating DESC , COUNT(r.rating) DESC;

#2. Identifying most popular genres: a) based on watch count , b) based on rating
# a) based on watch count
SELECT m.genre, COUNT(*) AS total_views
FROM Watch_History w
JOIN Movies m ON w.movie_id = m.movie_id
GROUP BY m.genre
ORDER BY total_views DESC;

#b) based on ratings
SELECT m.genre, AVG(r.rating) AS avg_rating
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY m.genre
ORDER BY avg_rating DESC;

#3. Recommend movies based on similar users
SELECT m.title
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
WHERE r.user_id IN (
    SELECT r2.user_id
    FROM Ratings r1
    JOIN Ratings r2 
      ON r1.movie_id = r2.movie_id
    WHERE r1.user_id = 9 
      AND r2.user_id != 9
      AND r1.rating >= 4
      AND r2.rating >= 4
    GROUP BY r2.user_id
    HAVING COUNT(*) >= 2 

)
AND r.rating >= 4


AND r.movie_id NOT IN (
    SELECT movie_id FROM Ratings WHERE user_id = 9
)

GROUP BY m.movie_id, m.title
ORDER BY COUNT(*) DESC;



#4. Analyze user behavior patterns- each user's activity summary
SELECT 
    u.user_id,
    u.name,
    COUNT(DISTINCT w.movie_id)   AS total_watched,
    COUNT(DISTINCT r.movie_id)   AS total_rated,
    ROUND(AVG(r.rating), 2)      AS avg_rating_given,
    MAX(w.watch_date)            AS last_watched_on
FROM Users u
LEFT JOIN Watch_History w ON u.user_id = w.user_id
LEFT JOIN Ratings r       ON u.user_id = r.user_id
GROUP BY u.user_id, u.name
ORDER BY total_watched DESC;


#5. display trending movies (most watched movies in the last week)
SELECT 
    m.title,
    m.genre,
    COUNT(*) AS recent_watch_count
FROM Watch_History w
JOIN Movies m ON w.movie_id = m.movie_id
WHERE w.watch_date >= CURDATE() - INTERVAL 30 DAY
GROUP BY m.movie_id, m.title, m.genre
ORDER BY recent_watch_count DESC;


