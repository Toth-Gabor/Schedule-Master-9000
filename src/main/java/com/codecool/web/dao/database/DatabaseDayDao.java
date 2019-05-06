package com.codecool.web.dao.database;

import com.codecool.web.dao.DayDao;
import com.codecool.web.model.Day;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DatabaseDayDao extends AbstractDao implements DayDao {
    
    DatabaseDayDao(Connection connection) {
        super(connection);
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
    public Day findByScheduleId(int scheduleId) throws SQLException {
        String sql = "Select day_id, day_name, schedule_id from days where schedule_id=?";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1, scheduleId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return fetchDay(resultSet);
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
    
    private Day fetchDay(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("day_id");
        String name = resultSet.getString("day_name");
        int scheduleId = resultSet.getInt("schedule_id");
        return new Day(id, name, scheduleId);
    }
}
