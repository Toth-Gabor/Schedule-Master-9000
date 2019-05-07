package com.codecool.web.service.simple;

import com.codecool.web.dao.DayDao;
import com.codecool.web.model.Day;
import com.codecool.web.service.DayService;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

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
    public void delete(Day day) throws SQLException {
    
    }
    
    @Override
    public void add(String name, String scheduleId) throws SQLException, ServiceException {
        try {
            dayDao.add(name, Integer.parseInt(scheduleId));
        }  catch (NumberFormatException ex) {
            throw new ServiceException("Schedule id must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    
    }
    
    @Override
    public void update(Day day, String name) throws SQLException {
    
    }
}
