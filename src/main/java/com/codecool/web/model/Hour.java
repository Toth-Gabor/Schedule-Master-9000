package com.codecool.web.model;

public class Hour extends AbstractModel {
    
    private int hourValue;
    private int taskId;
    private int dayId;
    
    public Hour(int id, int hourValue, int taskId, int dayId) {
        super(id);
        this.hourValue = hourValue;
        this.taskId = taskId;
        this.dayId = dayId;
    }
    
    public int getHourValue() {
        return hourValue;
    }
    
    public int getTaskId() {
        return taskId;
    }
    
    public int getDayId() {
        return dayId;
    }
}
