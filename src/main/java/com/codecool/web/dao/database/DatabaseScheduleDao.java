package com.codecool.web.dao.database;

import com.codecool.web.dao.DayDao;
import com.codecool.web.dao.HourDao;
import com.codecool.web.dao.ScheduleDao;
import com.codecool.web.model.Day;
import com.codecool.web.model.Schedule;
import com.codecool.web.model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class DatabaseScheduleDao extends AbstractDao implements ScheduleDao {


    public DatabaseScheduleDao(Connection connection) {
        super(connection);
    }
    //string sql kiemelni egy konstansba

    @Override
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
    public List<Schedule> findbyIsPublishedButNowOwn(int userId) throws SQLException {
        String sql = "SELECT schedule_id, schedule_published, user_id FROM schedule WHERE NOT user_id = ?";
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
    public int findScheduleId(int userId) throws SQLException {
        String sql = "SELECT schedule_id FROM schedule WHERE user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    return resultSet.getInt("schedule_id");
                }
                return 0;
            }
        }
    }

    @Override
    public Schedule findById(int scheduleId) throws SQLException {
        String sql = "SELECT schedule_id, schedule_published, user_id FROM schedule WHERE schedule_id = ?";
        Schedule schedule = null;
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, scheduleId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    schedule = fetchSchedule(resultSet);
                }
            }
        }
        return schedule;
    }

    @Override
    public void delete(Schedule schedule) throws SQLException {
        String sql = "DELETE FROM schedule WHERE schedule_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, schedule.getId());
            statement.execute();
        }
    }

    @Override
    public void add(boolean isPublished, int userId, int dayValue, String[] dayNames) throws SQLException {
        HourDao hourDao = new DatabaseHourDao(connection);
        DayDao dayDao = new DatabaseDayDao(connection);
        String sql = "INSERT INTO schedule(schedule_published, user_id) VALUES(?,?);";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setBoolean(1, isPublished);
            statement.setInt(2, userId);
            statement.execute();

            int scheduleId;
            try (ResultSet resultSet = statement.getGeneratedKeys()) {
                if (resultSet.next()) {
                    scheduleId = resultSet.getInt(1);
                    for (int i = 0; i < dayValue; i++) {
                        addDays(dayNames[i], scheduleId);
                        List<Day> days = dayDao.findByScheduleId(scheduleId);
                        days.sort(Comparator.comparing(Day::getId));
                        for (int j = 0; j < 24; j++) {
                            hourDao.add(j, days.get(i).getId());
                        }
                    }
                } else {
                    throw new SQLException("Expected 1 result");
                }
            }
        }


    }

    @Override
    public void addTask(Task task, int dayId, int hourValue) throws SQLException {
        HourDao hourDao = new DatabaseHourDao(connection);
        int dayIdbyHourValue = hourDao.findDayIdbyHourValue(hourValue, dayId);
        String sql = "INSERT INTO hour_task(task_id, hour_id) VALUES(?,?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, task.getId());
            statement.setInt(2, dayIdbyHourValue);
            statement.execute();
        }
    }


    @Override
    public void update(Schedule schedule, boolean isPublished) throws SQLException {
        String sql = "UPDATE schedule SET schedule_published = ? WHERE schedule_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setBoolean(1, isPublished);
            statement.setInt(2, schedule.getId());
            statement.executeUpdate();
        }
    }

    @Override
    public void addDays(String dayName, int scheduleId) throws SQLException {
        String sql = "INSERT INTO days(day_name, schedule_id) VALUES(?,?);";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, dayName);
            statement.setInt(2, scheduleId);
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
