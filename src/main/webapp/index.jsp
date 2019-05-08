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
            <button type="button" name="add-schedule">Add Schedule</button>
            <button type="button" name="edit-schedule">Edit Schedule</button>
            <button type="button" name="remove-schedule">Remove Schedule</button>
            <button type="button" name="add-task">Add Task</button>
            <button type="button" name="edit-task">Edit Task</button>
            <button type="button" name="remove-task">Remove Task</button>
          </div>
            <div id="servlet-form-content">
              <form id="add-schedule-content" class="hidden content" action="index.html" method="post">
                <h2>Adding a new schedule:</h2>
                <h3>Select how long your schedule will be:</h3>
                <select>
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
                  <option value="6">6</option>
                  <option value="7">7</option>
                </select>
                day(s)!
                <h3>Select the visibility of your schedule:</h3>
                <input type="radio" name="schedule-published" value="true">Public
                <input type="radio" name="schedule-published" value="false">Private
                <input type="submit" name="Submit" value="submit">
              </form>
              <form id="edit-schedule-content" class="hidden content" action="index.html" method="post">
                <h2>Editing your schedule:</h2>
                <h3>Select the visibility of your schedule:</h3>
                <input type="radio" name="schedule-published" value="true">Public
                <input type="radio" name="schedule-published" value="false">Private
                <input type="submit" name="Submit" value="submit">
              </form>
              <form id="remove-schedule-content" class="hidden content" action="index.html" method="post">
                <form>
                  <h2>Removing a schedule:</h2>
                  <h3>Select the ID of the schedule, which you would like to delete:</h3>
                  <input type="number" name="quantity" min="minValue" max="maxValue">
                  <input type="submit" name="Submit" value="submit">
                </form>
              </form>
              <form id="add-task-content" class="hidden content" action="index.html" method="post">

              </form>
              <form id="edit-task-content" class="hidden content" action="index.html" method="post">

              </form>
              <form id="remove-task-content" class="hidden content" action="index.html" method="post">

              </form>

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
