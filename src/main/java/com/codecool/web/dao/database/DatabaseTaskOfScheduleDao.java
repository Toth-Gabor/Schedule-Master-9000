package com.codecool.web.dao.database;

import com.codecool.web.dao.TaskOfScheduleDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseTaskOfScheduleDao extends AbstractDao implements TaskOfScheduleDao {
    
    public DatabaseTaskOfScheduleDao(Connection connection) {
        super(connection);
    }
    
    @Override
    public void add(int hourId, int taskId) throws SQLException {
        String sql = "INSERT INTO hour_task (hour_id, task_id) VALUES (?, ?);";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, hourId);
            statement.setInt(2, taskId);
            statement.execute();
        }
    }
}
