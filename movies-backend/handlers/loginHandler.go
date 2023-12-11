package handlers

import (
	"database/sql"
	"encoding/json"
	"net/http"
	"time"

	"github.com/dgrijalva/jwt-go"
	"golang.org/x/crypto/bcrypt"
)

var jwtKey = []byte("mykey") // This should be stored securely

type Credentials struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type Claims struct {
	Email string `json:"email"`
	jwt.StandardClaims
}

// LoginHandler authenticates the user and generates a JWT
func LoginHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var creds Credentials
		if err := json.NewDecoder(r.Body).Decode(&creds); err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		// Retrieve the stored hash for the given email
		var storedHash string
		err := db.QueryRow("SELECT password FROM users WHERE email = $1", creds.Email).Scan(&storedHash)
		if err != nil {
			if err == sql.ErrNoRows {
				// Email not found
				http.Error(w, "Email or password is incorrect", http.StatusUnauthorized)
				return
			}
			// Unexpected error
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Compare the stored hash with the password provided
		err = bcrypt.CompareHashAndPassword([]byte(storedHash), []byte(creds.Password))
		if err != nil {
			// Password does not match
			http.Error(w, "Email or password is incorrect", http.StatusUnauthorized)
			return
		}

		// Define the expiration time of the token
		expirationTime := time.Now().Add(20 * time.Minute)
		// Create the JWT claims, which includes the email and expiry time
		claims := &Claims{
			Email: creds.Email,
			StandardClaims: jwt.StandardClaims{
				ExpiresAt: expirationTime.Unix(),
			},
		}

		// Declare the token with the algorithm used for signing, and the claims
		token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
		// Create the JWT string
		tokenString, err := token.SignedString(jwtKey)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Send the token as a response instead of setting it as a cookie if you want the frontend to handle it
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(map[string]string{"token": tokenString})

		// Finally, we set the client cookie for "token" as the JWT we just generated
		// We also set an expiry time which is the same as the token itself
		/*http.SetCookie(w, &http.Cookie{
			Name:    "token",
			Value:   tokenString,
			Expires: expirationTime,
		})*/
	}
}
