<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <c:url value="/style.css" var="styleUrl"/>
        <c:url value="/index.js" var="indexScriptUrl"/>
        <c:url value="/main.js" var="mainScriptUrl"/>
        <c:url value="/login.js" var="loginScriptUrl"/>
        <c:url value="/profile.js" var="profileScriptUrl"/>
        <c:url value="/back-to-profile.js" var="backToProfileScriptUrl"/>
        <c:url value="/logout.js" var="logoutScriptUrl"/>
        <link rel="stylesheet" type="text/css" href="${styleUrl}">
        <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
        <script src="${indexScriptUrl}"></script>
        <script src="${loginScriptUrl}"></script>
        <script src="${mainScriptUrl}"></script>
        <script src="${profileScriptUrl}"></script>
        <script src="${backToProfileScriptUrl}"></script>
        <script src="${logoutScriptUrl}"></script>
        <title>App</title>
    </head>
    <body>
        <div id="login-content" class="content">
            <h1>Login</h1>
            <form id="login-form" onsubmit="return false;">
                <input type="text" name="email">
                <input type="password" name="password">
                <button id="login-button">Login</button>
            </form>
        </div>
        <div id="container">
          <div id="header-content" class="hidden content">
            <a href="#">View Schedules</a>
            <a href="#">View Profile</a>
            <a href="#">View Tasks</a>
          </div>
        </div>
        <div id="container">
          <div id="form-buttons-content" class="hidden content">
            <button type="button" name="add_schedule">Add Schedule</button>
            <button type="button" name="edit_schedule">Edit Schedule</button>
            <button type="button" name="remove_schedule">Remove Schedule</button>
            <button type="button" name="add_task">Add Task</button>
            <button type="button" name="edit_task">Edit Task</button>
            <button type="button" name="remove_task">Remove Task</button>

          </div>
          <div id="schedule-table-content" class="hidden content">

          </div>
        </div>

        <div id="back-to-profile-content" class="hidden content">
            <button onclick="onBackToProfileClicked();">Back to profile</button>
        </div>
        <div id="logout-content" class="hidden content">
            <button id="logout-button">Logout</button>
        </div>
    </body>
</html>
