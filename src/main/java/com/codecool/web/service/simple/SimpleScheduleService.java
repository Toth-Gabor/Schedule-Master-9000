package com.codecool.web.service.simple;

import com.codecool.web.dao.ScheduleDao;
import com.codecool.web.model.Schedule;
import com.codecool.web.service.ScheduleService;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public class SimpleScheduleService implements ScheduleService {
    private final ScheduleDao scheduleDao;
    public final String[] dayNames = {"first", "second", "third", "forth", "fifth", "sixth", "seventh"};
    
    
    public SimpleScheduleService(ScheduleDao scheduleDao) {
        this.scheduleDao = scheduleDao;
    }


    @Override
    public List<Schedule> getAll() throws SQLException {
        return scheduleDao.findAll();
    }

    @Override
    public List<Schedule> getbyIsPublishedButNowOwn(int userId) throws SQLException {
        return scheduleDao.findbyIsPublishedButNowOwn(userId);
    }

    @Override
    public List<Schedule> getbyUserId(int userId) throws SQLException {
        return scheduleDao.findbyUserId(userId);
    }
    
    @Override
    public Schedule getbyId(int scheduleId) throws SQLException, ServiceException {
        return scheduleDao.findById(scheduleId);
    }
    
    @Override
    public void delete(Object object) throws SQLException, ServiceException {
        if (object instanceof Schedule) {
            scheduleDao.delete((Schedule) object);
        } else {
            throw new ServiceException("Not type a of schedule");
        }
    }

    @Override
    public void add(boolean isPublished, int userId, int dayValue, String[] dayNames) throws SQLException {
        scheduleDao.add(isPublished, userId, dayValue, dayNames);
    }

    @Override
    public void update(Object object, boolean isPublished) throws SQLException, ServiceException {
        if (object instanceof Schedule) {
            scheduleDao.update((Schedule) object, isPublished);
        } else {
            throw new ServiceException("Not type a of schedule");
        }
    }

    @Override
    public void addDays(String dayName, int scheduleId) throws SQLException {
        scheduleDao.addDays(dayName, scheduleId);
    }
}
