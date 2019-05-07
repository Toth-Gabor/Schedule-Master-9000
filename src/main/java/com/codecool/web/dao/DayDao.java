package com.codecool.web.dao;

import com.codecool.web.model.Day;
import org.springframework.jdbc.support.xml.SqlXmlFeatureNotImplementedException;

import java.sql.SQLException;
import java.util.List;

public interface DayDao {
    
    Day findById(int id) throws SQLException;
    List<Day> findByName(String name) throws SQLException;
    Day findByScheduleId(int scheduleId) throws SQLException;
    void delete(Day day) throws SQLException;
    void add(String name, int scheduleId) throws SQLException;
    void update(Day day, String name) throws SQLException;
}
