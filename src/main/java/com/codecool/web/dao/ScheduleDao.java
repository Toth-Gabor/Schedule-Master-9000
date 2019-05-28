package com.codecool.web.dao;

import com.codecool.web.model.Schedule;
import com.codecool.web.model.Task;

import java.sql.SQLException;
import java.util.List;

public interface ScheduleDao {

    List<Schedule> findAll() throws SQLException;

    List<Schedule> findbyIsPublishedButNowOwn(int userId) throws SQLException;

    List<Schedule> findbyUserId(int userId) throws SQLException;

    Schedule findById(int scheduleId) throws SQLException;

    void delete(Schedule schedule) throws SQLException;

    void add(boolean isPublished, int userId, int dayValue, String[] dayNames) throws SQLException;

    void addTask(Task task, int dayId, int hourId) throws SQLException;

    int findScheduleId(int userId) throws SQLException;

    void update(Schedule schedule, boolean isPublished) throws SQLException;

    void addDays(String dayName, int scheduleId) throws SQLException;

}
