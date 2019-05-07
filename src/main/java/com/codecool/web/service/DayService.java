package com.codecool.web.service;

import com.codecool.web.model.Day;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public interface DayService {
    
    List<Day> getAll() throws SQLException;
    Day getById(String id) throws SQLException, ServiceException;
    List<Day> getByName(String name) throws SQLException;
    Day getByScheduleId(String scheduleId) throws SQLException, ServiceException;
    void delete(Day day) throws SQLException;
    void add(String name, String scheduleId) throws SQLException, ServiceException;
    void update(Day day, String name) throws SQLException;
}
