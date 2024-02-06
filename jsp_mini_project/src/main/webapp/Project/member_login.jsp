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
	            	out.println("<script>");
	    	        out.println("alert('출석이 완료되었습니다. 입장해주세요!');");
	    	        out.println("history.back();"); // 이전 페이지로 이동
	    	        out.println("</script>");
	                
	            } else {
	                out.println("<script>");
	    	        out.println("alert('출석 실패했습니다 다시 입력해주세요');");
	    	        out.println("history.back();"); // 이전 페이지로 이동
	    	        out.println("</script>");
	            }
	        } else {
	        	out.println("<script>");
    	        out.println("alert('해당 번호의 회원을 찾을 수 없습니다.');");
    	        out.println("history.back();"); // 이전 페이지로 이동
    	        out.println("</script>");
	        }
	
	        memberRs.close();
	        memberStmt.close();
	    } else {
	        out.println("<p>올바른 번호를 입력해주세요.</p>");
	    }

	%>

</body>
</html>
<script>
	function selectMember(memberId) {
	    // 선택된 회원으로 로그인 처리를 위해 memberId를 서버에 전송
	    window.location.href = '?memberId=' + memberId + '&login=true';
	}
</script>