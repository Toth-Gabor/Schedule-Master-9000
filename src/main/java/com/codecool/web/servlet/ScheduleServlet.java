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
import com.codecool.web.model.*;
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

@WebServlet("/protected/schedule")
public class ScheduleServlet extends AbstractServlet{
    
    private static final String SQL_ERROR_CODE_UNIQUE_VIOLATION = "23505";

    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())){
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
            List<Task> taskList = taskService.getbyScheduleId(scheduleId);
    
            HourDao hourDao = new DatabaseHourDao(connection);
            HourService hourService = new SimpleHourService(hourDao);
            List<Integer> dayIdList = new ArrayList<>();
            String[][] allTaskNames = new String[dayList.size()][24];


            for (int i = 0; i < dayList.size() ; i++) {
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
        
        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try (Connection connection = getConnection(req.getServletContext())){
            ScheduleDao scheduleDao = new DatabaseScheduleDao(connection);
            ScheduleService scheduleService = new SimpleScheduleService(scheduleDao);
            User user = (User) req.getSession().getAttribute("user");
            boolean isPublished = Boolean.parseBoolean(req.getParameter("schedule-published"));
            int dayValue = Integer.parseInt(req.getParameter("day-value"));
            SimpleScheduleService simpleScheduleService = new SimpleScheduleService(scheduleDao);
            String[] dayNames = simpleScheduleService.dayNames;
            for (int i = 0; i < simpleScheduleService.dayNames.length - (7 - dayValue); i++) {
                dayNames[i] = simpleScheduleService.dayNames[i];
            }
            
            scheduleService.add(isPublished, user.getId(), dayValue, dayNames);
            
        } catch (SQLException e) {
            handleSqlError(resp, e);
        }
    }
    
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())) {
            ScheduleDao scheduleDao = new DatabaseScheduleDao(connection);
            ScheduleService scheduleService = new SimpleScheduleService(scheduleDao);
            int scheduleId = (Integer) req.getAttribute("schedule-id");
            boolean isPublished = (Boolean)req.getAttribute("schedule-published");
            
            Schedule schedule = scheduleService.getbyId(scheduleId);
            scheduleService.update(schedule, isPublished);
            
        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())){
            ScheduleDao scheduleDao = new DatabaseScheduleDao(connection);
            ScheduleService scheduleService = new SimpleScheduleService(scheduleDao);
            int scheduleId = (Integer) req.getAttribute("schedule-id");
            Schedule schedule = scheduleService.getbyId(scheduleId);
            scheduleService.delete(schedule);
            
        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }
}
