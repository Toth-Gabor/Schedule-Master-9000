package com.codecool.web.service;

import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;

public interface TaskOfScheduleService {
    
    void addHourIdAndTask(int hourId, int taskId, int scheduleId) throws SQLException, ServiceException;
    void deleteTaskFromScheduleById(int hourId) throws SQLException;


}
