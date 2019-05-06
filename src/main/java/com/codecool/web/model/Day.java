package com.codecool.web.model;

public class Day extends AbstractModel{
    
    private String name;
    private int scheduleId;
    
    public Day(int id, String name, int scheduleId) {
        super(id);
        this.name = name;
        this.scheduleId = scheduleId;
    }
    
    public String getName() {
        return name;
    }
    
    public int getScheduleId() {
        return scheduleId;
    }
}
