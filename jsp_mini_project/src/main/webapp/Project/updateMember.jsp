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
	<%@ include file="dbconn.jsp" %>
    <%
    	request.setCharacterEncoding("UTF-8");
	    PreparedStatement pstmt = null, pstmtUpdateSales = null, pstmtSelectPlans = null, pstmtSelectPTSessions = null;
	    ResultSet rsPlans = null, rsPTSessions = null;
	    try {
	    	String selectPlans = "SELECT PRICE FROM PLANS WHERE PLAN_ID = (SELECT PLAN_ID FROM MEMBERS WHERE MEMBER_ID = ?)";
            String selectPTSessions = "SELECT PRICE FROM PTSESSIONS WHERE PT_ID = (SELECT PT_ID FROM MEMBERS WHERE MEMBER_ID = ?)";
            
            
	        // memberDetail.jsp로부터 전달된 파라미터 수집
	        String memberId = request.getParameter("memberId");
	        String name = request.getParameter("name");
	        int birthYear = Integer.parseInt(request.getParameter("birthYear"));
	        int birthMonth = Integer.parseInt(request.getParameter("birthMonth"));
	        int birthDay = Integer.parseInt(request.getParameter("birthDay"));
	        String gender = request.getParameter("gender");
	        String phone = request.getParameter("phone");
	        
	        String remainingPlan = request.getParameter("remainingPlan"); 
            String remainingPT = request.getParameter("remainingPT");
            String status = request.getParameter("status"); // BOOLEAN 타입으로 가정
            String trainerId = request.getParameter("trainer"); 
	      
	        String birthdate = birthYear + "-" + birthMonth + "-" + birthDay;
	
	       
            String sql = "UPDATE MEMBERS SET NAME = ?, BIRTHDATE = ?, GENDER = ?, PHONE = ?, REMAINING_PLAN = ?, REMAINING_PT = ?, PAUSED = ?, TRAINER_ID = ? WHERE MEMBER_ID = ?";
	        pstmt = conn.prepareStatement(sql);
	
	        // 쿼리 파라미터 설정
	        pstmt.setString(1, name);
            pstmt.setDate(2, java.sql.Date.valueOf(birthdate));
            pstmt.setString(3, gender);
            pstmt.setString(4, phone);
            pstmt.setInt(5, Integer.parseInt(remainingPlan));
          	pstmt.setInt(6, Integer.parseInt(remainingPT));
            pstmt.setBoolean(7, "1".equals(status)); // PAUSED 필드가 BOOLEAN 타입일 경우, "1"은 true, "0"은 false
            pstmt.setString(8, trainerId);
            pstmt.setString(9, memberId);
	
	        // 쿼리 실행
            int affectedRows = pstmt.executeUpdate();

            // 업데이트 성공 메시지
            if(affectedRows > 0) {
            	  out.println("<script>");
                  out.println("alert('수정이 완료되었습니다.');");
                  out.println("window.opener.location.reload();");
                  out.println("window.close();");
                  out.println("</script>");
            } else {
            	out.println("<script>alert('회원 정보 업데이트에 실패했습니다.');</script>");
            }
        } catch(Exception e) {
            e.printStackTrace();
            out.println("<script>alert('업데이트 중 오류가 발생했습니다.');</script>");
        } finally {
            if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if(conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
	    %>
</body>
</html>