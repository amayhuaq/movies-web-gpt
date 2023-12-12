package handlers

import (
	"database/sql"
	"encoding/json"
	"net/http"
)

func GenresHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method == "GET" {
			rows, err := db.Query("SELECT id, genre FROM genres")
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			defer rows.Close()

			var genres []struct {
				ID    int    `json:"id"`
				Genre string `json:"genre"`
			}
			for rows.Next() {
				var g struct {
					ID    int    `json:"id"`
					Genre string `json:"genre"`
				}
				if err := rows.Scan(&g.ID, &g.Genre); err != nil {
					http.Error(w, err.Error(), http.StatusInternalServerError)
					return
				}
				genres = append(genres, g)
			}

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(genres)
		} else {
			http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		}
	}
}
