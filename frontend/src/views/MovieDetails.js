import React from 'react';
import { useParams } from 'react-router-dom';

const MovieDetails = () => {
    const { movieId } = useParams();
    // Fetch or find the movie details using movieId

    return (
        <div>
            <h2>Movie Details</h2>
            {/* Display movie details here */}
            <p>Details for movie ID: {movieId}</p>
        </div>
    );
};

export default MovieDetails;