function onListSchedulesClicked() {
    const params = new URLSearchParams();
    const user = getAuthorization();
    params.append('id', user.id);
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onSchedulesResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/schedules?' + params.toString());
    xhr.send();
}

function onProfileLoad(user) {
    clearMessages();
    showContents(['link-content', 'profile-content', 'logout-content', 'add-schedule-content']);
}

function onListTasksClicked() {
    const params = new URLSearchParams();
    const user = getAuthorization();
    const dayValue = null;
    const isPublished =
    params.append('id', user.id);
    params.append("dayValue",dayValue);


    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onTasksResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/tasks?' + params.toString());
    xhr.send();

}

function onAddScheduleClicked() {
    const dayValueInputEl = document.getElementById("day-number-content");
    const publishedInputEl = document.getElementById("schedule-published");
    const dayValue = dayValueInputEl.options[dayValueInputEl.selectedIndex].value;
    const published = publishedInputEl.options[publishedInputEl.selectedIndex].value;
    const params = new URLSearchParams();
    const user = getAuthorization();
    params.append('id', user.id);
    params.append("day-value", dayValue);
    params.append("schedule-published", published);
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onAddScheduleResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('POST', 'protected/schedule?' + params.toString());
    xhr.send(params);
}
