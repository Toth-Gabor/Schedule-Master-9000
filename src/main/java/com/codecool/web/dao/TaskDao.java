package com.codecool.web.dao;

import com.codecool.web.model.Task;

import java.sql.SQLException;
import java.util.List;

public interface TaskDao {
    
    List<Task> findAll() throws  SQLException;
    List<Task> findbyName(String name) throws SQLException;
    List<Task> findbyContent(String content) throws SQLException;
    List<Task> findbyScheduleId(int scheduleId) throws SQLException;
    Task findbyId(int taskId) throws SQLException;
    List<Task> findbyUserId(int userId) throws SQLException;
    void delete(Task task) throws SQLException;
    void add(String name, String content, int userId) throws SQLException;
    void update(Task task, String name, String content) throws SQLException;
}
