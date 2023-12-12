import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';

const MoviesByGenre = () => {
    const [movies, setMovies] = useState([]);
    const { genreId } = useParams();

    useEffect(() => {
        const fetchMoviesByGenre = async () => {
            const response = await fetch(`http://localhost:8080/genres/${genreId}/movies`);
            const data = await response.json();
            setMovies(data);
        };

        fetchMoviesByGenre();
    }, [genreId]);

    return (
        <div>
            <h2>{genreId} Movies in Genre</h2>
            {movies ? (
            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Release Date</th>
                        <th>Runtime</th>
                        <th>MPAA Rating</th>
                    </tr>
                </thead>
                <tbody>
                    {movies.map(movie => (
                        <tr key={movie.id}>
                            <td>{movie.title}</td>
                            <td>{movie.releaseDate}</td>
                            <td>{movie.runtime}</td>
                            <td>{movie.mpaaRating}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
            ) : (
                <p>No movies in this genre (yet)!</p>
            )}
        </div>
    );
};

export default MoviesByGenre;