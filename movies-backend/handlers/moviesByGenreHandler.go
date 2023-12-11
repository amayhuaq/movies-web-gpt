package handlers

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"github.com/gorilla/mux"
)

func MoviesByGenreHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// Parse the genre ID from the URL
		vars := mux.Vars(r)
		genreID := vars["genreId"]

		// SQL query to fetch movies by genre ID
		// Adjust this query based on your actual database relationships and tables
		rows, err := db.Query(`
            SELECT m.id, m.title, m.release_date, m.runtime, m.mpaa_rating, m.description, m.image, m.created_at, m.updated_at
            FROM movies AS m
            JOIN movies_genres AS mg ON m.id = mg.movie_id
            WHERE mg.genre_id = $1`, genreID)

		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		var movies []Movie // Movie struct as defined previously
		for rows.Next() {
			var m Movie
			if err := rows.Scan(&m.ID, &m.Title, &m.ReleaseDate, &m.Runtime, &m.MPAARating, &m.Description, &m.Image, &m.CreatedAt, &m.UpdatedAt); err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			movies = append(movies, m)
		}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(movies)
	}
}
