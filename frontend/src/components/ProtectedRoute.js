import React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const ProtectedRoute = ({ element: Component }) => {
    const { isAuth } = useAuth();
    const location = useLocation();

    return isAuth() ? Component : <Navigate to="/login" state={{ from: location }} replace />;
};

export default ProtectedRoute;