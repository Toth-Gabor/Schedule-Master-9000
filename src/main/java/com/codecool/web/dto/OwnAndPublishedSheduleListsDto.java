package com.codecool.web.dto;

import com.codecool.web.model.Schedule;


import java.util.List;

public class OwnAndPublishedSheduleListsDto {
    
    private List<Schedule> ownSchedules;
    private List<Schedule> publishedSchedules;
    
    public OwnAndPublishedSheduleListsDto(List<Schedule> ownSchedules, List<Schedule> publishedSchedules) {
        this.ownSchedules = ownSchedules;
        this.publishedSchedules = publishedSchedules;
    }
    
    public List<Schedule> getOwnSchedules() {
        return ownSchedules;
    }
    
    public List<Schedule> getPublishedSchedules() {
        return publishedSchedules;
    }
}
