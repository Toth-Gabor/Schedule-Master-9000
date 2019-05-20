function onTaskResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['link-content', 'tasks-content', 'task-fields','back-to-profile-content']);
        onTaskLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(tasksContentDivEl, this);
    }
}

function onTaskLoad(task) {
    let taskNameSpanEl = document.getElementById('task-name');
    let taskContentSpanEl = document.getElementById('task-content');

    taskNameSpanEl.innerHTML = task.name;
    taskContentSpanEl.innerHTML = task.content;

}
function onAddTaskClicked() {
    const ScheduleId = localStorage.getItem("schedule-id");

    const params = new URLSearchParams();
    params.append('schedule-id', ScheduleId);

    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onAddTaskResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/taskofschedule?' + params.toString());
    xhr.send(params);



    //kell egy új dao a hour_task insertre
    //csak hourid-t kell inputba megdani
    //folytatás: populate tábla, gomb
    //debug

}

function onAddTaskResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['link-content', 'show-tname-hid-table', 'task-fields','back-to-profile-content']);
        onAddTaskLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(tasksContentDivEl, this);
    }

}

function onAddTaskLoad(taskNameAndHourIdList) {
    const length = taskNameAndHourIdList.length;
    const tasksHoursDivEl = document.getElementById("show-tname-hid-table");
    let table = document.getElementById("taskhour-table");
    if (table == null){
        tasksHoursDivEl.appendChild(showTHTable(null,length,24,length,taskNameAndHourIdList));
    } else {
        table.remove();
        tasksHoursDivEl.appendChild(showTHTable(null,length,24,length,taskNameAndHourIdList));
    }
}

function showTHTable(table, days, rows, cells, content) {
    if (!table) table = document.createElement('table');

    table.setAttribute('id', "taskhour-table");
    table.setAttribute('border', "1px");
    let head = document.createElement('thead');
    table.appendChild(head);

    for (let x = 1; x <= days; x++) {
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
