package com.codecool.web.service;

import com.codecool.web.model.Task;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public interface TaskService {
    
    List<Task> getAll() throws SQLException;
    List<Task> getbyName(String name) throws SQLException;
    List<Task> getbyContent(String content) throws SQLException;
    List<Task> findbyScheduleId(String scheduleId) throws SQLException, ServiceException;
    Task getbyId(int taskId) throws SQLException;
    List<Task> getbyUserId(int userId) throws SQLException;
    void delete(Object o) throws SQLException, ServiceException;
    void add(String name, String content, int userId) throws SQLException, ServiceException;
    void update(Object o, String name, String content) throws SQLException, ServiceException;
}
