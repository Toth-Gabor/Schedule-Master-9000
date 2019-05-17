let TasksTableEl;
let TasksTableBodyEl;

function onTasksResponse() {
    if (this.status === OK) {
        showContents(['back-to-profile-content', 'tasks-content', 'link-content']);
        onTasksLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}

function onTasksLoad(Tasks) {
    TasksTableEl = document.getElementById('tasks');
    TasksTableBodyEl = TasksTableEl.querySelector('tbody');

    appendTasks(Tasks);
}

function appendTasks(Tasks) {
    removeAllChildren(TasksTableBodyEl);

    for (let i = 0; i < Tasks.length; i++) {
        const task = Tasks[i];
        appendTask(task);
    }
}
function appendTask(task) {
    const aEl = document.createElement('a');
    aEl.textContent = task.id;
    aEl.href = 'javascript:void(0);';
    aEl.dataset.TaskId = task.id;
    aEl.addEventListener('click', onTaskClicked);

    const trEl = document.createElement('tr');
    trEl.appendChild(aEl);
    TasksTableBodyEl.appendChild(trEl);
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
