package com.codecool.web.service;

import com.codecool.web.dao.HourDao;
import com.codecool.web.model.Day;
import com.codecool.web.model.Hour;
import com.codecool.web.model.Schedule;
import com.codecool.web.service.exception.ServiceException;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public interface ScheduleService {
    List<Schedule> getAll() throws SQLException;
    List<Schedule> getbyIsPublishedButNowOwn(int userId) throws SQLException;
    List<Schedule> getbyUserId(int userId) throws SQLException, ServiceException;
    Schedule getbyId(int scheduleId) throws SQLException, ServiceException;
    void delete(Object object) throws SQLException, ServiceException;
    void add(boolean isPublished, int userId, int dayValue, String[] dayNames) throws SQLException;
    void update(Object object, boolean isPublished) throws SQLException, ServiceException;
    void addDays(String dayName, int scheduleId) throws SQLException;
    String[][] getAllTaskNames(List<Day> dayList, Connection connection) throws SQLException;
    List<Hour> getHourList(List<Day> dayList, HourService hourService) throws SQLException, ServiceException;
}
