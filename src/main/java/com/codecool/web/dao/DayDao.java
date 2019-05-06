package com.codecool.web.dao;

import com.codecool.web.model.Day;

import java.sql.SQLException;
import java.util.List;

public interface DayDao {
    
    Day findById(int id) throws SQLException;
    List<Day> findByName(String name) throws SQLException;
    Day findByScheduleId(int scheduleId) throws SQLException;
}
