package com.codecool.web.service.simple;

import com.codecool.web.dao.TaskOfScheduleDao;
import com.codecool.web.service.TaskOfScheduleService;

import java.sql.SQLException;

public class SimpleTaskOfScheduleService implements TaskOfScheduleService {

    private final TaskOfScheduleDao taskOfScheduleDao;
    
    public SimpleTaskOfScheduleService(TaskOfScheduleDao taskOfScheduleDao) {
        this.taskOfScheduleDao = taskOfScheduleDao;
    }
    
    @Override
    public void addHourIdAndTask(int hourId, int taskId) throws SQLException {
        taskOfScheduleDao.add(hourId, taskId);
    }
    
    @Override
    public void deleteTaskFromScheduleById(int hourId) throws SQLException {
        taskOfScheduleDao.delete(hourId);
    }
}
