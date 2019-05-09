package com.codecool.web.service;

import com.codecool.web.model.Hour;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public interface HourService {

    List<Hour> getAll() throws SQLException;
    List<Hour> getbyHourValue(String hourValue) throws SQLException, ServiceException;
    List<Hour> getbyDayId(int dayId) throws SQLException, ServiceException;
    void delete(Object object) throws SQLException, ServiceException;
    void add(String hourValue, String dayId) throws SQLException, ServiceException;
    void update(Object object, String hourValue) throws SQLException, ServiceException;
}
