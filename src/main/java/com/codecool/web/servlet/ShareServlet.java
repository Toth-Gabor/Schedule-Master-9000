package com.codecool.web.servlet;

import com.codecool.web.dao.DayDao;
import com.codecool.web.dao.HourDao;
import com.codecool.web.dao.ScheduleDao;
import com.codecool.web.dao.TaskDao;
import com.codecool.web.dao.database.DatabaseDayDao;
import com.codecool.web.dao.database.DatabaseHourDao;
import com.codecool.web.dao.database.DatabaseScheduleDao;
import com.codecool.web.dao.database.DatabaseTaskDao;
import com.codecool.web.dto.ScheduleDto;
import com.codecool.web.model.Day;
import com.codecool.web.model.Hour;
import com.codecool.web.model.Schedule;
import com.codecool.web.model.Task;
import com.codecool.web.service.DayService;
import com.codecool.web.service.HourService;
import com.codecool.web.service.ScheduleService;
import com.codecool.web.service.TaskService;
import com.codecool.web.service.exception.ServiceException;
import com.codecool.web.service.simple.SimpleDayService;
import com.codecool.web.service.simple.SimpleHourService;
import com.codecool.web.service.simple.SimpleScheduleService;
import com.codecool.web.service.simple.SimpleTaskService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/share")
public class ShareServlet extends AbstractServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())) {
            ScheduleDao scheduleDao = new DatabaseScheduleDao(connection);
            ScheduleService scheduleService = new SimpleScheduleService(scheduleDao);
            String schId = req.getParameter("scheduleId");
            int scheduleId = Integer.parseInt(schId);

            req.setAttribute("scheduleId", scheduleId);
            req.getRequestDispatcher("share.jsp").forward(req, resp);

        } catch (SQLException e) {
            handleSqlError(resp, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())) {
            ScheduleDao scheduleDao = new DatabaseScheduleDao(connection);
            ScheduleService scheduleService = new SimpleScheduleService(scheduleDao);
            String schId = req.getParameter("scheduleId");
            int scheduleId = Integer.parseInt(schId);
            Schedule schedule = scheduleService.getbyId(scheduleId);
            if (schedule.isPublished()) {
                DayDao dayDao = new DatabaseDayDao(connection);
                DayService dayService = new SimpleDayService(dayDao);
                List<Day> dayList = dayService.getByScheduleId(scheduleId);

                TaskDao taskDao = new DatabaseTaskDao(connection);
                TaskService taskService = new SimpleTaskService(taskDao);
                List<Task> taskList = taskService.getbyScheduleId(scheduleId);

                HourDao hourDao = new DatabaseHourDao(connection);
                HourService hourService = new SimpleHourService(hourDao);
                List<Integer> dayIdList = new ArrayList<>();
                String[][] allTaskNames = new String[dayList.size()][24];


                //service
                for (int i = 0; i < dayList.size(); i++) {
                    dayIdList.add(dayList.get(i).getId());
                    String[] tasknames = taskDao.findhourContentList(dayList.get(i).getId());
                    allTaskNames[i] = tasknames;

                }

                List<Hour> hourList = new ArrayList<>();
                for (int i = 0; i < dayIdList.size(); i++) {
                    List<Hour> hourListForDayId = hourService.getbyDayId(dayIdList.get(i));
                    for (Hour hour : hourListForDayId) {
                        hourList.add(hour);
                    }
                }
                sendMessage(resp, HttpServletResponse.SC_OK, new ScheduleDto(schedule, dayList, taskList, hourList, allTaskNames));

            } else {
                sendMessage(resp, HttpServletResponse.SC_BAD_GATEWAY, null);
            }
        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }
}
