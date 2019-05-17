package com.codecool.web.dto;

import com.codecool.web.model.Task;

import java.util.List;

public class TaskDto {
    
    private final List<Task> taskList;
    
    public TaskDto(List<Task> taskList) {
        this.taskList = taskList;
    }
    
    public List<Task> getTaskList() {
        return taskList;
    }
}
