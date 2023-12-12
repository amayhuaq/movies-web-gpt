import React from 'react';
import { render, screen, waitFor } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import MovieList from './MovieList';

// Import the extended assertions
import '@testing-library/jest-dom';

// This is an example of how you might structure the movie data
const mockMovies = [
    { id: 1, title: 'Movie One', releaseDate: '2021-07-16', runtime: '120', mpaaRating: 'PG' },
    { id: 2, title: 'Movie Two', releaseDate: '2021-08-01', runtime: '95', mpaaRating: 'PG-13' },
    // ... more movies
  ];
  
beforeEach(() => {
    global.fetch = jest.fn(() =>
        Promise.resolve({
        json: () => Promise.resolve(mockMovies),
        ok: true,
        }),
    );
});

afterEach(() => {
    jest.restoreAllMocks();
});

it('fetches and displays movies', async () => {
  render(
    <MemoryRouter>
        <MovieList />
    </MemoryRouter>
  );

    // Wait for the movies to be fetched and displayed
    for (const movie of mockMovies) {
        await waitFor(() => {
            //expect(screen.getByText(/movie 1/i)).toBeInTheDocument();
            //expect(screen.getByText(/movie 2/i)).toBeInTheDocument();
            expect(screen.getByText(movie.title)).toBeInTheDocument();
            expect(screen.getByText(movie.releaseDate)).toBeInTheDocument();
            // More assertions as needed
        })
    }
    // Check that the fetch was called correctly
    expect(fetch).toHaveBeenCalledWith('http://localhost:8080/movies');
    expect(fetch).toHaveBeenCalledTimes(1);
});