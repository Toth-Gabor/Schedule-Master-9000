let SchedulesDivEl;
let SchedulesUlEl;
let publicSchedulesDivEl;
let publicScheduleUlEl;

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

function onListSchedulesClicked() {
    const params = new URLSearchParams();
    const user = getAuthorization();
    params.append('id', user.id);
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onSchedulesResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/schedules?' + params.toString());
    xhr.send(params);
    //van e kétszer para debugban
}

