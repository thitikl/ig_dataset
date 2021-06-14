# Selecting 5 oldest users
SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;

# The most popular day of the week that users registered
SELECT 
    DATE_FORMAT(created_at, '%W') AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 1;

# Finding inactive user (users without posting any photo)
SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

# Finding the most popular image with the most likes
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total_like
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total_like DESC
LIMIT 1;

# Finding average amount of image posted by users
SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg;
                          
# Find 5 most popular hastags
SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5;

# Selecting users who likes every single photo (who mostlikely will be a bot)
SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 