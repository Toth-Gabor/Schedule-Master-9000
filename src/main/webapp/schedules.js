let SchedulesDivEl;
let SchedulesUlEl;
let publicSchedulesDivEl;
let publicScheduleUlEl;

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

function onPublishedScheduleClicked() {
    const ScheduleId = this.dataset.ScheduleId;
    localStorage.setItem("schedule-id", ScheduleId);

    const params = new URLSearchParams();
    params.append('schedule-id', ScheduleId);

    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onPublishedScheduleResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/schedule?' + params.toString());
    xhr.send(params);
}

function appendSchedule(Schedule) {
    const schLiEl = document.createElement('li');
    const aEl = document.createElement('a');
    schLiEl.appendChild(aEl);
    aEl.textContent = Schedule.id;
    aEl.href = 'javascript:void(0);';
    aEl.dataset.ScheduleId = Schedule.id;
    aEl.addEventListener('click', onScheduleClicked);
    SchedulesUlEl.appendChild(schLiEl);
}

function appendPublishedSchedule(Schedule) {
    const schLiEl = document.createElement('li');
    const aEl = document.createElement('a');
    schLiEl.appendChild(aEl);
    aEl.textContent = Schedule.id;
    aEl.href = 'javascript:void(0);';
    aEl.dataset.ScheduleId = Schedule.id;
    aEl.addEventListener('click', onPublishedScheduleClicked);
    publicScheduleUlEl.appendChild(schLiEl);
}

function appendSchedules(Schedules) {
    removeAllChildren(SchedulesUlEl);

    for (let i = 0; i < Schedules.length; i++) {
        const Schedule = Schedules[i];
        appendSchedule(Schedule);
    }
}

function appendPublicSchedules(publicSchedules) {
    removeAllChildren(publicScheduleUlEl);

    for (let i = 0; i < publicSchedules.length; i++) {
        const Schedule = publicSchedules[i];
        appendPublishedSchedule(Schedule);
    }
}

function onSchedulesLoad(schedulesListsDto) {
    SchedulesDivEl = document.getElementById('schedules');
    SchedulesUlEl = SchedulesDivEl.querySelector('ul');

    publicSchedulesDivEl = document.getElementById('published-schedules');
    publicScheduleUlEl = publicSchedulesDivEl.querySelector('ul');

    appendSchedules(schedulesListsDto.ownSchedules);
    appendPublicSchedules(schedulesListsDto.publishedSchedules);
}

function onSchedulesResponse() {
    if (this.status === OK) {
        showContents(['schedules-content', 'topnav', 'published-schedules']);
        onSchedulesLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}

function onPublishedScheduleResponse() {
    if (this.status === OK) {
        showContents(['topnav', 'published-schedules', 'populate-schedule']);
        onPublishedScheduleLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(publicSchedulesDivEl, this);
    }
}

function onAddScheduleResponse() {
    alert("Schedule added!");
    if (this.status === OK) {
        showContents(['topnav', 'profile-content']);
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
        onScheduleLoad(JSON.parse(this.responseText));
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
        showContents(['topnav', 'profile-content']);
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


