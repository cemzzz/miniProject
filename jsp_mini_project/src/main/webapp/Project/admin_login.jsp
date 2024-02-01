<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Login Result</title>
   
</head>
<body>
<%@ include file = "dbconn.jsp" %>
<%
		String adminId = request.getParameter("adminId");
		String adminPassword = request.getParameter("adminPassword");
		
		String sql = "SELECT * FROM TRAINERS WHERE ADMIN_ID = '" + adminId + "' AND ADMIN_PASSWORD = '" + adminPassword + "'";
	    ResultSet rs = stmt.executeQuery(sql);
		
	    if(rs.next()) {
	        // 로그인 성공시 세션에 admin_id 저장
	        session.setAttribute("admin_id", adminId);

	        // 성공 메시지 표시 후 list.jsp로 이동
	        out.println("<script>alert('" + adminId + "님 로그인하셨습니다.'); window.location = 'list.jsp';</script>");
	    } else {
	        out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다. 다시 시도해주세요.'); history.back();</script>");
	    }

	    rs.close();
	    stmt.close();
%>

</body>
</html>
