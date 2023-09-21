-- 1. Query all of the entries in the `genre` table
SELECT *
FROM Genre;
-- 2. Query all the entries in the `artist` table and order by the artist's name. HINT: use the ORDER BY keywords
SELECT *
FROM Artist
ORDER BY ArtistName;
-- 3. Write a `SELECT` query that lists all the songs in the `song` table and include the artist name
SELECT Title, ArtistName
FROM Song
INNER JOIN Artist
	ON ArtistId = Artist.Id
-- 4. Write a `SELECT` query that lists all the artists that have a Pop album
SELECT ArtistName
FROM Artist
INNER JOIN Album ON Artist.Id = Album.ArtistId
INNER JOIN Genre ON Album.GenreId = Genre.Id
WHERE Genre.Name LIKE 'Pop'
-- 5. Write a `SELECT` query that lists all the artists that have a Jazz or Rock album
SELECT ArtistName
FROM Artist
INNER JOIN Album ON Artist.Id = Album.ArtistId
INNER JOIN Genre ON Album.GenreId = Genre.Id
WHERE Genre.Name = 'Jazz' 
OR Genre.Name = 'Rock'
-- 6. Write a `SELECT` statement that lists the albums with no songs
SELECT Album.Title FROM Album
LEFT JOIN Song ON Album.Id = Song.AlbumId
WHERE Song.Id IS NULL;
-- 7. Using the `INSERT` statement, add one of your favorite artists to the `artist` table.
INSERT INTO Artist
(ArtistName, YearEstablished)
VALUES ('Daft Punk', 1993);
SELECT * FROM Artist;
-- 8. Using the `INSERT` statement, add one, or more, albums by your artist to the `album` table.
INSERT INTO Album
(Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId)
VALUES ('Homework', '01/17/1997', 2032, 'Virgin', 28, 14),
('Discovery', '02/26/2001', 3423, 'Virgin', 28, 14),
('Human After All', '03/14/2005', 1597, 'Virgin', 28, 14),
('Random Access Memories', '05/17/2013', 3409, 'Columbia', 28, 14);
SELECT * FROM Album WHERE ArtistId = 28;
-- 9. Using the `INSERT` statement, add some songs that are on that album to the `song` table.
INSERT INTO Song 
(Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) 
VALUES ('Daftendirekt', 165, '01/17/1997', 14, 28, 23),
('WDPK 83.7 FM', 28, '01/17/1997', 14, 28, 23),
('Revolution 909', 326, '01/17/1997', 14, 28, 23),
('Da Funk', 330, '01/17/1997', 14, 28, 23),
('Phoenix', 297, '01/17/1997', 14, 28, 23),
('Fresh', 243, '01/17/1997', 14, 28, 23);
SELECT * FROM Song WHERE ArtistId = 28;
-- 10. Write a `SELECT` query that provides the song titles, album title, and artist name for all of the data you just entered in. 
-- Use the [`LEFT JOIN`](https://www.tutorialspoint.com/sql/sql-using-joins.htm) keyword sequence to connect the tables, 
-- and the `WHERE` keyword to filter the results to the album and artist you added.
SELECT artistname, song.title AS song_title, album.title AS album_title
FROM Album
LEFT JOIN Song ON Song.AlbumId = album.Id
LEFT JOIN Artist ON artist.Id = album.artistId
WHERE artist.Id = 28
OR album.artistId = 28;
--  > **NOTE:** Direction of join matters. Try the following statements and see the difference in results.
--
--    ```sql
--    SELECT a.title, s.title FROM album a LEFT JOIN song s ON s.album_id = a.id;
--    SELECT a.title, s.title FROM song s LEFT JOIN album a ON s.album_id = a.id;
--    ```

-- 11. Write a `SELECT` statement to display how many songs exist for each album. You'll need to use the `COUNT()` function and the `GROUP BY` keyword sequence.
SELECT album.title, COUNT(AlbumId) FROM Song INNER JOIN Album ON album.Id = song.AlbumId GROUP BY album.title;
-- 12. Write a `SELECT` statement to display how many songs exist for each artist. You'll need to use the `COUNT()` function and the `GROUP BY` keyword sequence.
SELECT artistname, COUNT(artistId) FROM Song INNER JOIN Artist ON artist.Id = song.artistid GROUP BY artistname;
-- 13. Write a `SELECT` statement to display how many songs exist for each genre. You'll need to use the `COUNT()` function and the `GROUP BY` keyword sequence.
SELECT genre.name, COUNT(genreId) FROM Song INNER JOIN genre ON song.genreid = genre.id GROUP BY genre.name;
-- 14. Write a `SELECT` query that lists the artists that have put out records on more than one record label. 
-- Hint: When using `GROUP BY` instead of using a `WHERE` clause, use the [`HAVING`](https://www.tutorialspoint.com/sql/sql-having-clause.htm) keyword
SELECT Artist.ArtistName
FROM Album
LEFT JOIN Artist ON Artist.Id = Album.ArtistId
GROUP BY ArtistName
HAVING COUNT(DISTINCT album.Label) > 1
ORDER BY artistname ASC;
-- 15. Using `MAX()` function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.
SELECT Album.Title, MAX(Album.AlbumLength) AS Longest_Duration
FROM Album
GROUP BY Album.Title
ORDER BY Longest_Duration DESC
LIMIT 1;
-- 16. Using `MAX()` function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.
SELECT Song.Title, MAX(Song.SongLength) AS Longest_Duration
FROM Song
GROUP BY Song.Title
ORDER BY Longest_Duration DESC
LIMIT 1;
-- 17. Modify the previous query to also display the title of the album.
SELECT Album.Title AS Album_Title, Song.Title AS Song_Title, MAX(Song.SongLength) AS Longest_Duration
FROM Song
INNER JOIN Album ON Album.Id = Song.AlbumId
GROUP BY Song.Title, Album.Title
ORDER BY Longest_Duration DESC
LIMIT 1;