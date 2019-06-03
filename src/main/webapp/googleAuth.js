function onSignIn(googleUser) {
  var profile = googleUser.getBasicProfile();
  var id_token = googleUser.getAuthResponse().id_token;
  const xhr = new XMLHttpRequest();
  const params = new URLSearchParams();
  params.append('id-token', id_token);
  xhr.open('POST', 'auth');
  xhr.send(params);


  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
  console.log('Name: ' + profile.getName());
  console.log('Image URL: ' + profile.getImageUrl());
  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
  $(".g-signin2").css("display", "none");
  $(".data").css("display", "block");
  $("#pic").css('src', profile.getImageUrl());
  $("#email").text(profile.getEmail());
  showContents(['topnav', 'google-content', 'profile-content']);
}

function signOut() {
  var auth2 = gapi.auth2.getAuthInstance();
  auth2.signOut().then(function () {
    console.log('User signed out.');
    $(".g-signin2").css("display", "block");
  });
  showContents(['login-content', 'google-signin-content']);

}
