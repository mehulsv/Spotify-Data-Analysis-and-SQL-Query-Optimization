# Spotify-Data-Analysis-and-SQL-Query-Optimization

**Dataset Source:** Kaggle Spotify Dataset

**Project Description:**  
This project focuses on analyzing a comprehensive Spotify dataset containing attributes about tracks, albums, and artists using SQL. The analysis includes:

- Exploring data patterns related to artist popularity, track performance, and album characteristics.  
- Calculating key metrics such as average danceability, energy levels, and engagement statistics (views, likes, comments).  
- Identifying top-performing tracks and artists through ranking and window functions.  
- Investigating relationships between audio features (like energy, liveness, acousticness) and track popularity.  
- Performing advanced SQL query techniques such as nesting subqueries, Common Table Expressions (CTEs), and window functions to extract meaningful insights.  
- Applying query optimization strategies to improve performance on complex dataset queries.

**Database Table Schema:**

```sql
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
```

**Query Optimization Example:**  
- Analyzed query execution using EXPLAIN ANALYZE.  
- Optimized query performance by adding an index on the `artist` column:  
  ```sql
  CREATE INDEX idx_artist ON spotify(artist);
  ```
- Observed significant reduction in execution time after indexing:  
    - Before: Execution time ≈ 7 ms  
    - After: Execution time ≈ 0.153 ms

**Technology Stack:**  
- **Database:** PostgreSQL  
- **Tools:** pgAdmin 4 (or any SQL editor)

**License:** MIT License
