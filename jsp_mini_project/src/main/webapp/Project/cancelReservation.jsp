<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
		String recordId = request.getParameter("recordId");
	    
	    // 예약 취소 쿼리 실행
	    String deleteQuery = "DELETE FROM RESERVATIONRECORDS WHERE RECORD_ID = ?";
	    PreparedStatement deleteStatement = conn.prepareStatement(deleteQuery);
	    deleteStatement.setString(1, recordId);
	    int rowsDeleted = deleteStatement.executeUpdate();
	    deleteStatement.close();
	
	    if (rowsDeleted > 0) {
	        out.println("예약이 성공적으로 취소되었습니다.");
	    } else {
	        out.println("예약 취소 실패: 해당 예약을 찾을 수 없습니다.");
	    }
	
	
	%>

</body>
</html>