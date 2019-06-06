package com.codecool.web.servlet;

import com.codecool.web.dao.DayDao;
import com.codecool.web.dao.ScheduleDao;
import com.codecool.web.dao.TaskDao;
import com.codecool.web.dao.TaskOfScheduleDao;
import com.codecool.web.dao.database.DatabaseDayDao;
import com.codecool.web.dao.database.DatabaseScheduleDao;
import com.codecool.web.dao.database.DatabaseTaskDao;
import com.codecool.web.dao.database.DatabaseTaskOfScheduleDao;
import com.codecool.web.dto.TaskScheduleDto;
import com.codecool.web.model.Day;
import com.codecool.web.model.Schedule;
import com.codecool.web.model.Task;
import com.codecool.web.model.User;
import com.codecool.web.service.DayService;
import com.codecool.web.service.ScheduleService;
import com.codecool.web.service.TaskOfScheduleService;
import com.codecool.web.service.TaskService;
import com.codecool.web.service.exception.ServiceException;
import com.codecool.web.service.simple.SimpleDayService;
import com.codecool.web.service.simple.SimpleScheduleService;
import com.codecool.web.service.simple.SimpleTaskOfScheduleService;
import com.codecool.web.service.simple.SimpleTaskService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/protected/taskofschedule")
public class TaskOfScheduleServlet extends AbstractServlet {
    private static final String SQL_ERROR_CODE_UNIQUE_VIOLATION = "23505";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())) {
            User user = (User) req.getSession().getAttribute("user");

            ScheduleDao scheduleDao = new DatabaseScheduleDao(connection);
            ScheduleService scheduleService = new SimpleScheduleService(scheduleDao);
            String schId = req.getParameter("schedule-id");
            int scheduleId = Integer.parseInt(schId);
            Schedule schedule = scheduleService.getbyId(scheduleId);

            DayDao dayDao = new DatabaseDayDao(connection);
            DayService dayService = new SimpleDayService(dayDao);
            List<Day> dayList = dayService.getByScheduleId(scheduleId);

            TaskDao taskDao = new DatabaseTaskDao(connection);
            TaskService taskService = new SimpleTaskService(taskDao);

            TaskOfScheduleDao taskOfScheduleDao = new DatabaseTaskOfScheduleDao(connection);
            TaskOfScheduleService taskOfScheduleService = new SimpleTaskOfScheduleService(taskOfScheduleDao);

            List<Task> allTasks = taskService.getbyUserId(user.getId());

            Object[][] taskNameAndHourIdList = taskOfScheduleService.getTaskNameAndHourIdList(dayList, taskService);

            sendMessage(resp, HttpServletResponse.SC_OK, new TaskScheduleDto(taskNameAndHourIdList, allTasks));

        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())){
            int hourId = Integer.parseInt(req.getParameter("hourId"));
            int taskId = Integer.parseInt(req.getParameter("taskId"));
            int scheduleId = Integer.parseInt(req.getParameter("schedule-id"));

            TaskOfScheduleDao taskOfScheduleDao = new DatabaseTaskOfScheduleDao(connection);
            TaskOfScheduleService taskOfScheduleService = new SimpleTaskOfScheduleService(taskOfScheduleDao);
            taskOfScheduleService.addHourIdAndTask(hourId, taskId, scheduleId);
            
            sendMessage(resp, HttpServletResponse.SC_OK, null);
        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            sendMessage(resp, HttpServletResponse.SC_BAD_REQUEST, null);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())){
            int hourId = Integer.parseInt(req.getParameter("hourId"));
            TaskOfScheduleDao taskOfScheduleDao = new DatabaseTaskOfScheduleDao(connection);
            TaskOfScheduleService taskOfScheduleService = new SimpleTaskOfScheduleService(taskOfScheduleDao);
            taskOfScheduleService.deleteTaskFromScheduleById(hourId);
        
            sendMessage(resp, HttpServletResponse.SC_OK, null);
        } catch (SQLException e) {
            handleSqlError(resp, e);
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())) {
            User user = (User) req.getSession().getAttribute("user");

            ScheduleDao scheduleDao = new DatabaseScheduleDao(connection);
            ScheduleService scheduleService = new SimpleScheduleService(scheduleDao);
            String schId = req.getParameter("schedule-id");
            int scheduleId = Integer.parseInt(schId);
            Schedule schedule = scheduleService.getbyId(scheduleId);

            DayDao dayDao = new DatabaseDayDao(connection);
            DayService dayService = new SimpleDayService(dayDao);
            List<Day> dayList = dayService.getByScheduleId(scheduleId);

            TaskDao taskDao = new DatabaseTaskDao(connection);
            TaskService taskService = new SimpleTaskService(taskDao);

            TaskOfScheduleDao taskOfScheduleDao = new DatabaseTaskOfScheduleDao(connection);
            TaskOfScheduleService taskOfScheduleService = new SimpleTaskOfScheduleService(taskOfScheduleDao);
            
            Object[][] hourIdListforDelete = taskOfScheduleService.getHourIdListforDelete(dayList, taskService);

            sendMessage(resp, HttpServletResponse.SC_OK, hourIdListforDelete);

        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }
}
