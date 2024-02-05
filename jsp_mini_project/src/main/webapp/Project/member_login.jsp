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
		String enteredNumber = request.getParameter("enteredNumber");
	
	    if (enteredNumber != null && enteredNumber.length() == 4) {
	        // MEMBERS 테이블에서 전화번호 뒷자리가 일치하는 회원의 ID를 조회
	        String memberQuery = "SELECT MEMBER_ID FROM MEMBERS WHERE PHONE LIKE ?";
	        PreparedStatement memberStmt = conn.prepareStatement(memberQuery);
	        memberStmt.setString(1, "%" + enteredNumber);
	        ResultSet memberRs = memberStmt.executeQuery();
	
	        if (memberRs.next()) {
	            int memberId = memberRs.getInt("MEMBER_ID");
	
	            // ATTENDANCERECORDS에 출석 기록 추가
	            String insertSql = "INSERT INTO ATTENDANCERECORDS (MEMBER_ID, CHECKIN_TIME) VALUES (?, CURRENT_TIMESTAMP)";
	            PreparedStatement insertStmt = conn.prepareStatement(insertSql);
	            insertStmt.setInt(1, memberId);
	            int rowsAffected = insertStmt.executeUpdate();
	
	            if (rowsAffected > 0) {
	                out.println("<p>출석이 성공적으로 등록되었습니다.</p>");
	            } else {
	                out.println("<p>출석 등록에 실패했습니다.</p>");
	            }
	        } else {
	            out.println("<p>해당 번호의 회원을 찾을 수 없습니다.</p>");
	        }
	
	        memberRs.close();
	        memberStmt.close();
	    } else {
	        out.println("<p>올바른 번호를 입력해주세요.</p>");
	    }

	%>

</body>
</html>