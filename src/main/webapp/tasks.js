let TasksEl;
let TasksUlEl;

function onTasksResponse() {
    if (this.status === OK) {
        showContents(['back-to-profile-content', 'tasks-content', 'link-content']);
        onTasksLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(tasksContentDivEl, this);
    }
}

function onTasksLoad(Tasks) {
    TasksEl = document.getElementById('tasks');
    TasksUlEl = TasksEl.querySelector('ul');

    appendTasks(Tasks);
}

function appendTasks(Tasks) {
    removeAllChildren(TasksUlEl);

    for (let i = 0; i < Tasks.length; i++) {
        const task = Tasks[i];
        appendTask(task);
    }
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

function onShowAddTaskForm() {
    showContents(['link-content', 'back-to-profile-content', 'creat-task-content']);

}
function onUpdateTaskForm() {
    showContents(['link-content', 'back-to-profile-content', 'update-task']);

}
