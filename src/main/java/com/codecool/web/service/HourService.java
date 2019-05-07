package com.codecool.web.service;

import com.codecool.web.model.Hour;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public interface HourService {

    List<Hour> getAll() throws SQLException;
    List<Hour> getbyHourValue(String hourValue) throws SQLException, ServiceException;
    List<Hour> getbyTaskId(String taskId) throws SQLException, ServiceException;
    List<Hour> getbyDayId(String dayId) throws SQLException, ServiceException;
    void delete(Hour hour) throws SQLException;
    void add(String hourValue, String taskId, String dayId) throws SQLException, ServiceException;
    void update(Hour hour, String hourValue) throws SQLException;
}
