package com.codecool.web.service;

import com.codecool.web.model.Schedule;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public interface ScheduleService {
    List<Schedule> getAll() throws SQLException;
    List<Schedule> getbyIsPublished(boolean isPublished) throws SQLException;
    List<Schedule> getbyUserId(String userId) throws SQLException, ServiceException;
    void delete(Object object) throws SQLException, ServiceException;
    void add(boolean isPublished, String userId) throws SQLException, ServiceException;
    void update(Object object, boolean isPublished) throws SQLException;
}
