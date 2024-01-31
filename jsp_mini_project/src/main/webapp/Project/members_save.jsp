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
	    // 클라이언트로부터 전달된 데이터 가져오기
	    String name = request.getParameter("name");
	    String birthDate = request.getParameter("birthDate");
	    String gender = request.getParameter("gender");
	    String phone = request.getParameter("phone");
	    String purchaseDate = request.getParameter("purchaseDate");
	    String remainingPlan = request.getParameter("remainingPlan");
	    String remainingPt = request.getParameter("remainingPt");
	    String paused = request.getParameter("paused");
	    String trainerName = request.getParameter("trainerName");
	    String expirationDate = request.getParameter("expirationDate");
	
	    // MEMBERS 테이블에 회원 정보 삽입
	    String insertMembersQuery = "INSERT INTO MEMBERS (NAME, BIRTHDATE, GENDER, PHONE, PURCHASE_DATE, REMAINING_PLAN, REMAINING_PT, PAUSED, TRAINER_NAME, EXPIRATION_DATE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    PreparedStatement pstmtMembers = conn.prepareStatement(insertMembersQuery);
	    pstmtMembers.setString(1, name);
	    pstmtMembers.setDate(2, java.sql.Date.valueOf(birthDate));
	    pstmtMembers.setString(3, gender);
	    pstmtMembers.setString(4, phone);
	    pstmtMembers.setDate(5, java.sql.Date.valueOf(purchaseDate));
	    pstmtMembers.setInt(6, Integer.parseInt(remainingPlan));
	    pstmtMembers.setInt(7, Integer.parseInt(remainingPt));
	    pstmtMembers.setBoolean(8, Boolean.parseBoolean(paused));
	    pstmtMembers.setString(9, trainerName);
	    pstmtMembers.setDate(10, java.sql.Date.valueOf(expirationDate));
	    pstmtMembers.executeUpdate();
	    pstmtMembers.close();
	
	    // TRAINERS 테이블에 트레이너 정보 삽입 (이 부분은 필요에 따라 적절하게 수정해야 합니다)
	    String insertTrainersQuery = "INSERT INTO TRAINERS (NAME, ADMIN_ID, ADMIN_PASSWORD) VALUES (?, ?, ?)";
	    PreparedStatement pstmtTrainers = conn.prepareStatement(insertTrainersQuery);
	    pstmtTrainers.setString(1, trainerName);
	    pstmtTrainers.setString(2, "admin_id"); // 예시로 고정된 값 사용, 실제로는 적절한 값을 설정하세요.
	    pstmtTrainers.setString(3, "admin_password"); // 예시로 고정된 값 사용, 실제로는 적절한 값을 설정하세요.
	    pstmtTrainers.executeUpdate();
	    pstmtTrainers.close();
	
	    out.println("회원 정보가 성공적으로 추가되었습니다.");
	%>
	

</body>
</html>