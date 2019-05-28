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
    <c:url value="/register.js" var="tasksScriptUrl"/>
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
    <script src="${registerScriptUrl}"></script>
    <script src="${schedulesScriptUrl}"></script>
    <script src="${taskScriptUrl}"></script>
    <script src="${tasksScriptUrl}"></script>
    <script src="${profileScriptUrl}"></script>
    <script src="${backToProfileScriptUrl}"></script>
    <script src="${logoutScriptUrl}"></script>
    <title>App</title>
</head>
<body>
<div id="topnav" class="hidden content">
    <a id="logout-menu-button" class="active" href="javascript:void(0);">Logout</a>
    <a href="javascript:void(0);" onclick="onListSchedulesClicked();">Schedules</a>
    <a href="javascript:void(0);" onclick="onListTasksClicked();">Tasks</a>
    <a href="javascript:void(0);" onclick="onBackToProfileClicked();">Back to profile</a>
</div>

<div id="welcome" class="hidden content">
    <h1>Welcome</h1>
    <h2>Founders:</h2>
    <ul>
        <li><h3>Péter Taraszvics</h3></li>
        <li><h3>András Urbin</h3></li>
        <li><h3>Gábor Tóth</h3></li>
    </ul>
</div>

<div id="reg-content" class="hidden content">
    <h1>Registration</h1>
    <form id="reg-form" onsubmit="return false;">
        Name: <input type="text" name="name" required placeholder="First name">
        <br>
        E-mail: <input type="email" name="email" required placeholder="E-mail">
        <br>
        Password: <input type="password" name="password" required placeholder="*****">
        <br>
        Role:
        <select id="role-content" name="role">
            <option value="false">User</option>
            <option value="true">Admin</option>
        </select>
        <button id="reg-button" onclick="onRegisterButtonClicked()">Register</button>
    </form>
</div>

<div id="login-content" class="content">
    <h1>Login</h1>
    <form id="login-form" onsubmit="return false;">
        <input type="text" name="email">
        <input type="password" name="password">
        <button id="login-button">Login</button>
        <button id="go-reg-button" onclick="showRegisterDiv()">Register</button>
    </form>
</div>

<div id="servlet-form-content">
    <form id="remove-schedule-content" class="hidden content" action="index.html" method="post">
        <h2>Removing a schedule:</h2>
        <h3>Select the ID of the schedule, which you would like to delete:</h3>
        <input type="number" name="schedule-id" min="minValue" max="maxValue">
        <input type="submit" name="Submit" value="submit">
    </form>
    <form id="remove-task-content" class="hidden content" action="index.html" method="post"></form>
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
    <button type="button" name="add-schedule" onclick="onShowAddScheduleForm()">Add Schedule</button>
    <div id="schedules">
        <ul>

        </ul>
    </div>
    <div id="published-schedules">
        <ul>

        </ul>
    </div>
    <div id="schedules-fields" class="hidden content">
        <ul>
            <li>schedule id: <span id="schedule-id"></span></li>
            <li>schedule is <span id="schedule-published-show"></span></li>
        </ul>
        <button onclick="onAddTaskClicked()">Add task</button>
        <button onclick="onDeleteTaskFromScheduleClicked()">Delete task</button>
        <button onclick="onShowUpdateClicked()">Update schedule</button>
        <button onclick="onDeleteScheduleClicked()">Delete this schedule</button>
    </div>
    <div id="populate-schedule" class="hidden content"></div>
</div>

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
        <br>
    </form>
</div>

<div id="update-schedule" class="hidden content">
    <form id="edit-schedule-content" onsubmit="return false;">
        <h2>Editing your schedule:</h2>
        <h3>Select the visibility of your schedule:</h3>
        <select id="schedule-published-update" name="schedule-published">
            <option value="false">Private</option>
            <option value="true">Published</option>
        </select>
        <button onclick="onUpdateButtonClicked()">Update</button>
    </form>
</div>

<div id="show-tname-hid-table" class="hidden content"></div>

<div id="show-hourid-fordelete" class="hidden content">
    <p id="dayid"></p>
    <form id="delete-hourid-form" onsubmit="return false;">
        <input name="hourid" type="number" required>
        <button id="delete-hourid-button" onclick="onHourIdDeleteSubmit()">Delete</button>
    </form>
</div>

<div id="show-alltasks" class="hidden content">
    <h2>Tasks:</h2>
</div>

<div id="add-hourid" class="hidden content">
    <p id="taskname"></p>
    <form id="add-hourid-form" onsubmit="return false;">
        <input name="hourid" type="number" required>
        <button id="add-hourid-button" onclick="onHourIdSubmit()">Add</button>
    </form>
</div>


<div id="tasks-content" class="hidden content">
    <h1>Tasks</h1>
    <button type="button" name="add-task" onclick="onShowAddTaskForm()">Create Task</button>
    <div id="tasks">
        <ul>

        </ul>
    </div>
    <div id="task-fields" class="hidden content">
        <ul>
            <li>task name:
                <span id="task-name"></span>
            </li>
            <li>task content:
                <span id="task-content"></span>
            </li>
        </ul>
        <button id="delete-task" onclick="onDeleteTaskClicked()">Delete task</button>
        <button type="button" name="update-task" onclick="onUpdateTaskForm()">Update Task</button>
    </div>
</div>

<div id="update-task" class="hidden content">
    <form id="edit-task-content" onsubmit="return false;">
        <h2>Editing your Task:</h2>
        <h3>Enter the title and the content of your task:</h3>
        <input type="text" name="task-name" placeholder="Title" required>
        <input type="text" name="task-content" placeholder="Content" required>
        <button onclick="onTaskUpdateButtonClicked()">Update</button>
    </form>
</div>

<div id="creat-task-content" class="hidden content">
    <form id="create-task-form" onsubmit="return false;">
        <input type="text" name="task-name" placeholder="Title" required>
        <input type="text" name="task-content" placeholder="Content" required>
        <button id="onCreateTaskFormSubmit" onclick="onCreateTaskClicked()">Create Task</button>
    </form>
</div>

<div id="back-to-profile-content" class="hidden content">
    <br>
    <button onclick="onBackToProfileClicked();">Back to profile</button>
</div>

<div id="logout-content" class="hidden content">
    <button id="logout-button">Logout</button>
</div>
</body>
</html>
