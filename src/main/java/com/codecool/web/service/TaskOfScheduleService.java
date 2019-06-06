package com.codecool.web.service;

import com.codecool.web.model.Day;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;
import java.util.List;

public interface TaskOfScheduleService {
    
    void addHourIdAndTask(int hourId, int taskId, int scheduleId) throws SQLException, ServiceException;
    void deleteTaskFromScheduleById(int hourId) throws SQLException;

    Object[][] getTaskNameAndHourIdList(List<Day> dayList, TaskService taskService) throws SQLException, ServiceException;


}
