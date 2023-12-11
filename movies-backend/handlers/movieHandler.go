package handlers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

type Movie struct {
	ID          int    `json:"id"`
	Title       string `json:"title"`
	ReleaseDate string `json:"releaseDate"`
	Runtime     int    `json:"runtime"`
	MPAARating  string `json:"mpaaRating"`
	Description string `json:"description"`
	Image       string `json:"image"`
	CreatedAt   string `json:"createdAt"`
	UpdatedAt   string `json:"updatedAt"`
	GenreIDs    []int  `json:"genreIds"` // Assuming the frontend sends an array of genre IDs
}

type MovieDetail struct {
	Movie
	Genres []Genre `json:"genres"`
}

func MoviesHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method == "GET" {

			// Inside your MoviesHandler function
			rows, err := db.Query("SELECT id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at FROM movies")
			if err != nil {
				log.Println("Error executing SELECT query:", err)
				http.Error(w, "Server error", http.StatusInternalServerError)
				return
			}
			defer rows.Close()

			var movies []Movie
			for rows.Next() {
				var m Movie
				// Make sure you are scanning into variables that match your SQL query structure
				err := rows.Scan(&m.ID, &m.Title, &m.ReleaseDate, &m.Runtime, &m.MPAARating, &m.Description, &m.Image, &m.CreatedAt, &m.UpdatedAt)
				if err != nil {
					http.Error(w, err.Error(), http.StatusInternalServerError)
					return
				}
				movies = append(movies, m)
			}
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(movies)
		} else {
			http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		}
	}
}

func AddMovieHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var movie Movie
		if err := json.NewDecoder(r.Body).Decode(&movie); err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		// Begin a transaction
		tx, err := db.Begin()
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Use the `RETURNING` clause to get the last inserted ID and include NOW() for timestamps
		var movieID int
		err = tx.QueryRow(`
            INSERT INTO movies (title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) 
            VALUES ($1, $2, $3, $4, $5, $6, NOW(), NOW()) 
            RETURNING id`,
			movie.Title, movie.ReleaseDate, movie.Runtime, movie.MPAARating, movie.Description, movie.Image).Scan(&movieID)
		if err != nil {
			tx.Rollback()
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Insert movie-genre associations
		for _, genreID := range movie.GenreIDs {
			_, err := tx.Exec(`
                INSERT INTO movies_genres (movie_id, genre_id) 
                VALUES ($1, $2)`,
				movieID, genreID)
			if err != nil {
				tx.Rollback()
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
		}

		if err := tx.Commit(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		w.WriteHeader(http.StatusCreated)
		w.Write([]byte(fmt.Sprintf("New movie added with ID: %d", movieID)))
	}
}

func GetMovieDetailsHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		movieID := vars["id"]

		log.Println("Error executing SELECT query:", movieID)

		// Get the movie
		var movieDetail MovieDetail
		err := db.QueryRow(`
            SELECT id, title, release_date, runtime, mpaa_rating, description, image 
            FROM movies WHERE id = $1`, movieID).Scan(
			&movieDetail.ID, &movieDetail.Title, &movieDetail.ReleaseDate,
			&movieDetail.Runtime, &movieDetail.MPAARating, &movieDetail.Description, &movieDetail.Image,
		)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Get the genres for the movie
		rows, err := db.Query(`
            SELECT g.id, g.genre 
            FROM genres g
            INNER JOIN movies_genres mg ON g.id = mg.genre_id
            WHERE mg.movie_id = $1`, movieID)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		for rows.Next() {
			var genre Genre
			if err := rows.Scan(&genre.ID, &genre.Genre); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			movieDetail.Genres = append(movieDetail.Genres, genre)
		}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(movieDetail)
	}
}

func UpdateMovieHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		movieID := vars["id"]

		var movieDetail MovieDetail
		if err := json.NewDecoder(r.Body).Decode(&movieDetail); err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		// Begin transaction
		tx, err := db.Begin()
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Update the movie
		_, err = tx.Exec(`
            UPDATE movies SET title = $1, release_date = $2, runtime = $3, mpaa_rating = $4, 
            description = $5, image = $6 WHERE id = $7`,
			movieDetail.Title, movieDetail.ReleaseDate, movieDetail.Runtime,
			movieDetail.MPAARating, movieDetail.Description, movieDetail.Image, movieID,
		)
		if err != nil {
			tx.Rollback()
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Update genres by first removing old ones
		_, err = tx.Exec("DELETE FROM movies_genres WHERE movie_id = $1", movieID)
		if err != nil {
			tx.Rollback()
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Then adding new ones
		for _, genre := range movieDetail.Genres {
			_, err = tx.Exec("INSERT INTO movies_genres (movie_id, genre_id) VALUES ($1, $2)", movieID, genre.ID)
			if err != nil {
				tx.Rollback()
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
		}

		if err := tx.Commit(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		w.WriteHeader(http.StatusOK)
	}
}
