function onScheduleLoad(scheduleDto) {
    let scheduleIdSpanEl = document.getElementById('schedule-id');
    let schedulePublishedSpanEl = document.getElementById('schedule-published-show');

    document.getElementById('schedules-content').appendChild(populateTable(null, 7, 24, 7, "content"));

    console.log(scheduleDto.schedule);

    scheduleIdSpanEl.innerHTML = scheduleDto.schedule.id;
    if(scheduleDto.schedule.published){
        schedulePublishedSpanEl.innerHTML = "published";
    } else {
        schedulePublishedSpanEl.innerHTML = "not published";
    }
}

function onScheduleResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['schedule-content', 'schedules-content', 'back-to-profile-content']);


        onScheduleLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}

function populateTable(table, time, rows, cells, content) {
    if (!table) table = document.createElement('table');
    let head = document.createElement('thead');
    table.appendChild(head);

    for (let x = 1; x <= time; x++) {
        let title = document.createElement('th');
        title.appendChild(document.createTextNode(x + '. Day'));
        head.appendChild(title);
    }
    let body = document.createElement('tbody');
    for (let i = 0; i < rows; ++i) {
        let row = document.createElement('tr');
        for (let j = 0; j < cells; ++j) {
            row.appendChild(document.createElement('td'));
            row.cells[j].appendChild(document.createTextNode(content + (j + 1)));
        }
        table.appendChild(row);
    }
    return table;
}

/*$(document).ready(function () {
    document.getElementById('schedules-content')
        .appendChild(populateTable(null, 7, 24, 7, "content"));
});*/

