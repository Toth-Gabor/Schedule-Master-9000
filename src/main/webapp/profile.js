function onShopsClicked() {
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onShopsResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/shops');
    xhr.send();
}

function onCouponsClicked() {
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onCouponsResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('GET', 'protected/coupons');
    xhr.send();
}

function onProfileLoad(user) {
    clearMessages();
    showContents(['add-schedule-content', 'edit-schedule-content', 'remove-schedule-content', 'header-content', 'form-buttons-content', 'schedule-table-content', 'profile-content', 'logout-content']);

}
