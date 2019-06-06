package com.codecool.web.servlet;

import com.codecool.web.dao.TaskDao;
import com.codecool.web.dao.database.DatabaseTaskDao;
import com.codecool.web.model.Task;
import com.codecool.web.model.User;
import com.codecool.web.service.TaskService;
import com.codecool.web.service.exception.ServiceException;
import com.codecool.web.service.simple.SimpleTaskService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/protected/task")
public class TaskServlet extends AbstractServlet {

    private static final String SQL_ERROR_CODE_UNIQUE_VIOLATION = "23505";
    private static final Logger logger = LoggerFactory.getLogger(TaskServlet.class);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())){
            TaskDao taskDao = new DatabaseTaskDao(connection);
            TaskService taskService = new SimpleTaskService(taskDao);
            String tId = req.getParameter("task-id");
            int taskId = Integer.parseInt(tId);
            Task task = taskService.getbyId(taskId);

            sendMessage(resp, HttpServletResponse.SC_OK, task);

        } catch (SQLException e) {
            handleSqlError(resp, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try (Connection connection = getConnection(req.getServletContext())){
            TaskDao taskDao = new DatabaseTaskDao(connection);
            TaskService taskService = new SimpleTaskService(taskDao);
            String taskName = req.getParameter("taskTitle");
            String taskContent = req.getParameter("taskContent");
            //nemkell a user object, csak az id
            User user = (User) req.getSession().getAttribute("user");
            taskService.add(taskName, taskContent, user.getId());
            logger.info("task added");

        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())) {
            TaskDao taskDao = new DatabaseTaskDao(connection);
            TaskService taskService = new SimpleTaskService(taskDao);
            String taskName = req.getParameter("taskTitle");
            String taskContent = req.getParameter("taskContent");
            int taskId = Integer.parseInt( req.getParameter("taskId"));

            Task task = taskService.getbyId(taskId);
            taskService.update(task, taskName, taskContent);
            logger.info("task updated");

        } catch (SQLException e) {
            handleSqlError(resp, e);
            logger.error("sql exception on updating a task", e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())){
            TaskDao taskDao = new DatabaseTaskDao(connection);
            TaskService taskService = new SimpleTaskService(taskDao);
            int taskId = Integer.parseInt(req.getParameter("taskId"));
            Task task = taskService.getbyId(taskId);
            taskService.delete(task);

            sendMessage(resp, HttpServletResponse.SC_OK, null);
            logger.info("task deleted");

        } catch (SQLException e) {
            handleSqlError(resp, e);
            logger.error("sql exception on deleting task", e);
        } catch (ServiceException e) {
            e.printStackTrace();
            logger.error("exception on deleting task", e);
        }
    }
}
