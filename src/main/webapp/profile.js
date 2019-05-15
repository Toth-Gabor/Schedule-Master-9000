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
    showContents(['schedule-content', 'profile-content', 'logout-content', 'add-schedule-content']);
}
