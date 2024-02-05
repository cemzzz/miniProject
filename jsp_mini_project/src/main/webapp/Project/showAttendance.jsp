<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
	    int year = Integer.parseInt(request.getParameter("year"));
	    int month = Integer.parseInt(request.getParameter("month"));
	    String startDate = year + "-" + month + "-01";
	    String endDate = year + "-" + (month + 1) + "-01";
	
	    String sql = "SELECT * FROM ATTENDANCERECORDS WHERE CHECKIN_TIME >= ? AND CHECKIN_TIME < ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, startDate);
	    pstmt.setString(2, endDate);
	    ResultSet rs = pstmt.executeQuery();
	
	    while (rs.next()) {
	        // 출석 기록 처리
	        // 예: 회원 ID와 체크인 시간 출력
	        int memberId = rs.getInt("MEMBER_ID");
	        Timestamp checkinTime = rs.getTimestamp("CHECKIN_TIME");
	        out.println("회원 ID: " + memberId + ", 체크인 시간: " + checkinTime + "<br>");
	    }
	
	    rs.close();
	    pstmt.close();
	%>

</body>
</html>