package com.codecool.web.dao.database;

import com.codecool.web.dao.HourTaskDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DatabaseHourTaskDao extends AbstractDao implements HourTaskDao {

    DatabaseHourTaskDao(Connection connection) {
        super(connection);
    }

    @Override
    public void delete(int taskId) throws SQLException {
        String sql = "DELETE FROM hour_task WHERE task_id = ?;";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, taskId);
            statement.execute();
        }
    }
}
