
document.addEventListener('DOMContentLoaded', onShareLoad);

function onShareLoad() {
    let attribute = document.getElementById("share-content").getAttribute("scheduleId");
    const params = new URLSearchParams();
    params.append("scheduleId", attribute);
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onShareResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('POST', 'share?' + params.toString());
    xhr.send();

}
function onShareResponse() {
    if (this.status === OK) {
        clearMessages();
        let scheduleDto = JSON.parse(this.responseText);
        document.getElementById('share-content').appendChild(populateTable(null, scheduleDto.dayList.length, 24, scheduleDto.dayList.length, scheduleDto.allTaskNames));
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}

