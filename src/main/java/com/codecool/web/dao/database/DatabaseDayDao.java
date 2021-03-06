package com.codecool.web.dao.database;

import com.codecool.web.dao.DayDao;
import com.codecool.web.model.Day;
import com.codecool.web.model.Schedule;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseDayDao extends AbstractDao implements DayDao {
    
    public DatabaseDayDao(Connection connection) {
        super(connection);
    }

    @Override
    public List<Day> findAll() throws SQLException {
        String sql = "Select day_id, day_name, schedule_id from days";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            List<Day> days = new ArrayList<>();
            while (resultSet.next()) {
                days.add(fetchDay(resultSet));
            }
            return days;
        }

    }

    @Override
    public Day findById(int id) throws SQLException {
        String sql = "Select day_id, day_name, schedule_id from days where day_id=?";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                return fetchDay(resultSet);
            }
        }
    }
    
    @Override
    public List<Day> findByName(String name) throws SQLException {
        String sql = "Select day_id, day_name, schedule_id from days where day_name=?";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setString(1, name);
            List<Day> days = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    days.add(fetchDay(resultSet));
                }
                return days;
            }
        }
    }
    
    @Override
    public List<Day> findByScheduleId(int scheduleId) throws SQLException {
        String sql = "Select day_id, day_name, schedule_id from days where schedule_id=?";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1, scheduleId);
            List<Day> days = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    days.add(fetchDay(resultSet));
                }
                return days;
            }
        }
    }
    
    @Override
    public void delete(Day day) throws SQLException {
        String sql = "DELETE FROM days WHERE day_id=?";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1, day.getId());
            statement.execute();
        }
    }
    
    @Override
    public void add(String name, Schedule schedule) throws SQLException {
        String sql = "INSERT INTO days (day_name, schedule_id) VALUES(?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setString(1, name);
            statement.setInt(2, schedule.getId());
            statement.execute();
        }
    }

    @Override
    public void update(Day day, String name) throws SQLException {
        String sql = "UPDATE days SET day_name = ? WHERE day_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setString(1, name);
            statement.setInt(2, day.getId());
            statement.execute();
        }
    }

    private Day fetchDay(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("day_id");
        String name = resultSet.getString("day_name");
        int scheduleId = resultSet.getInt("schedule_id");
        return new Day(id, name, scheduleId);
    }
}
