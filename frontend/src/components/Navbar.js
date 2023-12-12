import React from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const Navbar = () => {
    const { isAuth, logout } = useAuth();
    
    return (
        <nav>
            {/* Always-visible links */}
            <Link to="/">Home</Link>
            <Link to="/movies">Movies</Link>
            <Link to="/genres">Genres</Link>

            {/* Links visible only to logged-in users */}
            {isAuth() && (
                <>
                    <Link to="/add-movie">Add Movie</Link>
                    <Link to="/graphql-search">GraphQL Search</Link>
                </>
            )}

            {/* Conditional link based on auth status */}
            {!isAuth() ? (
                <Link to="/login">Login</Link>
            ) : (
                // Add a logout button or link if already logged in
                // This should also clear the auth state
                <button onClick={() => logout()}>Logout</button>
            )}
        </nav>
    );
};

export default Navbar;