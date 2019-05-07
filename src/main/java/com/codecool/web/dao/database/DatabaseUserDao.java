package com.codecool.web.dao.database;

import com.codecool.web.dao.UserDao;
import com.codecool.web.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public final class DatabaseUserDao extends AbstractDao implements UserDao {

    public DatabaseUserDao(Connection connection) {
        super(connection);
    }

    public List<User> findAll() throws SQLException {
        String sql = "SELECT id, user_name, administrator, email, user_password FROM users";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            List<User> users = new ArrayList<>();
            while (resultSet.next()) {
                users.add(fetchUser(resultSet));
            }
            return users;
        }
    }
    
    public List<User> findAllAdmin(boolean admin) throws SQLException {
        String sql = "SELECT id, user_name, administrator, email, user_password FROM users where administrator =?";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
             statement.setBoolean(1, admin);
             try(ResultSet resultSet = statement.executeQuery()){
                 List<User> users = new ArrayList<>();
                 while (resultSet.next()){
                     users.add(fetchUser(resultSet));
                 }
                 return users;
             }
        }
    }

    @Override
    public User findByEmail(String email) throws SQLException {
        if (email == null || "".equals(email)) {
            throw new IllegalArgumentException("Email cannot be null or empty");
        }
        String sql = "SELECT id, user_name, administrator, email, user_password FROM users WHERE email = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return fetchUser(resultSet);
                }
            }
        }
        return null;
    }

    @Override
    public void add(String username, String email, String pw, boolean admin) throws SQLException {
        String sql = "INSERT INTO users(username, email, user_password, administrator) VALUES(?,?,?,?);";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            statement.setString(2, email);
            statement.setString(3, pw);
            statement.setBoolean(4, admin);
            statement.execute();

        }
    }

    @Override
    public void update(User user, String name, String pw) throws SQLException {
        String sql = "UPDATE users SET username = ?, user_password = ? WHERE user_id = ?;";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setString(1, name);
            statement.setString(2, pw);
            statement.setInt(3, user.getId());;
            statement.execute();
        }
    }

    private User fetchUser(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id");
        String name = resultSet.getString("user_name");
        boolean admin = resultSet.getBoolean("administrator");
        String email = resultSet.getString("email");
        String password = resultSet.getString("password");
        return new User(id, name, admin, email, password);
    }
}
