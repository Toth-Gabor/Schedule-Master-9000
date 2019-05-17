function onTaskResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['link-content', 'tasks-content', 'task-fields','back-to-profile-content']);
        onTaskLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(tasksContentDivEl, this);
    }
}

function onTaskLoad(taskList) {
    let taskNameSpanEl = document.getElementById('task-name');
    let taskContentSpanEl = document.getElementById('task-content');

    taskNameSpanEl.innerHTML = taskList.name;
    taskContentSpanEl.innerHTML = taskList.content;

}
function onAddTaskClicked() {
    const ScheduleId = this.dataset.ScheduleId;



    //kell valahogy a schedule id a kattintásból
    //kell egy új dao a hour_task insertre



    //1. kiválasztod melyik taskot
    //2. kiválasztod melyik napra --> schedule id alapján napok listája
    //3. kiválasztod hény órára -- > naplista alapján óra lista
    //add és deletet egymás után meghívni vagy trigger

}
