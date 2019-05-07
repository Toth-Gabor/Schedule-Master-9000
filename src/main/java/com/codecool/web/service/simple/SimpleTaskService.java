package com.codecool.web.service.simple;

import com.codecool.web.dao.TaskDao;
import com.codecool.web.model.Task;
import com.codecool.web.service.TaskService;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public class SimpleTaskService implements TaskService {
    
    private final TaskDao taskDao;
    
    public SimpleTaskService(TaskDao taskDao) {
        this.taskDao = taskDao;
    }
    
    @Override
    public List<Task> getAll() throws SQLException {
        return taskDao.findAll();
    }
    
    @Override
    public List<Task> getbyName(String name) throws SQLException {
        return taskDao.findbyName(name);
    }
    
    @Override
    public List<Task> getbyContent(String content) throws SQLException {
        return taskDao.findbyContent(content);
    }

    @Override
    public List<Task> findbyScheduleId(String scheduleId) throws SQLException, ServiceException {
        try {
            return taskDao.findbyScheduleId(Integer.parseInt(scheduleId));
        }catch (NumberFormatException ex) {
            throw new ServiceException("User ID must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }


    @Override
    public void delete(Object o) throws SQLException, ServiceException {
        if (o instanceof Task){
            taskDao.delete((Task) o);
        } else {
            throw new ServiceException("Not type of Task");
        }
    }
    
    @Override
    public void add(String name, String content) throws SQLException, ServiceException {
        try {
            taskDao.add(name, content);
        }  catch (NumberFormatException ex) {
            throw new ServiceException("Schedule id must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }
    
    @Override
    public void update(Object o, String name, String content) throws SQLException, ServiceException {
        if (o instanceof Task){
            taskDao.update((Task) o, name, content);
        } else {
            throw new ServiceException("Not type of Task");
        }
    }
}
