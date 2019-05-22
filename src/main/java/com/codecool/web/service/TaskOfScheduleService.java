package com.codecool.web.service;

import java.sql.SQLException;

public interface TaskOfScheduleService {
    
    void addHourIdAndTask(int hourId, int taskId) throws SQLException;
    void deleteTaskFromScheduleById(int taskId) throws SQLException;
}
