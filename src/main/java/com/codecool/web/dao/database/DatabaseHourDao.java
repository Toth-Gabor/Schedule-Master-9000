package com.codecool.web.dao.database;

import com.codecool.web.dao.HourDao;
import com.codecool.web.model.Hour;
import com.codecool.web.model.Schedule;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseHourDao extends AbstractDao implements HourDao {
    DatabaseHourDao(Connection connection) {
        super(connection);
    }

    public List<Hour> findAll() throws SQLException {
        String sql = "SELECT hour_id, hour_value, task_id, day_id FROM hour";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            List<Hour> hours = new ArrayList<>();
            while (resultSet.next()) {
                hours.add(fetchHour(resultSet));
            }
            return hours;
        }
    }

    @Override
    public List<Hour> findbyHourValue(int hourValue) throws SQLException {
        String sql = "SELECT hour_id, hour_value, task_id, day_id FROM hour WHERE hour_value = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, hourValue);
            List<Hour> hours = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    hours.add(fetchHour(resultSet));
                }
                return hours;
            }
        }
    }

    @Override
    public List<Hour> findbyTaskId(int taskId) throws SQLException {
        String sql = "SELECT hour_id, hour_value, task_id, day_id FROM hour WHERE task_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, taskId);
            List<Hour> hours = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    hours.add(fetchHour(resultSet));
                }
                return hours;
            }
        }
    }

    @Override
    public List<Hour> findbyDayId(int dayId) throws SQLException {
        String sql = "SELECT hour_id, hour_value, task_id, day_id FROM hour WHERE day_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, dayId);
            List<Hour> hours = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    hours.add(fetchHour(resultSet));
                }
                return hours;
            }
        }
    }

    @Override
    public void delete(Hour hour) throws SQLException {
        String sql = "DELETE FROM hour WHERE hour_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, hour.getDayId());
            statement.execute();
        }
    }

    private Hour fetchHour(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("hour_id");
        int hourValue = resultSet.getInt("hour_value");
        int taskId = resultSet.getInt("task_id");
        int dayId = resultSet.getInt("day_id");
        return new Hour(id, hourValue, taskId, dayId);
    }

}
