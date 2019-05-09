package com.codecool.web.dto;

import com.codecool.web.model.Schedule;

public class ScheduleDto {

    private final Schedule schedule;

    public ScheduleDto(Schedule schedule) {
        this.schedule = schedule;
    }

    public Schedule getSchedule() {
        return schedule;
    }
}
