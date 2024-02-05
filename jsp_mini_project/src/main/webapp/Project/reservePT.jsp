<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%@ include file="dbconn.jsp"%>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String memberId = request.getParameter("memberId");
		String date = request.getParameter("date");
		String hour = request.getParameter("hour");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH");
		Date parsedDate = sdf.parse(date + " " + hour);
		Timestamp reservationTimestamp = new Timestamp(parsedDate.getTime());
		
		String insertQuery = "INSERT INTO RESERVATIONRECORDS (MEMBER_ID, RESERVATION_TIME) VALUES (?, ?)";
		PreparedStatement insertStatement = conn.prepareStatement(insertQuery);
		insertStatement.setString(1, memberId);
		insertStatement.setTimestamp(2, reservationTimestamp);
		int rowsInserted = insertStatement.executeUpdate();
		

		if (rowsInserted > 0) {
			out.println("<script>");
	        out.println("alert('PT 예약이 완료되었습니다.');");
	        out.println("history.back();"); // 이전 페이지로 이동
	        out.println("</script>");
		} else {
			out.println("<script>");
	        out.println("alert('PT 예약이 실패했습니다 다시 시도해주십시오.');");
	        out.println("history.back();"); // 이전 페이지로 이동
	        out.println("</script>");
		}

		insertStatement.close();

	 	
	%>

</body>
</html>