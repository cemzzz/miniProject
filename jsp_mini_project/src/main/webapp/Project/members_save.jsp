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
		request.setCharacterEncoding("UTF-8");
	
	    String name = request.getParameter("name");
	    String birthYear = request.getParameter("birthYear");
	    String birthMonth = request.getParameter("birthMonth");
	    String birthDay = request.getParameter("birthDay");
	    String gender = request.getParameter("gender");
	    String phone = request.getParameter("phone");
	    String planId = request.getParameter("membershipPlan");
	    String ptId = request.getParameter("ptSessions");
	    String trainerId = request.getParameter("trainer");
	
	    // 날짜 처리
	    String birthDate = birthYear + "-" + birthMonth + "-" + birthDay;
	  	java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
		
	 	// PLANS 테이블에서 DURATION 가져오기
        String plansQuery = "SELECT DURATION FROM PLANS WHERE PLAN_ID = " + planId;
        ResultSet plansResult = stmt.executeQuery(plansQuery);
        int duration = 0;
        if (plansResult.next()) {
            duration = plansResult.getInt("DURATION");
        }
        plansResult.close();
        
     	// PTSESSIONS 테이블에서 SESSIONS 가져오기
        String ptSessionsQuery = "SELECT SESSIONS FROM PTSESSIONS WHERE PT_ID = " + ptId;
        ResultSet ptSessionsResult = stmt.executeQuery(ptSessionsQuery);
        int sessions = 0;
        if (ptSessionsResult.next()) {
            sessions = ptSessionsResult.getInt("SESSIONS");
        }
        ptSessionsResult.close();
        
     	// 회원권 만료일 계산
        java.sql.Date expirationDate = new java.sql.Date(currentDate.getTime() + (long)duration * 24 * 60 * 60 * 1000);
		
        
        // INSERT 쿼리
        String sql = String.format(
            "INSERT INTO MEMBERS (NAME, BIRTHDATE, GENDER, PHONE, PLAN_ID, PT_ID, TRAINER_ID, PURCHASE_DATE, REMAINING_PLAN, REMAINING_PT, PAUSED, EXPIRATION_DATE) " +
            "VALUES ('%s', DATE '%s', '%s', '%s', %d, %d, %d, DATE '%s', %d, %d, 1, DATE '%s')",
            name, birthDate, gender, phone, Integer.parseInt(planId), Integer.parseInt(ptId), Integer.parseInt(trainerId), currentDate.toString(), duration, sessions, expirationDate.toString()
        );

        
        // Statement 객체 생성
        stmt.executeUpdate(sql);
        
        // 회원 등록 성공 메시지와 함께 members.jsp로 리디렉션
        response.sendRedirect("members.jsp");
	
	%>
	

</body>
</html>