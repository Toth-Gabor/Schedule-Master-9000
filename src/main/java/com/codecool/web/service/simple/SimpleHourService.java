package com.codecool.web.service.simple;

import com.codecool.web.model.Hour;
import com.codecool.web.service.HourService;

import java.sql.SQLException;
import java.util.List;

public class SimpleHourService implements HourService {
    @Override
    public List<Hour> findbyHourValue(int hourValue) throws SQLException {
        return null;
    }

    @Override
    public List<Hour> findbyTaskId(int taskId) throws SQLException {
        return null;
    }

    @Override
    public List<Hour> findbyDayId(int taskId) throws SQLException {
        return null;
    }

    @Override
    public void delete(Hour hour) throws SQLException {

    }

    @Override
    public void add(int hourValue, int taskId, int dayId) throws SQLException {

    }

    @Override
    public void update(Hour hour, int hourValue) throws SQLException {

    }
}
