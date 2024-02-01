<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file = "dbconn.jsp" %>
	<%
    // 세션 종료
    session.invalidate();

%>

</body>
</html>
<script>
    alert("로그아웃 되었습니다.");
    window.location.href = "Enter.jsp"; // enter.jsp로 리디렉션
</script>