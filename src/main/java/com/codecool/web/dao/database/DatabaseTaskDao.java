package com.codecool.web.dao.database;

import com.codecool.web.dao.TaskDao;
import com.codecool.web.model.Schedule;
import com.codecool.web.model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseTaskDao extends AbstractDao implements TaskDao {

    public DatabaseTaskDao(Connection connection) {
        super(connection);
    }

    @Override
    public List<Task> findAll() throws SQLException {
        String sql = "SELECT task_id, task_name, task_content, user_id FROM task";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            List<Task> tasks = new ArrayList<>();
            while (resultSet.next()) {
                tasks.add(fetchTask(resultSet));
            }
            return tasks;
        }
    }

    @Override
    public List<Task> findbyName(String name) throws SQLException {
        String sql = "SELECT task_id, task_name, task_content, user_id FROM task WHERE task_name = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);
            List<Task> tasks = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    tasks.add(fetchTask(resultSet));
                }
                return tasks;
            }
        }
    }

    @Override
    public List<Task> findbyContent(String content) throws SQLException {
        String sql = "SELECT task_id, task_name, task_content, user_id FROM task WHERE task_content = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, content);
            List<Task> tasks = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    tasks.add(fetchTask(resultSet));
                }
                return tasks;
            }
        }
    }

    @Override
    public List<Task> findbyScheduleId(int scheduleId) throws SQLException {
        String sql = "SELECT task.task_id, task_name, task_content, user_id FROM task\n" +
            " INNER JOIN hour_task ON task.task_id = hour_task.task_id\n+" +
            " INNER JOIN hour ON hour.hour_id = hour_task.hour_id\n " +
            " INNER JOIN days ON days.day_id = hour.day_id\n" +
            " INNER JOIN schedule ON schedule.schedule_id = days.schedule_id\n" +
            " WHERE schedule.schedule_id = ?;";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, scheduleId);
            List<Task> tasks = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    tasks.add(fetchTask(resultSet));
                }
                return tasks;
            }
        }
    }

    @Override
    public Task findbyId(int taskId) throws SQLException {
        String sql = "SELECT task_id, task_name, task_content, user_id FROM task WHERE task_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, taskId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    return fetchTask(resultSet);
                }
                return null;
            }
        }
    }

    @Override
    public List<Task> findbyUserId(int userId) throws SQLException {
        String sql = "SELECT task_id, task_name, task_content, user_id FROM task WHERE user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            List<Task> tasks = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    tasks.add(fetchTask(resultSet));
                }
                return tasks;
            }
        }
    }


    @Override
    public void delete(Task task) throws SQLException {
        String sql = "DELETE FROM task WHERE task_id = ?;";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1, task.getId());
            statement.execute();
        }
    }
    
    @Override
    public void add(String name, String content, int userId) throws SQLException {
        String sql = "INSERT INTO task (task_name, task_content, user_id) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setString(1, name);
            statement.setString(2, content);
            statement.setInt(3, userId);
            statement.execute();
        }
    }
    
    @Override
    public void update(Task task, String name, String content) throws SQLException {
        String sql = "UPDATE task SET task_name = ?, task_content = ? WHERE task_id = ?;";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setString(1, name);
            statement.setString(2, content);
            statement.setInt(3, task.getId());
        }
    }
    
    private Task fetchTask(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("task_id");
        String name = resultSet.getString("task_name");
        String content = resultSet.getString("task_content");
        int userId = resultSet.getInt("user_id");
        return new Task(id, name, content, userId);
    }
}
