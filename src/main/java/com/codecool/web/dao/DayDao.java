package com.codecool.web.dao;

import com.codecool.web.model.Day;
import com.codecool.web.model.Schedule;

import java.sql.SQLException;
import java.util.List;

public interface DayDao {

    List<Day> findAll() throws SQLException;
    Day findById(int id) throws SQLException;
    List<Day> findByName(String name) throws SQLException;
    List<Day> findByScheduleId(int scheduleId) throws SQLException;
    void delete(Day day) throws SQLException;
    void add(String name, Schedule schedule) throws SQLException;
    void update(Day day, String name) throws SQLException;
}
