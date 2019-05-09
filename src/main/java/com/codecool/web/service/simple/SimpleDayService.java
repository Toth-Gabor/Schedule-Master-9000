package com.codecool.web.service.simple;

import com.codecool.web.dao.DayDao;
import com.codecool.web.model.Day;
import com.codecool.web.model.Schedule;
import com.codecool.web.service.DayService;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;
import java.util.Objects;

public class SimpleDayService implements DayService {
    
    private final DayDao dayDao;
    
    public SimpleDayService(DayDao dayDao) {
        this.dayDao = dayDao;
    }
    
    @Override
    public List<Day> getAll() throws SQLException {
        return dayDao.findAll();
    }
    
    @Override
    public Day getById(String id) throws SQLException, ServiceException {
        try {
            return dayDao.findById(Integer.parseInt(id));
        }  catch (NumberFormatException ex) {
            throw new ServiceException("Day id must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }
    
    @Override
    public List<Day> getByName(String name) throws SQLException {
        return dayDao.findByName(name);
    }
    
    @Override
    public Day getByScheduleId(String scheduleId) throws SQLException, ServiceException {
        try {
            return dayDao.findByScheduleId(Integer.parseInt(scheduleId));
        }  catch (NumberFormatException ex) {
            throw new ServiceException("Schedule id must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }
    
    @Override
    public void delete(Object o) throws SQLException, ServiceException {
        if (o instanceof Day){
            dayDao.delete((Day)o);
        } else {
            throw new ServiceException("Not type of day");
        }
    }
    
    @Override
    public void add(String name, Schedule schedule) throws SQLException, ServiceException {
        try {
            dayDao.add(name, schedule);
        }  catch (NumberFormatException ex) {
            throw new ServiceException("Schedule id must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }
    
    @Override
    public void update(Object o, String name) throws SQLException, ServiceException {
        if (o instanceof Day){
            dayDao.update((Day)o, name);
        } else {
            throw new ServiceException("Not type of day");
        }
    }
}
