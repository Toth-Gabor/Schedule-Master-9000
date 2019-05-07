package com.codecool.web.service.simple;

import com.codecool.web.dao.HourDao;
import com.codecool.web.model.Hour;
import com.codecool.web.service.HourService;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public class SimpleHourService implements HourService {
    private final HourDao hourDao;


    public SimpleHourService(HourDao hourDao) {
        this.hourDao = hourDao;
    }

    @Override
    public List<Hour> getAll() throws SQLException {
       return hourDao.findAll();
    }

    @Override
    public List<Hour> getbyHourValue(String hourValue) throws SQLException, ServiceException {
        try {
            return hourDao.findbyHourValue(Integer.parseInt(hourValue));
        }catch (NumberFormatException ex) {
            throw new ServiceException("Hour value must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }

    @Override
    public List<Hour> getbyTaskId(String taskId) throws SQLException, ServiceException {
        try {
            return hourDao.findbyTaskId(Integer.parseInt(taskId));
        }catch (NumberFormatException ex) {
            throw new ServiceException("Task ID must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }

    @Override
    public List<Hour> getbyDayId(String dayId) throws SQLException, ServiceException {
        try {
            return hourDao.findbyDayId(Integer.parseInt(dayId));
        }catch (NumberFormatException ex) {
            throw new ServiceException("Day ID must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }

    @Override
    public void delete(Hour hour) throws SQLException {

    }

    @Override
    public void add(String hourValue, String taskId, String dayId) throws SQLException, ServiceException {
        try {
            hourDao.add(Integer.parseInt(hourValue), Integer.parseInt(taskId), Integer.parseInt(dayId));
        }catch (NumberFormatException ex) {
            throw new ServiceException("Hour value must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }

    }

    @Override
    public void update(Hour hour, String hourValue) throws SQLException {

    }

}
