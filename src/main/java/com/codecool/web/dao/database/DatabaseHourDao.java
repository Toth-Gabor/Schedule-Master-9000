package com.codecool.web.dao.database;

import com.codecool.web.dao.HourDao;
import com.codecool.web.model.Hour;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseHourDao extends AbstractDao implements HourDao {
    public DatabaseHourDao(Connection connection) {
        super(connection);
    }
    
    @Override
    public List<Hour> findAll() throws SQLException {
        String sql = "SELECT hour_id, hour_value, day_id FROM hour";
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
        String sql = "SELECT hour_id, hour_value, day_id FROM hour WHERE hour_value = ?";
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
    public List<Hour> findbyDayId(int dayId) throws SQLException {
        String sql = "SELECT hour_id, hour_value, day_id FROM hour WHERE day_id = ?";
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
    public int findDayIdbyHourValue(int hourValue, int dayId) throws SQLException {
        String sql = "SELECT hour_id FROM hour WHERE day_id = ? AND hour_value = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, dayId);
            statement.setInt(2, hourValue);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    return resultSet.getInt("hour_id");
                }
            }
        }
        return 0;
    }

    @Override
    public void delete(Hour hour) throws SQLException {
        String sql = "DELETE FROM hour WHERE hour_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, hour.getDayId());
            statement.execute();
        }
    }

    @Override
    public void add(int hourValue, int dayId) throws SQLException {
        String sql = "INSERT INTO hour(hour_value, day_id) VALUES(?,?);";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, hourValue);
            statement.setInt(2, dayId);
            statement.execute();

        }
    }
    
    @Override
    public void update(Hour hour,int hourValue) throws SQLException {
        String sql = "UPDATE days SET hour_value = ? WHERE hour_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1, hourValue);
            statement.setInt(2, hour.getId());
            statement.execute();
        }
    }
    
    private Hour fetchHour(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("hour_id");
        int hourValue = resultSet.getInt("hour_value");
        int dayId = resultSet.getInt("day_id");
        return new Hour(id, hourValue, dayId);
    }

}
