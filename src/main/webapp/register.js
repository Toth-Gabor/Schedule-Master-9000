function onRegisterButtonClicked() {
    const loginFormEl = document.forms['reg-form'];

    const emailInputEl = loginFormEl.querySelector('input[name="email"]');
    const passwordInputEl = loginFormEl.querySelector('input[name="password"]');
    const nameInputEl = loginFormEl.querySelector('input[name="name"]');

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
    xhr.addEventListener('load', onLoginResponse);
    xhr.addEventListener('error', onNetworkError);
    xhr.open('POST', 'reg');
    xhr.send(params);

    
}
