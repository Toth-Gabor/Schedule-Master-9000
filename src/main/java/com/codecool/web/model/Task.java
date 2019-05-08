package com.codecool.web.model;

public class Task extends AbstractModel {
    private String name;
    private String content;
    private int userId;

    public Task(int id, String name, String content, int userId) {
        super(id);
        this.name = name;
        this.content = content;
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public String getContent() {
        return content;
    }

    public int getUserId() {
        return userId;
    }
}
