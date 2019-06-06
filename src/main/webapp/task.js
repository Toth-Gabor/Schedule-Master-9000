let gtaskId;
function onTaskResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['topnav', 'tasks-content', 'task-fields']);
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
    localStorage.setItem("delete-taskId", task.id);
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
}

function onAddTaskResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['topnav', 'show-tname-hid-table','show-alltasks', 'task-fields']);
        onAddTaskLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(tasksContentDivEl, this);
    }

}

function onAddTaskLoad(TaskSceduleDto) {
    const length = TaskSceduleDto.taskNameAndHourIdList.length;
    const tasksHoursDivEl = document.getElementById("show-tname-hid-table");
    let table = document.getElementById("taskhour-table");
    if (table == null){
        tasksHoursDivEl.appendChild(showTHTable(null,length,24,length,TaskSceduleDto.taskNameAndHourIdList));
    } else {
        table.remove();
        tasksHoursDivEl.appendChild(showTHTable(null,length,24,length,TaskSceduleDto.taskNameAndHourIdList));
    }
    const allTasksList = document.getElementById("show-alltasks");

    while(allTasksList.hasChildNodes()) { // remove all previous child Nodes!
        allTasksList.removeChild(allTasksList.firstChild);
    }

    const allTasksListUl = document.createElement("ul");
    allTasksList.appendChild(allTasksListUl);
    for (let i = 0; i <TaskSceduleDto.allTasks.length ; i++) {
        const taskLiEl = document.createElement("li");
        let a = document.createElement('a');
        let taskId = TaskSceduleDto.allTasks[i].id;
        a.href = 'javascript:void(0);';
        a.dataset.taskId = taskId;
        a.addEventListener("click", onTaskNameClicked);
        a.textContent = TaskSceduleDto.allTasks[i].name;
        taskLiEl.appendChild(a);
        allTasksListUl.appendChild(taskLiEl);
    }
}

function showTHTable(table, days, rows, cells, content) {
    if (!table) table = document.createElement('table');

    table.setAttribute('id', "taskhour-table");
    table.setAttribute('border', "1px");
    let head = document.createElement('thead');
    table.appendChild(head);
    let timeThEl = document.createElement('th');
    timeThEl.appendChild(document.createTextNode('Time'));
    head.appendChild(timeThEl);


    for (let x = 1; x <= days; x++) {
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

function onTaskNameClicked() {
    gtaskId = this.dataset.taskId;
    showContents(['add-hourid', 'topnav', 'show-tname-hid-table', 'task-fields', 'show-alltasks']);
}
function onHourIdSubmit() {
    const scheduleId = localStorage.getItem("schedule-id");
    const inputFieldEl = document.forms['add-hourid-form'];
    const hourIdInputEl = inputFieldEl.querySelector('input[name="hourid"]');
    const hourId = hourIdInputEl.value;
    const params = new URLSearchParams();
    params.append('taskId', gtaskId);
    params.append("hourId", hourId);
    params.append("schedule-id", scheduleId);


    const xhr = new XMLHttpRequest();
    xhr.addEventListener('error', onNetworkError);
    xhr.addEventListener('load', onHourIdSubmitResponse);
    xhr.open('POST', 'protected/taskofschedule?' + params.toString());
    xhr.send();
}

function onHourIdSubmitResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['topnav', 'welcome']);
        alert("Task added!");
    } else {
        showContents(['topnav', 'schedules-content']);
        alert("Task already exsisted on current schedule!");
    }

}

function onDeleteTaskClicked() {
    const params = new URLSearchParams();
    params.append('taskId', localStorage.getItem("delete-taskId"));

    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onTaskDeletedResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('DELETE', 'protected/task?' + params.toString());
    xhr.send();
}

function onTaskDeletedResponse() {
    alert("Task deleted");
    showContents(['topnav', 'welcome']);
}

