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

    const params = new URLSearchParams();
    params.append('email', email);
    params.append('password', password);
    params.append('name', name);
    params.append('role', role);
    const xhr = new XMLHttpRequest();
    xhr.addEventListener('load', onRegisterResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('POST', 'reg?' + params.toString());
    xhr.send();
}

function onRegisterResponse() {
    if (this.status === OK) {
        showContents(['login-content']);
    } else {
        onOtherResponse(schedulesContentDivEl, this);
    }
}
