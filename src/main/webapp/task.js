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
        showContents(['link-content', 'tasks-content', 'task-fields','back-to-profile-content']);
        onAddTaskLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(tasksContentDivEl, this);
    }

}

function onAddTaskLoad(parse) {
    console.log(parse);
}
