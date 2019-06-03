package com.codecool.web.dao.database;

import com.codecool.web.dao.TaskDao;
import com.codecool.web.dao.TaskOfScheduleDao;
import com.codecool.web.model.Task;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

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

    @Override
    public void delete(int hourId) throws SQLException {
        String sql = "DELETE FROM hour_task WHERE hour_id = ?;";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, hourId);
            statement.execute();
        }
    }
    @Override
    public boolean checkIfExsists(int scheduleId, int taskId) throws SQLException{
        TaskDao taskDao = new DatabaseTaskDao(connection);
        List<Task> tList = taskDao.findbyScheduleId(scheduleId);
        if (tList.size() == 0){
            return false;
        }else {
            for (int i = 0; i < tList.size(); i++) {
                if (tList.get(i).getId() == taskId){
                    return true;
                }
            }
        }
        return false;

    }

}
