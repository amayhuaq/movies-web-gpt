// src/views/GenreList.js
import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';

const GenreList = () => {
    const [genres, setGenres] = useState([]);

    useEffect(() => {
        /*const fetchGenres = async () => {
            const response = await fetch('http://localhost:8080/genres');
            const data = await response.json();
            setGenres(data);
        };
        */
        const fetchGenres = async () => {
            const response = await fetch('http://localhost:8080/genres');
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();
            setGenres(data); // Ensure this is your state setter function
        };
        fetchGenres();
    }, []);

    return (
        <div>
            <h2>Genres</h2>
            <ul>
                {genres.map(genre => (
                    <li key={genre.id}>
                        <Link to={`/genres/${genre.id}`}>{genre.genre}</Link>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default GenreList;