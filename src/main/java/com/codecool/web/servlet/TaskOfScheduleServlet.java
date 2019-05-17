package com.codecool.web.servlet;

import com.codecool.web.dao.DayDao;
import com.codecool.web.dao.ScheduleDao;
import com.codecool.web.dao.TaskDao;
import com.codecool.web.dao.database.DatabaseDayDao;
import com.codecool.web.dao.database.DatabaseScheduleDao;
import com.codecool.web.dao.database.DatabaseTaskDao;
import com.codecool.web.model.Day;
import com.codecool.web.model.Schedule;
import com.codecool.web.service.DayService;
import com.codecool.web.service.ScheduleService;
import com.codecool.web.service.TaskService;
import com.codecool.web.service.exception.ServiceException;
import com.codecool.web.service.simple.SimpleDayService;
import com.codecool.web.service.simple.SimpleScheduleService;
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

            String[][] allDayHourList = new String[dayList.size()][24];


            for (int i = 0; i < dayList.size() ; i++) {
                String[] tasknames = taskDao.findhourContentList(dayList.get(i).getId());
                allDayHourList[i] = tasknames;

            }

            sendMessage(resp, HttpServletResponse.SC_OK, allDayHourList);

        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPut(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doDelete(req, resp);
    }
}
