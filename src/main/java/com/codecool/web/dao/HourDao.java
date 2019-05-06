package com.codecool.web.dao;

import com.codecool.web.model.Hour;

import java.sql.SQLException;
import java.util.List;

public interface HourDao {

    List<Hour> findbyHourValue(int hourValue) throws SQLException;
    List<Hour> findbyTaskId(int taskId) throws SQLException;
    List<Hour> findbyDayId(int taskId) throws SQLException;
}
