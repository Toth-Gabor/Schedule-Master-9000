package com.codecool.web.model;

public class Slot extends AbstractModel {
    
    private int slotValue;
    private int taskId;
    private int dayId;
    
    public Slot(int id, int slotValue, int taskId, int dayId) {
        super(id);
        this.slotValue = slotValue;
        this.taskId = taskId;
        this.dayId = dayId;
    }
    
    public int getSlotValue() {
        return slotValue;
    }
    
    public int getTaskId() {
        return taskId;
    }
    
    public int getDayId() {
        return dayId;
    }
}
