function onProfileLoad(user) {
    clearMessages();
    showContents(['welcome', 'topnav', 'profile-content']);
    $(".g-signin2").css("display", "none");
}
