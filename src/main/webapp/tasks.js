let TasksEl;
let TasksUlEl;

function onTasksResponse() {
    if (this.status === OK) {
        showContents(['tasks-content', 'topnav']);
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

function onListTasksClicked() {
    const params = new URLSearchParams();
    const user = getAuthorization();
    const dayValue = null;
    params.append('id', user.id);
    params.append("dayValue",dayValue);


    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onTasksResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/tasks?' + params.toString());
    xhr.send();
}
