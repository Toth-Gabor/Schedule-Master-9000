package com.codecool.web.dao.database;

import com.codecool.web.dao.ScheduleDao;
import com.codecool.web.model.Schedule;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseScheduleDao extends AbstractDao implements ScheduleDao {


    DatabaseScheduleDao(Connection connection) {
        super(connection);
    }

    public List<Schedule> findAll() throws SQLException {
        String sql = "SELECT schedule_id, schedule_published, user_id FROM schedule";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            List<Schedule> schedules = new ArrayList<>();
            while (resultSet.next()) {
                schedules.add(fetchSchedule(resultSet));
            }
            return schedules;
        }
    }

    @Override
    public List<Schedule> findbyIsPublished(boolean isPublished) throws SQLException {
        String sql = "SELECT schedule_id, schedule_published, user_id FROM schedule WHERE schedule_published = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setBoolean(1, isPublished);
            List<Schedule> schedules = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    schedules.add(fetchSchedule(resultSet));
                }
                return schedules;
            }
        }
    }

    @Override
    public List<Schedule> findbyUserId(int userId) throws SQLException {
        String sql = "SELECT schedule_id, schedule_published, user_id FROM schedule WHERE user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            List<Schedule> schedules = new ArrayList<>();
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    schedules.add(fetchSchedule(resultSet));
                }
                return schedules;
            }
        }
    }
    
    @Override
    public void delete(Schedule schedule) throws SQLException {
        String sql = "delete from schedule where schedule_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1, schedule.getId());
            statement.execute();
        }
    }
    
    private Schedule fetchSchedule(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("schedule_id");
        boolean isPublished = resultSet.getBoolean("schedule_published");
        int userId = resultSet.getInt("user_id");
        return new Schedule(id, isPublished, userId);
    }

}
