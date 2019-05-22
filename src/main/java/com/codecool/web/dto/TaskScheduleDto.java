package com.codecool.web.dto;

import com.codecool.web.model.Task;

import java.util.List;

public class TaskScheduleDto {
    private Object[][] taskNameAndHourIdList;
    private List<Task> allTasks;

    public TaskScheduleDto(Object[][] taskNameAndHourIdList, List<Task> allTasks) {
        this.taskNameAndHourIdList = taskNameAndHourIdList;
        this.allTasks = allTasks;
    }

    public Object[][] getTaskNameAndHourIdList() {
        return taskNameAndHourIdList;
    }

    public List<Task> getAllTasks() {
        return allTasks;
    }
}
