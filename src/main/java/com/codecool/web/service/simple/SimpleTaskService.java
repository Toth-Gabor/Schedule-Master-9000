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
    public List<Task> getbyScheduleId(int scheduleId) throws SQLException, ServiceException {
        try {
            return taskDao.findbyScheduleId(scheduleId);
        }catch (NumberFormatException ex) {
            throw new ServiceException("User ID must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }

    @Override
    public Task getbyId(int taskId) throws SQLException {
        return taskDao.findbyId(taskId);
    }

    @Override
    public List<Task> getbyUserId(int userId) throws SQLException {
        return taskDao.findbyUserId(userId);
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
    public void add(String name, String content, int userId) throws SQLException, ServiceException {
        try {
            taskDao.add(name, content, userId);
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

    @Override
    public String[] gethourContentList(int dayId) throws SQLException, ServiceException {
        try{
            return taskDao.findhourContentList(dayId);
        }  catch (NumberFormatException ex) {
            throw new ServiceException("Day id must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }

    @Override
    public Object[] gethourIdList(int dayId) throws SQLException, ServiceException {
        return taskDao.findhourIdList(dayId);
    }

    @Override
    public Object[] gethourIdListforDeletTask(int dayId) throws SQLException, ServiceException {
        return taskDao.findhourIdListforDeletTask(dayId);
    }

    @Override
    public boolean isfoundbyDayId(int dayId, int taskId) throws SQLException {
        return taskDao.hasbyDayId(dayId, taskId);
    }

    @Override
    public boolean isfoundbyHourId(int hourId, int taskId) throws SQLException {
        return taskDao.hasbyHourId(hourId, taskId);
    }
}
