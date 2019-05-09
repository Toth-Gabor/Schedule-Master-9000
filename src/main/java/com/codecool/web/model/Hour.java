package com.codecool.web.model;

public class Hour extends AbstractModel {
    
    private int hourValue;
    private int dayId;
    
    public Hour(int id, int hourValue, int dayId) {
        super(id);
        this.hourValue = hourValue;
        this.dayId = dayId;
    }
    
    public int getHourValue() {
        return hourValue;
    }
    
    public int getDayId() {
        return dayId;
    }
}
