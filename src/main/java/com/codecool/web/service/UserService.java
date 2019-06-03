package com.codecool.web.service;

import com.codecool.web.model.User;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;

public interface UserService {
    
    void addUser(String name, String email, String password, boolean isAdmin) throws SQLException, ServiceException;
    boolean validateEmail(String email) throws SQLException, ServiceException;
    User getbyEmail(String email) throws ServiceException, SQLException;
}
