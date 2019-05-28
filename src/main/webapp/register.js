function onRegisterButtonClicked() {
    const regFormEl = document.forms['reg-form'];

    const emailInputEl = regFormEl.querySelector('input[name="email"]');
    const passwordInputEl = regFormEl.querySelector('input[name="password"]');
    const nameInputEl = regFormEl.querySelector('input[name="name"]');
    const roleInputEl = document.getElementById("role-content");

    const role = roleInputEl.options[roleInputEl.selectedIndex].value;
    const email = emailInputEl.value;
    const password = passwordInputEl.value;
    const name = nameInputEl.value;

    console.log(email,name, role, password);

    const params = new URLSearchParams();
    params.append('email', email);
    params.append('password', password);
    params.append('name', name);
    params.append('role', role);
    console.log(params.toString());

    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onRegisterResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('POST', 'protected/reg' + params.toString());
    xhr.send();
}

function onRegisterResponse() {
    if (this.status === OK) {
        const user = JSON.parse(this.responseText);
        console.log(user);
        showContents(['topnav', 'profile-content']);
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}
