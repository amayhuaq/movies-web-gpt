import React, { createContext, useContext, useState } from 'react';

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
    const [authData, setAuthData] = useState(null);

    const login = (data) => {
        setAuthData(data);
    };

    const logout = () => {
        setAuthData(null);
        localStorage.removeItem('token'); // If you're storing the token in localStorage
    };

    const isAuth = () => {
        return authData != null;
    };

    return (
        <AuthContext.Provider value={{ isAuth, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};

export const useAuth = () => useContext(AuthContext);