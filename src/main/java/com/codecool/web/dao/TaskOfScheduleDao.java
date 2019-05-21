package com.codecool.web.dao;

import java.sql.SQLException;

public interface TaskOfScheduleDao {
    
    void add(int hourId, int taskId) throws SQLException;
}
