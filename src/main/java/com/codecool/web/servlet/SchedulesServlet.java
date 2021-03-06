package com.codecool.web.servlet;

import com.codecool.web.dao.ScheduleDao;
import com.codecool.web.dao.database.DatabaseScheduleDao;
import com.codecool.web.dto.OwnAndPublishedSheduleListsDto;
import com.codecool.web.model.Schedule;
import com.codecool.web.model.User;
import com.codecool.web.service.ScheduleService;
import com.codecool.web.service.exception.ServiceException;
import com.codecool.web.service.simple.SimpleScheduleService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/protected/schedules")
public class SchedulesServlet extends AbstractServlet {
    private static final String SQL_ERROR_CODE_UNIQUE_VIOLATION = "23505";
    
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try (Connection connection = getConnection(req.getServletContext())){
            ScheduleDao scheduleDao = new DatabaseScheduleDao(connection);
            ScheduleService scheduleService = new SimpleScheduleService(scheduleDao);
            User user = (User) req.getSession().getAttribute("user");
            List<Schedule> schedules = scheduleService.getbyUserId(user.getId());
            List<Schedule> publishedSchedules = scheduleService.getbyIsPublishedButNowOwn(user.getId());

            sendMessage(resp, HttpServletResponse.SC_OK, new OwnAndPublishedSheduleListsDto(schedules, publishedSchedules));
            
        } catch (SQLException e) {
            handleSqlError(resp, e);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
    }
}
