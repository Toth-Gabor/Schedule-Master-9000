package com.codecool.web.service.simple;

import com.codecool.web.dao.UserDao;
import com.codecool.web.model.User;
import com.codecool.web.service.UserService;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;

public class SimpleUserService implements UserService {
    
    private final UserDao userDao;
    
    public SimpleUserService(UserDao userDao) {
        this.userDao = userDao;
    }
    
    @Override
    public void addUser(String name, String email, String password, boolean isAdmin) throws SQLException, SecurityException{
        userDao.add(name, email, password, isAdmin);
    }

    @Override
    public boolean validateEmail(String email) throws SQLException, ServiceException {
        return userDao.validateEmail(email);
    }

    @Override
    public User getbyEmail(String email) throws ServiceException, SQLException {
        return userDao.findByEmail(email);
    }
}
