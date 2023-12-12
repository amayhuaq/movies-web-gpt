import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';

const MovieEdit = () => {
    const [movie, setMovie] = useState({
        title: '',
        releaseDate: '',
        runtime: '',
        mpaaRating: '',
        description: '',
        image: '',
        genres: []
    });
    const [allGenres, setAllGenres] = useState([]); // To store all available genres
    const { id } = useParams(); // To capture the movie ID from the URL
    const navigate = useNavigate(); // For redirecting after the update

    useEffect(() => {
        // Function to fetch movie data
        const fetchMovie = async () => {
            try {
                const response = await fetch(`http://localhost:8080/movies/${id}`);
                if (!response.ok) {
                    //throw new Error(`HTTP error! status: ${response.status}`);
                    throw new Error('Network response was not ok');
                }
                const data = await response.json();
                console.log("movie", data);
                
                setMovie({
                    title: data.title || '',
                    releaseDate: data.releaseDate || '',
                    runtime: data.runtime || 0,
                    mpaaRating: data.mpaaRating || '',
                    description: data.description || '',
                    image: data.image || '',
                    genres: data.genres.map(g => g.id) || []
                });
            } catch (error) {
                console.error("Fetch error: ", error);
            }
        };

        // Function to fetch all genres
        const fetchGenres = async () => {
            try {
                const response = await fetch(`http://localhost:8080/genres`);
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const genresData = await response.json();
                setAllGenres(genresData); // Set the genres data
            } catch (error) {
                console.error("Fetch error: ", error);
            }
        };

        fetchMovie();
        fetchGenres();
    }, [id]); // Dependency array ensures this effect runs once upon component mount

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setMovie({ ...movie, [name]: value });
    };

    const handleGenreChange = (event) => {
        const value = parseInt(event.target.value);
        const checked = event.target.checked;
        setMovie({
            ...movie,
            genres: checked
                ? [...movie.genres, value]
                : movie.genres.filter((genreId) => genreId !== value)
        });
    };

    const handleSubmit = async (event) => {
        event.preventDefault();

        // Construct the payload with the movie data
        const payload = {
            title: movie.title,
            releaseDate: movie.releaseDate,
            runtime: parseInt(movie.runtime), // Make sure to convert runtime to an integer if it's a numeric field
            mpaaRating: movie.mpaaRating,
            description: movie.description,
            image: movie.image,
            // Include genre IDs only if you want to update genres
            genreIds: movie.genres
        };

        try {
            // Send a PUT request to the update movie endpoint
            const response = await fetch(`http://localhost:8080/movies/${id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    // Include the Authorization header with the token if the endpoint requires authentication
                    // 'Authorization': `Bearer ${yourAuthToken}`
                },
                body: JSON.stringify(payload)
            });

            if (response.ok) {
                // Handle the response. You might want to check if the server sends back any data
                console.log('Movie updated successfully');

                // Redirect to the movies list or another appropriate place
                navigate('/movies');
            } else {
                // If the server responds with an error, you can handle it here
                console.error('An error occurred while updating the movie', await response.text());
            }
        } catch (error) {
            // Handle the error from the fetch operation
            console.error('Fetch error:', error);
        }
    };

    return (
        <form onSubmit={handleSubmit}>
            <h2>Edit Movie</h2>
            <label>
                Title:
                <input
                    type="text"
                    name="title"
                    value={movie.title}
                    onChange={handleInputChange}
                />
            </label>
            {/* Repeat for other fields: releaseDate, runtime, etc. */}
            <label>
                Release Date:
                <input
                    type="date"
                    name="releaseDate"
                    value={movie.releaseDate}
                    onChange={handleInputChange}
                />
            </label>
            <label>
                Runtime:
                <input
                    type="text"
                    name="runtime"
                    value={movie.runtime}
                    onChange={handleInputChange}
                />
            </label>
            <label>
                MPAA Rating:
                <input
                    type="text"
                    name="mpaaRating"
                    value={movie.mpaaRating}
                    onChange={handleInputChange}
                />
            </label>
            <label>
                Description:
                <textarea
                    name="description"
                    value={movie.description}
                    onChange={handleInputChange}
                />
            </label>
            <label>
                Image URL:
                <input
                    type="text"
                    name="image"
                    value={movie.image}
                    onChange={handleInputChange}
                />
            </label>
            <fieldset>
                <legend>Genres</legend>
                {allGenres.map((genre) => (
                    <label key={genre.id}>
                        <input
                            type="checkbox"
                            value={genre.id}
                            checked={movie.genres.includes(genre.id)}
                            onChange={handleGenreChange}
                        />
                        {genre.genre}
                    </label>
                ))}
            </fieldset>
            <button type="submit">Update Movie</button>
        </form>
    );
};

export default MovieEdit;