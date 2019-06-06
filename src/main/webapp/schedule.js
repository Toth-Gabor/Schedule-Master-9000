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

function onAddScheduleClicked() {
    const dayValueInputEl = document.getElementById("day-number-content");
    const publishedInputEl = document.getElementById("schedule-published");
    const dayValue = dayValueInputEl.options[dayValueInputEl.selectedIndex].value;
    const published = publishedInputEl.options[publishedInputEl.selectedIndex].value;
    const params = new URLSearchParams();
    const user = getAuthorization();
    params.append('id', user.id);
    params.append("day-value", dayValue);
    params.append("schedule-published", published);
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onAddScheduleResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('POST', 'protected/schedule?' + params.toString());
    xhr.send(params);
}

function onScheduleClicked() {
    const ScheduleId = this.dataset.ScheduleId;
    localStorage.setItem("schedule-id", ScheduleId);

    const params = new URLSearchParams();
    params.append('schedule-id', ScheduleId);

    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onScheduleResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/schedule?' + params.toString());
    xhr.send(params);
}

function afterEditSchedule() {
    let scheduleId = localStorage.getItem("schedule-id");
    const params = new URLSearchParams();
    params.append('schedule-id', scheduleId);

    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onScheduleResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/schedule?' + params.toString());
    xhr.send(params);
}

function onPublishedScheduleClicked() {
    const ScheduleId = this.dataset.ScheduleId;
    localStorage.setItem("schedule-id", ScheduleId);

    const params = new URLSearchParams();
    params.append('schedule-id', ScheduleId);

    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onPublishedScheduleResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/schedule?' + params.toString());
    xhr.send();
}

function onPublishedScheduleResponse() {
    if (this.status === OK) {
        onPublishedScheduleLoad(JSON.parse(this.responseText));
        showContents(['topnav', 'published-schedules', 'populate-schedule']);
    } else {
        onOtherResponse(publicSchedulesDivEl, this);
    }
}

function onAddScheduleResponse() {
    alert("Schedule added!");
    if (this.status === OK) {
        onListSchedulesClicked();
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}

function onShowAddScheduleForm() {
    showContents(['topnav', 'add-schedule-content']);
}

function onShowUpdateClicked() {
    showContents(['topnav', 'update-schedule']);
}

function onUpdateButtonClicked() {
    const scheduleId = localStorage.getItem("schedule-id");
    const params = new URLSearchParams();
    const publishedInputEl = document.getElementById("schedule-published-update");
    const published = publishedInputEl.options[publishedInputEl.selectedIndex].value;
    params.append('schedule-id', scheduleId);
    params.append("schedule-published", published);
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onUpdateScheduleResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('PUT', 'protected/schedule?' + params.toString());
    xhr.send();
}

function onUpdateScheduleResponse() {
    alert("Schedule updated!");
    if (this.status === OK) {
        afterEditSchedule();
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}

function onDeleteScheduleClicked() {
    const scheduleId = localStorage.getItem("schedule-id");
    const params = new URLSearchParams();
    params.append('schedule-id', scheduleId);
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onDeleteScheduleResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('DELETE', 'protected/schedule?' + params.toString());
    xhr.send();
}

function onDeleteScheduleResponse() {
    alert("Schedule deleted!");
    if (this.status === OK) {
        onListSchedulesClicked();//showContents(['topnav', 'link-content']);
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}

function onShareClicked() {
    const scheduleId = localStorage.getItem("schedule-id");
    const text = document.createElement("textarea");
    let link = "http://localhost:8080/schedule-master-9000/share?scheduleId=" + scheduleId;
    text.value = link;
    text.select();
    document.execCommand("copy");
    alert("Copy this link: " + text.value);
}
