function onTaskResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['link-content', 'schedules-content', 'back-to-profile-content']);
        console.log(JSON.parse(this.responseText));
        onTaskLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(tasksContentDivEl, this);
    }
}

function onTaskLoad(tasksDto) {

}
