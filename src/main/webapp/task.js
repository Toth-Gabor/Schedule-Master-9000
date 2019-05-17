function onTaskResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['link-content', 'schedules-content', 'back-to-profile-content']);
        onTaskLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(tasksContentDivEl, this);
    }
}

function onTaskLoad(TasksDto) {
    let scheduleIdSpanEl = document.getElementById('schedule-id');
    let schedulePublishedSpanEl = document.getElementById('schedule-published-show');

    console.log(scheduleDto.allTaskNames);

    var table = document.getElementById("schedule-table");
    if(table == null){
        document.getElementById('schedules-content').appendChild(populateTable(null, scheduleDto.dayList.length, 24, scheduleDto.dayList.length, scheduleDto.allTaskNames));
    }else{
        table.remove();
        document.getElementById('schedules-content').appendChild(populateTable(null, scheduleDto.dayList.length, 24, scheduleDto.dayList.length, scheduleDto.allTaskNames));
    }

    scheduleIdSpanEl.innerHTML = scheduleDto.schedule.id;
    if(scheduleDto.schedule.published){
        schedulePublishedSpanEl.innerHTML = "published";
    } else {
        schedulePublishedSpanEl.innerHTML = "not published";
    }
}
