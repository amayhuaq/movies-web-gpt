import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';

const MovieList = () => {
    const [movies, setMovies] = useState([]);

    useEffect(() => {
        const fetchMovies = async () => {
            try {
                const response = await fetch('http://localhost:8080/movies');
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const data = await response.json();
                setMovies(data);
            } catch (error) {
                console.error("Error fetching data: ", error);
            }
        };

        fetchMovies();
    }, []);

    return (
        <div>
            <h2>Movies List</h2>
            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Release Date</th>
                        <th>Runtime</th>
                        <th>MPAA Rating</th>
                        {/* Add more headers as per your columns */}
                    </tr>
                </thead>
                <tbody>
                    {movies.map(movie => (
                        <tr key={movie.id}>
                            <td><Link to={`/movies/edit/${movie.id}`}>{movie.title}</Link></td>
                            <td>{movie.releaseDate}</td>
                            <td>{movie.runtime}</td>
                            <td>{movie.mpaaRating}</td>
                            {/* Add more data cells as per your columns */}
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default MovieList;