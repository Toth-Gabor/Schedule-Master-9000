package com.codecool.web.dao;

import com.codecool.web.model.Schedule;

import java.sql.SQLException;
import java.util.List;

public interface ScheduleDao {

    List<Schedule> findbyIsPublished(boolean isPublished) throws SQLException;
    List<Schedule> findbyUserId(int userId) throws SQLException;
    void delete(Schedule schedule) throws SQLException;
}
