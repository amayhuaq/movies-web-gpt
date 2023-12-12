package main

import (
	"database/sql"
	"log"
	"movies-backend/handlers"
	"net/http"

	"github.com/gorilla/mux"
	_ "modernc.org/sqlite"
)

var db *sql.DB

func main() {
	var err error
	// Set up the database connection
	// db, err = sql.Open("postgres", "user=postgres dbname=movies password=admin sslmode=disable")
	db, err := sql.Open("sqlite", "./db_data_sqlite.db")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Check if the database is connected
	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}

	r := mux.NewRouter()

	r.HandleFunc("/movies", handlers.MoviesHandler(db)).Methods("GET")
	r.HandleFunc("/movies/0", handlers.AddMovieHandler(db)).Methods("POST")
	r.HandleFunc("/genres", handlers.GenresHandler(db)).Methods("GET")
	r.HandleFunc("/genres/{genreId}/movies", handlers.MoviesByGenreHandler(db)).Methods("GET")
	r.HandleFunc("/login", handlers.LoginHandler(db)).Methods("POST")

	r.HandleFunc("/movies/{id}", handlers.GetMovieDetailsHandler(db)).Methods("GET")
	r.HandleFunc("/movies/{id}", handlers.UpdateMovieHandler(db)).Methods("PUT")

	// Apply CORS middleware if needed
	http.Handle("/", corsMiddleware(r))

	log.Println("Server is running on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
