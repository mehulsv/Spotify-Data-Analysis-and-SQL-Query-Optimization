--SQl Project -- Spotify

-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

SELECT * FROM public.spotify
LIMIT 100

--EDA
SELECT COUNT(*) FROM spotify;

SELECT COUNT(DISTINCT artist) FROM spotify;

SELECT COUNT(DISTINCT album) FROM spotify;

SELECT DISTINCT album_type FROM spotify;

SELECT MAX(duration_min) FROM spotify;
SELECT MIN(duration_min) FROM spotify;

SELECT * FROM spotify
WHERE duration_min=0;

DELETE FROM spotify
WHERE duration_min=0;
SELECT * FROM spotify
WHERE duration_min=0;

SELECT DISTINCT channel FROM spotify;

SELECT DISTINCT most_played_on FROM spotify;

-- ----------------------- --
--01.Retrieve the names of all tracks that have more than 1 billion streams.

SELECT * FROM spotify
WHERE stream> 1000000000;

--02.List all albums along with their respective artists.

SELECT DISTINCT album, artist
FROM spotify
ORDER BY 1;

--03.Get the total number of comments for tracks where licensed = TRUE.

SELECT sum(comments) as total_comments
FROM spotify
where licensed ='true';

--04.Find all tracks that belong to the album type single.

SELECT * FROM spotify
WHERE album_type = 'single';

--05.Count the total number of tracks by each artist.

SELECT artist, COUNT(*) AS total_no_songs 
FROM spotify
GROUP BY artist
ORDER BY 2 ASC;

--06.Calculate the average danceability of tracks in each album.

SELECT ALBUM, AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC;

--07.Find the top 5 tracks with the highest energy values.

SELECT DISTINCT(track), MAX(energy)
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5 ;
--08.List all tracks along with their views and likes where official_video = TRUE.

SELECT track, SUM(views) AS total_views,SUM(likes) AS total_likes
FROM spotify
where official_video ='TRUE'
GROUP BY 1
ORDER BY 2 DESC;

--09.For each album, calculate the total views of all associated tracks.

SELECT DISTINCT(album),track,SUM(views)
FROM spotify
GROUP BY 1,2
ORDER BY 3 DESC;

--10.Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT * FROM
(SELECT track,
	--most_played_on,
	COALESCE(SUM(CASE WHEN most_played_on='Youtube' THEN stream END ),0) as streamed_on_youtube,
	COALESCE(SUM(CASE WHEN most_played_on='Spotify' THEN stream END ),0) as streamed_on_spotify
FROM spotify
GROUP BY 1)
as t1
WHERE streamed_on_spotify>streamed_on_youtube and streamed_on_youtube<>0 ;

--11.Find the top 3 most-viewed tracks for each artist using window functions.

WITH ranking_artist
AS
(SELECT artist, track, SUM(views) as total_views,
	DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM (views) DESC) as rank
FROM spotify
GROUP BY 1,2
ORDER BY 1,3 desc
)
SELECT * FROM ranking_artist
WHERE rank<= 3;

--12.Write a query to find tracks where the liveness score is above the average.

SELECT track,liveness
FROM spotify
WHERE liveness >=(SELECT AVG(liveness) FROM spotify);

--13.Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

WITH cte
AS
(SELECT album, MAX(energy) as highest_energy,MIN(energy) as lowest_energy
FROM spotify
GROUP BY 1)
SELECT album, highest_energy-lowest_energy as energy_diff
FROM cte
ORDER BY 2 DESC;