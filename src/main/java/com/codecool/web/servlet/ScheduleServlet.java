package com.codecool.web.servlet;

import com.codecool.web.dao.ScheduleDao;
import com.codecool.web.dao.TaskDao;
import com.codecool.web.dao.database.DatabaseScheduleDao;
import com.codecool.web.dao.database.DatabaseTaskDao;
import com.codecool.web.model.Schedule;
import com.codecool.web.model.User;
import com.codecool.web.service.ScheduleService;
import com.codecool.web.service.exception.ServiceException;
import com.codecool.web.service.simple.SimpleScheduleService;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/protected/schedule")
public class ScheduleServlet extends AbstractServlet{
    
    private static final String SQL_ERROR_CODE_UNIQUE_VIOLATION = "23505";

    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = getConnection(req.getServletContext())){
            ScheduleDao scheduleDao = new DatabaseScheduleDao(connection);
            ScheduleService scheduleService = new SimpleScheduleService(scheduleDao);
            int scheduleId = (Integer) req.getAttribute("schedule-id");
            Schedule schedule = scheduleService.getbyId(scheduleId);
    
            sendMessage(resp, HttpServletResponse.SC_OK, schedule);
        
        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
        super.doGet(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try (Connection connection = getConnection(req.getServletContext())){
            ScheduleDao scheduleDao = new DatabaseScheduleDao(connection);
            ScheduleService scheduleService = new SimpleScheduleService(scheduleDao);
            User user = (User) req.getSession().getAttribute("user");
            boolean isPublished = (Boolean)req.getAttribute("schedule-published");
            int dayValue = Integer.parseInt((String) req.getAttribute("day-value"));
            SimpleScheduleService simpleScheduleService = new SimpleScheduleService(scheduleDao);
            String[] dayNames = null;
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
