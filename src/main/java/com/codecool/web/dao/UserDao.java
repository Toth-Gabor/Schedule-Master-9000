package com.codecool.web.dao;

import com.codecool.web.model.User;

import java.sql.SQLException;
import java.util.List;

public interface UserDao {
    
    List<User> findAll() throws SQLException;
    List<User> findAllAdmin(boolean admin) throws SQLException;
    User findByEmail(String email) throws SQLException;
    void add(String username, String email, String pw, boolean admin) throws SQLException;
    void update(User user, String name, String pw) throws SQLException;
    boolean validateEmail(String email) throws  SQLException;
}
