CREATE TABLE Genre(
	Id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	Name TEXT NOT NULL
);

CREATE TABLE Artist (
    Id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    ArtistName TEXT NOT NULL,
    YearEstablished INTEGER NOT NULL
);

CREATE TABLE Album (
    Id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    Title TEXT NOT NULL,
    ReleaseDate TEXT NOT NULL,
    AlbumLength INTEGER NOT NULL,
    Label TEXT NOT NULL,
    ArtistId INTEGER NOT NULL REFERENCES Artist (Id),
    GenreId INTEGER REFERENCES Genre (Id)
);

CREATE TABLE Song (
    Id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    Title TEXT NOT NULL,
    SongLength INTEGER NOT NULL,
    ReleaseDate TEXT NOT NULL,
    GenreId INTEGER REFERENCES Genre (Id),
    ArtistId INTEGER NOT NULL REFERENCES Artist (Id),
    AlbumId INTEGER NOT NULL REFERENCES Album (Id)
);