package com.codecool.web.dto;

import com.codecool.web.model.Schedule;

import java.util.ArrayList;
import java.util.List;

public class OwnAndPublishedSheduleListsDto {
    
    private List<Schedule> ownSchedules;
    private List<Schedule> publishedSchedules;
    
    public OwnAndPublishedSheduleListsDto() {
        this.ownSchedules = new ArrayList<>();
        this.publishedSchedules = new ArrayList<>();
    }
    
    public List<Schedule> getOwnSchedules() {
        return ownSchedules;
    }
    
    public List<Schedule> getPublishedSchedules() {
        return publishedSchedules;
    }
}
