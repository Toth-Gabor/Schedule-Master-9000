<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: p8r
  Date: 2019.06.04.
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Share</title>

    <c:url value="/style.css" var="styleUrl"/>
    <c:url value="/schedule.js" var="scheduleScriptUrl"/>
    <c:url value="/schedules.js" var="schedulesScriptUrl"/>
    <script src="${scheduleScriptUrl}"></script>
    <script src="${schedulesScriptUrl}"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>


</head>
<body>
<p id="scheduleDto">${scheduleDto}</p>
<p id="scheduleDtod">${scheduleDto.dayList}</p>
<p id="scheduleDtoa">${scheduleDto.allTaskNames}</p>

<div id="share-content">
    <script>
        const scheduleDto = document.getElementById("scheduleDto").value;
        let shraheDivEl = document.getElementById("share-content");
        shraheDivEl.appendChild(populateTable(null, scheduleDto.dayList.length, 24, scheduleDto.dayList.length, scheduleDto.allTaskNames));
    </script>
</div>

</body>
</html>
