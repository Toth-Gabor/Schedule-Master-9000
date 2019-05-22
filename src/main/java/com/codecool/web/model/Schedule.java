package com.codecool.web.model;

public class Schedule extends AbstractModel {
    private boolean isPublished;
    private int userId;

    public Schedule(int id, boolean isPublished, int userId) {
        super(id);
        this.isPublished = isPublished;
        this.userId = userId;
    }

    public boolean isPublished() {
        return isPublished;
    }

    public int getUserId() {
        return userId;
    }
    
}
