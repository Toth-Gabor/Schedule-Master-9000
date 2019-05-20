package com.codecool.web.dao.database;

import com.codecool.web.dao.HourDao;
import com.codecool.web.dao.TaskDao;
import com.codecool.web.model.Hour;
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
        String sql = "SELECT task.task_id, task_name, task_content, task.user_id FROM task\n" +
            " INNER JOIN hour_task ON task.task_id = hour_task.task_id\n" +
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
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, task.getId());
            statement.execute();
        }
    }

    @Override
    public void add(String name, String content, int userId) throws SQLException {
        String sql = "INSERT INTO task (task_name, task_content, user_id) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);
            statement.setString(2, content);
            statement.setInt(3, userId);
            statement.execute();
        }
    }

    @Override
    public void update(Task task, String name, String content) throws SQLException {
        String sql = "UPDATE task SET task_name = ?, task_content = ? WHERE task_id = ?;";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, name);
            statement.setString(2, content);
            statement.setInt(3, task.getId());
            statement.execute();
        }
    }

    @Override
    public String[] findhourContentList(int dayId) throws SQLException {
        HourDao hourDao = new DatabaseHourDao(connection);
        List<Hour> hours = hourDao.findbyDayId(dayId);
        String[] hourtaskArray = new String[24];
        for (int i = 0; i < hours.size(); i++) {
            String sql = "SELECT task_name FROM task INNER JOIN hour_task ON task.task_id = hour_task.task_id WHERE hour_task.hour_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, hours.get(i).getId());
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        hourtaskArray[i] = resultSet.getString("task_name");
                    } else {
                        hourtaskArray[i] = "N/A";
                    }
                }
            }

        }
        return hourtaskArray;

    }

    @Override
    public boolean hasbyDayId(int dayId, int taskId) throws SQLException {
        String sql = "SELECT task.task_id, task_name, task_content, task.user_id FROM task\n" +
            " INNER JOIN hour_task ON task.task_id = hour_task.task_id\n" +
            " INNER JOIN hour ON hour.hour_id = hour_task.hour_id\n " +
            " INNER JOIN days ON days.day_id = hour.day_id\n" +
            " WHERE days.day_id = ? AND task.task_id = ?;";


        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, dayId);
            statement.setInt(1, taskId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();

            }
        }
    }

    @Override
    public boolean hasbyHourId(int hourId, int taskId) throws SQLException {
        String sql = "SELECT task.task_id, task_name, task_content, task.user_id FROM task\n" +
            " INNER JOIN hour_task ON task.task_id = hour_task.task_id\n" +
            " INNER JOIN hour ON hour.hour_id = hour_task.hour_id\n " +
            " WHERE hour.hour_id = ? AND task.task_id = ?;";


        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, hourId);
            statement.setInt(1, taskId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();

            }
        }

    }

    @Override
    public Object[] findhourIdList(int dayId) throws SQLException {
        HourDao hourDao = new DatabaseHourDao(connection);
        List<Hour> hours = hourDao.findbyDayId(dayId);
        Object[] hourIdArray = new Object[24];
        for (int i = 0; i < hours.size(); i++) {
            String sql = "SELECT task_name, hour_id FROM task INNER JOIN hour_task ON task.task_id = hour_task.task_id WHERE hour_task.hour_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, hours.get(i).getId());
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        hourIdArray[i] = resultSet.getString("task_name");
                    } else {
                        hourIdArray[i] = hours.get(i).getId();
                    }
                }
            }

        }
        return hourIdArray;
    }

    private Task fetchTask(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("task_id");
        String name = resultSet.getString("task_name");
        String content = resultSet.getString("task_content");
        int userId = resultSet.getInt("user_id");
        return new Task(id, name, content, userId);
    }
}
