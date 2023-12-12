import React from 'react';
import { render, screen } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import GenreList from './GenreList';

import '@testing-library/jest-dom';


beforeEach(() => {
    global.fetch = jest.fn(() =>
        Promise.resolve({
            ok: true,
            json: () => Promise.resolve([
              { id: 1, genre: 'Action' },
              { id: 2, genre: 'Comedy' },
              // Add more genres as needed
            ]),
          })
    );
});

it('fetches and displays genres', async () => {
    render(
        <MemoryRouter>
          <GenreList />
        </MemoryRouter>
      );

  const actionGenre = await screen.findByText('Action');
  const comedyGenre = await screen.findByText('Comedy');

  expect(actionGenre).toBeInTheDocument();
  expect(comedyGenre).toBeInTheDocument();
  expect(fetch).toHaveBeenCalledTimes(1);
});