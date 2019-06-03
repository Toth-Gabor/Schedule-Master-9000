package com.codecool.web.service;

import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;

public interface UserService {
    
    void addUser(String name, String password, String email, boolean isAdmin) throws SQLException, ServiceException;
}
