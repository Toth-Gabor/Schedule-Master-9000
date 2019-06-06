package com.codecool.web.service.simple;

import com.codecool.web.dao.HourDao;
import com.codecool.web.dao.ScheduleDao;
import com.codecool.web.dao.TaskDao;
import com.codecool.web.dao.database.DatabaseHourDao;
import com.codecool.web.dao.database.DatabaseTaskDao;
import com.codecool.web.model.Day;
import com.codecool.web.model.Hour;
import com.codecool.web.model.Schedule;
import com.codecool.web.service.HourService;
import com.codecool.web.service.ScheduleService;
import com.codecool.web.service.exception.ServiceException;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
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

    @Override
    public String[][] getAllTaskNames(List<Day> dayList, Connection connection) throws SQLException {
        TaskDao taskDao = new DatabaseTaskDao(connection);
        String[][] allTaskNames = new String[dayList.size()][24];
        //service
        for (int i = 0; i < dayList.size(); i++) {
            String[] tasknames = taskDao.findhourContentList(dayList.get(i).getId());
            allTaskNames[i] = tasknames;

        }
        return allTaskNames;
    }
    
    @Override
    public List<Hour> getHourList(List<Day> dayList, HourService hourService) throws SQLException, ServiceException {
        List<Hour> hourList = new ArrayList<>();
        for (int i = 0; i < dayList.size(); i++) {
            List<Hour> hourListForDayId = hourService.getbyDayId(dayList.get(i).getId());
            for (Hour hour : hourListForDayId) {
                hourList.add(hour);
            }
        }
        return hourList;
    }
}
