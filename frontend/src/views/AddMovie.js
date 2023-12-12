import React, { useState, useEffect } from 'react';

const AddMovie = () => {
    const [movie, setMovie] = useState({
        title: '',
        releaseDate: '',
        runtime: '',
        mpaaRating: '',
        description: '',
        image: ''
    });
    const [genres, setGenres] = useState([]);
    const [selectedGenres, setSelectedGenres] = useState([]);

    useEffect(() => {
        const fetchGenres = async () => {
            try {
                const response = await fetch('http://localhost:8080/genres');
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const data = await response.json();
                setGenres(data);
            } catch (error) {
                console.error("Error fetching genres: ", error);
            }
        };

        fetchGenres();
    }, []);

    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setMovie({ ...movie, [name]: value });
    };

    const handleGenreChange = (event) => {
        const genreId = parseInt(event.target.value);
        setSelectedGenres(
            event.target.checked
                ? [...selectedGenres, genreId]
                : selectedGenres.filter((id) => id !== genreId)
        );
    };

    const handleSubmit = async (event) => {
        event.preventDefault();
        const movieData = {
            ...movie,
            genreIds: selectedGenres,
            runtime: parseInt(movie.runtime) // Assuming runtime is an integer number of minutes
        };

        try {
            const response = await fetch('http://localhost:8080/movies/0', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(movieData)
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            // Reset the form or handle success (e.g., redirect to movies list)
            console.log("Movie added successfully");
        } catch (error) {
            console.error("Error adding movie: ", error);
        }
    };

    return (
        <div>
            <h2>Add a New Movie</h2>
            <form onSubmit={handleSubmit}>
                <label>
                    Title:
                    <input
                        type="text"
                        name="title"
                        value={movie.title}
                        onChange={handleInputChange}
                    />
                </label>
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
                    Runtime (minutes):
                    <input
                        type="number"
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
                    <legend>Select Genres</legend>
                    {genres.map((genre) => (
                        <label key={genre.id}>
                            <input
                                type="checkbox"
                                value={genre.id}
                                onChange={handleGenreChange}
                            />
                            {genre.genre}
                        </label>
                    ))}
                </fieldset>
                <button type="submit">Add Movie</button>
            </form>
        </div>
    );
};

export default AddMovie;