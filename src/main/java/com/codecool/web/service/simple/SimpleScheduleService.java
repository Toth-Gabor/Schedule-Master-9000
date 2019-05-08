package com.codecool.web.service.simple;

import com.codecool.web.dao.ScheduleDao;
import com.codecool.web.model.Hour;
import com.codecool.web.model.Schedule;
import com.codecool.web.service.ScheduleService;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public class SimpleScheduleService implements ScheduleService {
    private final ScheduleDao scheduleDao;

    public SimpleScheduleService(ScheduleDao scheduleDao) {
        this.scheduleDao = scheduleDao;
    }


    @Override
    public List<Schedule> getAll() throws SQLException {
        return scheduleDao.findAll();
    }

    @Override
    public List<Schedule> getbyIsPublished(boolean isPublished) throws SQLException {
        return scheduleDao.findbyIsPublished(isPublished);
    }

    @Override
    public List<Schedule> getbyUserId(String userId) throws SQLException, ServiceException {
        try {
            return scheduleDao.findbyUserId(Integer.parseInt(userId));
        }catch (NumberFormatException ex) {
            throw new ServiceException("User ID must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }

    @Override
    public void delete(Object object) throws SQLException, ServiceException {
        if (object instanceof Schedule){
            scheduleDao.delete((Schedule) object);
        }else{
            throw new ServiceException("Not type a of schedule");
        }
    }

    @Override
    public void add(boolean isPublished, String userId) throws SQLException, ServiceException {
        try {
            scheduleDao.add(isPublished, Integer.parseInt(userId));
        }catch (NumberFormatException ex) {
            throw new ServiceException("User ID must be an integer");
        } catch (IllegalArgumentException ex) {
            throw new ServiceException(ex.getMessage());
        }


    }

    @Override
    public void update(Object object, boolean isPublished) throws SQLException {

    }

}
