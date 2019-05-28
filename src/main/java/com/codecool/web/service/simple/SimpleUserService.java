package com.codecool.web.service.simple;

import com.codecool.web.dao.UserDao;
import com.codecool.web.model.User;
import com.codecool.web.service.UserService;

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
}
