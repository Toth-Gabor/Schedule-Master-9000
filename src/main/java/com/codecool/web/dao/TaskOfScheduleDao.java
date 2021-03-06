package com.codecool.web.dao;

import java.sql.SQLException;

public interface TaskOfScheduleDao {
    
    void add(int hourId, int taskId) throws SQLException;
    void delete(int hourId) throws SQLException;
    boolean checkIfExsists(int scheduleId, int taskId) throws SQLException;
}
