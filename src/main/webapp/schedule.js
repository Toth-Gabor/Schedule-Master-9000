function onScheduleLoad(scheduleDto) {
    let scheduleIdSpanEl = document.getElementById('schedule-id');
    let schedulePublishedSpanEl = document.getElementById('schedule-published-show');
    let table = document.getElementById("schedule-table");
    if(table == null){
        document.getElementById('populate-schedule').appendChild(populateTable(null, scheduleDto.dayList.length, 24, scheduleDto.dayList.length, scheduleDto.allTaskNames));
    }else{
        table.remove();
        document.getElementById('populate-schedule').appendChild(populateTable(null, scheduleDto.dayList.length, 24, scheduleDto.dayList.length, scheduleDto.allTaskNames));
    }
    scheduleIdSpanEl.innerHTML = scheduleDto.schedule.id;
    if(scheduleDto.schedule.published){
        schedulePublishedSpanEl.innerHTML = "published";
    } else if(!scheduleDto.schedule.published){
        schedulePublishedSpanEl.innerHTML = "not published";
    }
}

function onPublishedScheduleLoad(scheduleDto) {
    let table = document.getElementById("schedule-table");
    if(table == null){
        document.getElementById('populate-schedule').appendChild(populateTable(null, scheduleDto.dayList.length, 24, scheduleDto.dayList.length, scheduleDto.allTaskNames));
    }else{
        table.remove();
        document.getElementById('populate-schedule').appendChild(populateTable(null, scheduleDto.dayList.length, 24, scheduleDto.dayList.length, scheduleDto.allTaskNames));
    }

}

function onScheduleResponse() {
    if (this.status === OK) {
        clearMessages();
        let scheduleDto = JSON.parse(this.responseText);
        if (scheduleDto.schedule.published){
            showContents(['topnav', 'schedules-content','schedules-fields', 'populate-schedule', 'share']);
        } else {
            showContents(['topnav', 'schedules-content','schedules-fields', 'populate-schedule']);
        }
        onScheduleLoad(scheduleDto);
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}

function populateTable(table, time, rows, cells, content) {
    if (!table) table = document.createElement('table');

    table.setAttribute('id', "schedule-table");
    table.setAttribute('border', "1px");
    let head = document.createElement('thead');
    let timeThEl = document.createElement('th');
    timeThEl.appendChild(document.createTextNode('Time'));
    head.appendChild(timeThEl);

    table.appendChild(head);
    for (let x = 1; x <= time; x++) {
        let title = document.createElement('th');
        title.appendChild(document.createTextNode(x + '. Day'));
        head.appendChild(title);
    }
    let body = document.createElement('tbody');
    for (let i = 0; i < rows; ++i) {
        let row = document.createElement('tr');
        let timeCellEl = document.createElement('td');
        timeCellEl.appendChild(document.createTextNode(i + ':00'));
        row.appendChild(timeCellEl);
        for (let j = 0; j < cells; ++j) {
            let tdContentEL = document.createElement('td')
            tdContentEL.appendChild(document.createTextNode(content[j][i]));
            row.appendChild(tdContentEL);
        }
        table.appendChild(row);
    }
    return table;
}

function removeAllChildren(el) {
    while (el.firstChild) {
        el.removeChild(el.firstChild);
    }
}

