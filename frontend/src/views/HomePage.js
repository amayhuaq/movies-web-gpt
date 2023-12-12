import React from 'react';
import { Link } from 'react-router-dom';

const HomePage = () => {
  return (
    <div>
      <h1>Welcome to My Movie App</h1>
      <p>Explore a wide range of movies and genres.</p>
      <Link to="/movies">View Movies</Link>
      <Link to="/genres">View Genres</Link>
    </div>
  );
};

export default HomePage;