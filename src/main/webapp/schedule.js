function onScheduleLoad(scheduleDto) {
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

function onScheduleResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['link-content', 'schedules-content', 'back-to-profile-content']);
        onScheduleLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}

function populateTable(table, time, rows, cells, content) {
    if (!table) table = document.createElement('table');
    table.setAttribute('id', "schedule-table");
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

            row.cells[j].appendChild(document.createTextNode(content[j][i]));
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

/*$(document).ready(function () {
    document.getElementById('schedules-content')
        .appendChild(populateTable(null, 7, 24, 7, "content"));
});*/

/*{schedule: {…}, dayList: Array(2), taskList: Array(0), hourList: Array(3)}
dayList: (2) [{…}, {…}]
hourList: (3) [{…}, {…}, {…}]
schedule: {id: 1, userId: 1, published: true}
taskList: []
__proto__: Object*/

