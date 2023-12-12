import React, { useState } from 'react';

const GraphQLSearch = () => {
    const [searchTerm, setSearchTerm] = useState('');

    const handleSearch = (event) => {
        event.preventDefault();
        // Perform the GraphQL search here
        console.log(`Searching for: ${searchTerm}`);
    };

    return (
        <div>
            <h2>GraphQL Movie Search</h2>
            <form onSubmit={handleSearch}>
                <input
                    type="text"
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    placeholder="Search for movies"
                />
                <button type="submit">Search</button>
            </form>
        </div>
    );
};

export default GraphQLSearch;