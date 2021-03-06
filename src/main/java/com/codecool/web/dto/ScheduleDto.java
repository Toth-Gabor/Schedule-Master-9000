package com.codecool.web.dto;

import com.codecool.web.model.Day;
import com.codecool.web.model.Hour;
import com.codecool.web.model.Schedule;
import com.codecool.web.model.Task;

import java.util.List;

public class ScheduleDto {

    private final Schedule schedule;
    private final List<Day> dayList;
    private final List<Task> taskList;
    private final List<Hour> hourList;
    private final String[][] allTaskNames;

    public ScheduleDto(Schedule schedule, List<Day> dayList, List<Task> taskList, List<Hour> hourList, String[][] allTaskNames) {
        this.schedule = schedule;
        this.dayList = dayList;
        this.taskList = taskList;
        this.hourList = hourList;
        this.allTaskNames = allTaskNames;
    }

    public Schedule getSchedule() {
        return schedule;
    }

    public List<Day> getDayList() {
        return dayList;
    }

    public List<Task> getTaskList() {
        return taskList;
    }

    public List<Hour> getHourList() {
        return hourList;
    }

    public String[][] getAllTaskNames() {
        return allTaskNames;
    }
}
