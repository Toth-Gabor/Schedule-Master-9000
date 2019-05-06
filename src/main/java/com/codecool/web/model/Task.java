package com.codecool.web.model;

public class Task extends AbstractModel {
    private String name;
    private String content;
    private int scheduleId;

    public Task(int id, String name, String content, int scheduleId) {
        super(id);
        this.name = name;
        this.content = content;
        this.scheduleId = scheduleId;
    }

    public String getName() {
        return name;
    }

    public String getContent() {
        return content;
    }

    public int getScheduleId() {
        return scheduleId;
    }
}
