function onTaskResponse() {
    if (this.status === OK) {
        clearMessages();
        showContents(['link-content', 'schedules-content', 'back-to-profile-content']);
        onScheduleLoad(JSON.parse(this.responseText));
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}
