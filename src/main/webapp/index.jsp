<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <c:url value="/style.css" var="styleUrl"/>
    <c:url value="/index.js" var="indexScriptUrl"/>
    <c:url value="/schedule.js" var="scheduleScriptUrl"/>
    <c:url value="/schedules.js" var="schedulesScriptUrl"/>
    <c:url value="/task.js" var="taskScriptUrl"/>
    <c:url value="/tasks.js" var="tasksScriptUrl"/>
    <c:url value="/login.js" var="loginScriptUrl"/>
    <c:url value="/profile.js" var="profileScriptUrl"/>
    <c:url value="/back-to-profile.js" var="backToProfileScriptUrl"/>
    <c:url value="/logout.js" var="logoutScriptUrl"/>
    <link rel="stylesheet" type="text/css" href="${styleUrl}">
    <script src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
    <script src="${indexScriptUrl}"></script>
    <script src="${loginScriptUrl}"></script>
    <script src="${scheduleScriptUrl}"></script>
    <script src="${schedulesScriptUrl}"></script>
    <script src="${taskScriptUrl}"></script>
    <script src="${tasksScriptUrl}"></script>
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
        <div id="add-schedule-content" class="hidden content">
            <h2>Adding a new schedule:</h2>
            <h3>Select how long your schedule will be:</h3>
            <form id="add-schedule-form" onsubmit="return false;">
                <select id="day-number-content" name="day-value">
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
                <select id="schedule-published" name="schedule-published">
                    <option value="false">Private</option>
                    <option value="true">Published</option>
                </select>
                <button onclick="onAddScheduleClicked()">Add schedule</button>
            </form>
        </div>

        <form id="edit-schedule-content" class="hidden content" action="index.html" method="post">
            <h2>Editing your schedule:</h2>
            <h3>Select the ID of the schedule, which you would like to edit:</h3>
            <input type="number" name="schedule-id" min="minValue" max="maxValue">
            <h3>Select the visibility of your schedule:</h3>
            <input type="radio" name="schedule-published" value="true">Public
            <input type="radio" name="schedule-published" value="false">Private
            <input type="submit" name="Submit" value="submit">
        </form>

        <form id="remove-schedule-content" class="hidden content" action="index.html" method="post">
            <h2>Removing a schedule:</h2>
            <h3>Select the ID of the schedule, which you would like to delete:</h3>
            <input type="number" name="schedule-id" min="minValue" max="maxValue">
            <input type="submit" name="Submit" value="submit">
        </form>

        <form id="add-task-content" class="hidden content" action="index.html" method="post">
            <input type="text" name="task-name" value="">
            <input type="text" name="task-content" value="">
            <input type="submit" name="Submit" value="submit">
        </form>

        <form id="edit-task-content" class="hidden content" action="index.html" method="post">

        </form>

        <form id="remove-task-content" class="hidden content" action="index.html" method="post">

        </form>

    </div>
</div>

<div id="link-content" class="hidden content">

    <h2>Links</h2>
    <ul>
        <li><a href="javascript:void(0);" onclick="onListSchedulesClicked();">Schedules</a></li>
        <li><a href="javascript:void(0);" onclick="onListTasksClicked();">Tasks</a></li>
    </ul>
</div>

<div id="schedules-content" class="hidden content">
    <h1>Schedules</h1>

    <table id="schedules">
        <tbody>

        </tbody>
    </table>

    <div id="schedules-fields" class="hidden content">
        <ul>
            <li>schedule id: <span id="schedule-id"></span></li>
            <li>schedule published: <span id="schedule-published-show"></span></li>
        </ul>
        <button onclick="onAddTaskClicked()">Add task</button>
    </div>

    <div id="populate-schedule" class="hidden content">

    </div>

</div>
<div id="show-tname-hid-table" class="hidden content">

</div>
<div id="show-alltasks">

</div>
<div id="tasks-content" class="hidden content">
    <h1>Tasks</h1>

    <table id="tasks">
        <tbody>

        </tbody>
    </table>

    <div id="task-fields" class="hidden content">
        <ul>
            <li>task name:
                <bold><span id="task-name"></span></bold>
            </li>
            <li>task content:
                <bold><span id="task-content"></span></bold>
            </li>
        </ul>
    </div>

</div>

<div>

</div>


<div id="back-to-profile-content" class="hidden content">
    <button onclick="onBackToProfileClicked();">Back to profile</button>
</div>
<div id="logout-content" class="hidden content">
    <button id="logout-button">Logout</button>
</div>
</body>
</html>
