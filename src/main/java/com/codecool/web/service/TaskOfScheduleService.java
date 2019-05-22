package com.codecool.web.service;

import java.sql.SQLException;

public interface TaskOfScheduleService {
    
    void addHourIdAndTask(int hourId, int taskId) throws SQLException;
    void deleteTaskFromDBById(int taskId) throws SQLException;
}