function onDeleteTaskFromScheduleClicked() {
    const ScheduleId = localStorage.getItem("schedule-id");

    const params = new URLSearchParams();
    params.append('schedule-id', ScheduleId);

    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onDeleteTaskResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('PUT', 'protected/taskofschedule?' + params.toString());
    xhr.send(params);
}

function onDeleteTaskResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['show-hourid-fordelete', 'topnav', 'show-tname-hid-table', 'task-fields']);
        onDeleteTaskLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(tasksContentDivEl, this);
    }


}
function onDeleteTaskLoad(hourIdListforDelete) {
    const length = hourIdListforDelete.length;
    const tasksHoursDivEl = document.getElementById("show-hourid-fordelete");
    let table = document.getElementById("taskhour-table");
    if (table == null){
        tasksHoursDivEl.appendChild(showTHTable(null,length,24,length,hourIdListforDelete));
    } else {
        table.remove();
        tasksHoursDivEl.appendChild(showTHTable(null,length,24,length,hourIdListforDelete));
    }
}

function onHourIdDeleteSubmit() {
    const inputFieldEl = document.forms['delete-hourid-form'];
    const hourIdInputEl = inputFieldEl.querySelector('input[name="hourid"]');
    const hourId = hourIdInputEl.value;
    const params = new URLSearchParams();
    params.append("hourId", hourId);

    const xhr = new XMLHttpRequest();
    xhr.addEventListener('error', onNetworkError);
    xhr.open('DELETE', 'protected/taskofschedule?' + params.toString());
    xhr.send();
    showContents(['topnav', 'welcome']);
    alert("Task deleted from this schedule!");

}
function onCreateTaskClicked() {
    const inputFieldEl = document.forms['create-task-form'];
    const taskTitleInputEl = inputFieldEl.querySelector('input[name="task-name"]');
    const taskContentInputEl = inputFieldEl.querySelector('input[name="task-content"]');
    const taskTitle = taskTitleInputEl.value;
    const taskContent = taskContentInputEl.value;
    const params = new URLSearchParams();
    params.append('taskTitle', taskTitle);
    params.append("taskContent", taskContent);


    const xhr = new XMLHttpRequest();
    xhr.addEventListener('error', onNetworkError);
    xhr.open('POST', 'protected/task?' + params.toString());
    xhr.send();
    alert("Task Created!");
    showContents(['topnav', 'welcome']);

}
function onTaskUpdateButtonClicked() {
    const taskId = localStorage.getItem("delete-taskId");
    const inputFieldEl = document.forms['edit-task-content'];
    const taskTitleInputEl = inputFieldEl.querySelector('input[name="task-name"]');
    const taskContentInputEl = inputFieldEl.querySelector('input[name="task-content"]');
    const taskTitle = taskTitleInputEl.value;
    const taskContent = taskContentInputEl.value;
    const params = new URLSearchParams();
    params.append('taskTitle', taskTitle);
    params.append("taskContent", taskContent);
    params.append("taskId", taskId);


    const xhr = new XMLHttpRequest();
    xhr.addEventListener('error', onNetworkError);
    xhr.open('PUT', 'protected/task?' + params.toString());
    xhr.send();
    alert("Task Updated!");
    showContents(['topnav', 'welcome']);
}


function onShowCreateTaskForm() {
    showContents(['topnav', 'creat-task-content']);
}

function onUpdateTaskForm() {
    showContents(['topnav', 'update-task']);
}

function appendTask(task) {
    const taskLiEl = document.createElement('li')
    const aEl = document.createElement('a');
    taskLiEl.appendChild(aEl);
    aEl.textContent = task.name;
    aEl.href = 'javascript:void(0);';
    aEl.dataset.TaskId = task.id;
    aEl.addEventListener('click', onTaskClicked);


    TasksUlEl.appendChild(taskLiEl);
}

function onTaskClicked() {
    const TaskId = this.dataset.TaskId;

    const params = new URLSearchParams();
    params.append('task-id', TaskId);

    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onTaskResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/task?' + params.toString());
    xhr.send(params);
}
