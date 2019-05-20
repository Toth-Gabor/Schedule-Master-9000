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
function onSheduleAdded() {
    alert("Schedule added!");
    showContents(['link-content', 'profile-content', 'logout-content', 'add-schedule-content']);
}
