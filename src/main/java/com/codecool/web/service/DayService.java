package com.codecool.web.service;

import com.codecool.web.model.Day;
import com.codecool.web.model.Schedule;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public interface DayService {
    
    List<Day> getAll() throws SQLException;
    
    Day getById(String id) throws SQLException, ServiceException;
    
    List<Day> getByName(String name) throws SQLException;
    
    List<Day> getByScheduleId(int scheduleId) throws SQLException, ServiceException;
    
    void delete(Object o) throws SQLException, ServiceException;
    
    void add(String name, Schedule schedule) throws SQLException, ServiceException;
    
    void update(Object o, String name) throws SQLException, ServiceException;
}
