let gtaskId;
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
        showContents(['link-content', 'show-tname-hid-table','show-alltasks', 'task-fields','back-to-profile-content']);
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

function onTaskNameClicked() {
    gtaskId = this.dataset.taskId;
    showContents(['add-hourid', 'link-content', 'show-tname-hid-table', 'task-fields', 'back-to-profile-content', 'show-alltasks']);
}
function onHourIdSubmit() {
    const inputFieldEl = document.forms['add-hourid-form'];
    const hourIdInputEl = inputFieldEl.querySelector('input[name="hourid"]');
    const hourId = hourIdInputEl.value;
    const params = new URLSearchParams();
    params.append('taskId', gtaskId);
    params.append("hourId", hourId);


    const xhr = new XMLHttpRequest();
    xhr.addEventListener('error', onNetworkError);
    xhr.open('POST', 'protected/taskofschedule?' + params.toString());
    xhr.send();
    alert("Task added!");
    showContents(['link-content', 'back-to-profile-content']);
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
    showContents(['back-to-profile-content', 'link-content']);
}

function onDeleteTaskClicked() {
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
        showContents(['show-hourid-fordelete', 'link-content', 'show-tname-hid-table','show-alltasks', 'task-fields','back-to-profile-content']);
        onDeleteTaskLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(tasksContentDivEl, this);
    }


}
function onDeleteTaskLoad(hourIdListforDelete) {
    console.log(hourIdListforDelete);
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
    showContents(['link-content', 'back-to-profile-content']);
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
    showContents(['link-content', 'back-to-profile-content']);

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
    showContents(['link-content', 'back-to-profile-content']);
}
