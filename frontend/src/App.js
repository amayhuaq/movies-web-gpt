import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HomePage from './views/HomePage';
import MovieList from './views/MovieList';
import MovieDetails from './views/MovieDetails';
import GenreList from './views/GenreList';
import AddMovie from './views/AddMovie';
import GraphQLSearch from './views/GraphQLSearch';
import MoviesByGenre from './views/MoviesByGenre';
import Login from './components/Login';
import { AuthProvider } from './context/AuthContext';
import ProtectedRoute from './components/ProtectedRoute';
import Navbar from './components/Navbar';
import MovieEdit from './views/MovieEdit';

const App = () => {
    return (
        <AuthProvider>
            <Router>
                <Navbar />
                <Routes>
                    <Route path="/" element={<HomePage />} />
                    <Route path="/movies" element={<MovieList />} />
                    <Route path="/movies/:movieId" element={<MovieDetails />} />
                    <Route path="/genres" element={<GenreList />} />
                    <Route path="/login" element={<Login />} />
                    <Route
                        path="/add-movie"
                        element={
                            <ProtectedRoute element={<AddMovie />} />
                        }
                    />
                    <Route
                        path="/graphql-search"
                        element={
                            <ProtectedRoute element={<GraphQLSearch />} />
                        }
                    />
                    <Route path="/genres/:genreId" element={<MoviesByGenre />} />
                    <Route path="/movies/edit/:id" element={<MovieEdit />} />
                </Routes>
            </Router>
        </AuthProvider>
    );
};

export default App;