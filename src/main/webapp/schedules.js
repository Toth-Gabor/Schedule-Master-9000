let SchedulesTableEl;
let SchedulesTableBodyEl;

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

function appendSchedule(Schedule) {
    const aEl = document.createElement('a');
    aEl.textContent = Schedule.id;
    aEl.href = 'javascript:void(0);';
    aEl.dataset.ScheduleId = Schedule.id;
    aEl.addEventListener('click', onScheduleClicked);

    const trEl = document.createElement('tr');
    trEl.appendChild(aEl);
    SchedulesTableBodyEl.appendChild(trEl);
}

function appendSchedules(Schedules) {
    removeAllChildren(SchedulesTableBodyEl);

    for (let i = 0; i < Schedules.length; i++) {
        const Schedule = Schedules[i];
        appendSchedule(Schedule);
    }
}

function onSchedulesLoad(Schedules) {
    SchedulesTableEl = document.getElementById('schedules');
    SchedulesTableBodyEl = SchedulesTableEl.querySelector('tbody');

    appendSchedules(Schedules);
}

function onSchedulesResponse() {
    if (this.status === OK) {
        showContents(['back-to-profile-content', 'schedules-content', 'link-content']);
        onSchedulesLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}
function onAddScheduleResponse() {
    alert("Schedule added!");
    if (this.status === OK) {
        showContents(['link-content', 'profile-content', 'logout-content']);
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}
function onShowAddScheduleForm() {
    showContents(['link-content', 'back-to-profile-content', 'add-schedule-content']);

}
function onShowUpdateClicked() {
    showContents(['link-content', 'back-to-profile-content', 'update-schedule']);
}

function onUpdateButtonClicked() {
    const scheduleId = localStorage.getItem("schedule-id");
    console.log(scheduleId);
    const params = new URLSearchParams();
    const inputField = document.forms['edit-schedule-content'];
    const schedulePublishedInputEL = inputField.querySelector('input[name="schedule-published"]:checked');
    const published = schedulePublishedInputEL.value;
    params.append('schedule-id', scheduleId);
    params.append("published", published);
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onUpdateScheduleResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('PUT', 'protected/schedule?' + params.toString());
    xhr.send();
}

function onUpdateScheduleResponse() {
    alert("Schedule updated!");
    if (this.status === OK) {
        showContents(['link-content', 'profile-content', 'logout-content']);
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}



