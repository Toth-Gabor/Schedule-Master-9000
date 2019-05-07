package com.codecool.web.service;

import com.codecool.web.model.Hour;

import java.sql.SQLException;
import java.util.List;

public interface HourService {

    List<Hour> findbyHourValue(int hourValue) throws SQLException;
    List<Hour> findbyTaskId(int taskId) throws SQLException;
    List<Hour> findbyDayId(int taskId) throws SQLException;
    void delete(Hour hour) throws SQLException;
    void add(int hourValue, int taskId, int dayId) throws SQLException;
    void update(Hour hour, int hourValue) throws SQLException;
}
