package com.codecool.web.service.simple;

import com.codecool.web.dao.TaskOfScheduleDao;
import com.codecool.web.service.TaskOfScheduleService;
import com.codecool.web.service.exception.ServiceException;

import java.sql.SQLException;

public class SimpleTaskOfScheduleService implements TaskOfScheduleService {

    private final TaskOfScheduleDao taskOfScheduleDao;
    
    public SimpleTaskOfScheduleService(TaskOfScheduleDao taskOfScheduleDao) {
        this.taskOfScheduleDao = taskOfScheduleDao;
    }
    
    @Override
    public void addHourIdAndTask(int hourId, int taskId, int scheduleId) throws SQLException, ServiceException {
        if (taskOfScheduleDao.checkIfExsists(scheduleId ,taskId)){
            throw new ServiceException("Task already exist in current schedule");
        } else {
            taskOfScheduleDao.add(hourId, taskId);
        }
    }
    
    @Override
    public void deleteTaskFromScheduleById(int hourId) throws SQLException {
        taskOfScheduleDao.delete(hourId);
    }


}
