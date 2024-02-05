<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>

<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  		body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 20px;
        }
        .form-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: auto;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        select, input[type="text"], input[type="submit"], input[type="button"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        input[type="submit"], input[type="button"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            border: none;
        }
        input[type="submit"]:hover, input[type="button"]:hover {
            background-color: #45a049;
        }
        
        .birthdate-group {
            display: flex;
        }
        .birthdate-group select {
            flex-basis: 30%; /* 각 드롭다운의 크기 */
        }

</style>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	
	<%
	    String memberId = request.getParameter("memberId");
    	
    	ResultSet rs = stmt.executeQuery("SELECT * FROM MEMBERS WHERE MEMBER_ID = " + memberId);
    	if (rs.next()) {
    		 int remainingPlan = rs.getInt("REMAINING_PLAN");
             int remainingPT = rs.getInt("REMAINING_PT");
             
             Date birthdate = rs.getDate("BIRTHDATE");
             Calendar cal = Calendar.getInstance();
             if(birthdate != null) {
                 cal.setTime(birthdate);
             }
             int year = cal.get(Calendar.YEAR);
             int month = cal.get(Calendar.MONTH) + 1;
             int day = cal.get(Calendar.DAY_OF_MONTH);
	%>
	    <h2>회원 상세 정보</h2>
	    <form id="memberForm" action="updateMember.jsp" method="post">
			<div>
		        <label for="name">이름:</label>
		        <input type="hidden" name="memberId" value="<%= memberId %>">
		        <input type="text" id="name" name="name" value="<%= rs.getString("NAME") %>" >			
			</div>
			
			<div class="birthdate-group">
	             <div>
                <label for="birthYear">생년:</label>
                <select id="birthYear" name="birthYear">
                    <% for (int i = 1920; i <= 2024; i++) { %>
                    <option value="<%= i %>" <%= i == year ? "selected" : "" %>><%= i %></option>
                    <% } %>
                </select>
            </div>

            <!-- 월 드롭다운 -->
            <div>
                <label for="birthMonth">월:</label>
                <select id="birthMonth" name="birthMonth">
                    <% for (int i = 1; i <= 12; i++) { %>
                    <option value="<%= i %>" <%= i == month ? "selected" : "" %>><%= i %></option>
                    <% } %>
                </select>
            </div>

            <!-- 일 드롭다운 -->
            <div>
                <label for="birthDay">일:</label>
                <select id="birthDay" name="birthDay">
                    <% for (int i = 1; i <= 31; i++) { %>
                    <option value="<%= i %>" <%= i == day ? "selected" : "" %>><%= i %></option>
                    <% } %>
                </select>
            </div>
	        </div>
			
			<div>
		        <label for="gender">성별:</label>
		        <select id="gender" name="gender">
		            <option value="M" <%= "M".equals(rs.getString("GENDER").trim()) ? "selected" : "" %>>남성</option>
		            <option value="F" <%= "F".equals(rs.getString("GENDER").trim()) ? "selected" : "" %>>여성</option>
		        </select>			
			</div>
			
			<div>
		        <label for="phone">전화번호:</label>
		        <input type="text" id="phone" name="phone" value="<%= rs.getString("PHONE") %>" >		
			</div>
			
			<div>
				<label for="remainingPlan">구매한 회원권:</label>
                <select id="remainingPlan" name="remainingPlan">
                    <%
                        Statement stmtPlan = conn.createStatement();
                        ResultSet rsPlan = stmtPlan.executeQuery("SELECT DISTINCT REMAINING_PLAN FROM MEMBERS ORDER BY REMAINING_PLAN");
                        while(rsPlan.next()) {
                            int plan = rsPlan.getInt("REMAINING_PLAN");
                    %>
                    <option value="<%= plan %>" <%= plan == remainingPlan ? "selected" : "" %>><%= plan %>일</option>
                    <%
                        }
                        rsPlan.close();
                        stmtPlan.close();
                    %>
                </select>
			</div>

            <div>
	        	<label for="remainingPT">구매한 PT 횟수:</label>
                <select id="remainingPT" name="remainingPT">
                    <%
                        Statement stmtPT = conn.createStatement();
                        ResultSet rsPT = stmtPT.executeQuery("SELECT DISTINCT REMAINING_PT FROM MEMBERS ORDER BY REMAINING_PT");
                        while(rsPT.next()) {
                            int pt = rsPT.getInt("REMAINING_PT");
                    %>
                    <option value="<%= pt %>" <%= pt == remainingPT ? "selected" : "" %>><%= pt %>회</option>
                    <%
                        }
                        rsPT.close();
                        stmtPT.close();
                    %>
                </select>
            </div>   
	
			<div>
		        <label for="status">회원권 상태:</label>
		        <select id="status" name="status">
		            <option value="0" <%= rs.getInt("PAUSED") == 0 ? "selected" : "" %>>정지</option>
		            <option value="1" <%= rs.getInt("PAUSED") == 1 ? "selected" : "" %>>이용중</option>
		        </select>			
			</div>
			
			<div>
		   		<label for="trainer">담당 트레이너:</label>
		        <select id="trainer" name="trainer">
		            <% 
			            Statement trainerStmt = conn.createStatement();
			            ResultSet trainers = trainerStmt.executeQuery("SELECT TRAINER_ID, NAME FROM TRAINERS");
			           
		                while (trainers.next()) {
		                    String trainerId = trainers.getString("TRAINER_ID");
		                    String trainerName = trainers.getString("NAME");
		                    boolean isSelected = trainerId.equals(rs.getString("TRAINER_ID"));
		            %>
		        		<option value="<%= trainerId %>" <%= isSelected ? "selected" : "" %>><%= trainerName %></option>
		            <%
		                }
		                trainers.close();
		            %>
		        </select>			
			</div>
	     	<input type="button" value="수정하기" onclick="confirmEdit()">
		    <input type="button" value="취소" onclick="cancelEdit()">   
	    </form>
	<%
	    }
	    rs.close();
	    stmt.close();
	%>
</body>
</html>
<script>
	 function confirmEdit() {
         if (confirm("수정하시겠습니까?")) {
             document.getElementById("memberForm").submit();
         }
     }
	 
	function cancelEdit() {
	    var confirmCancel = confirm("수정을 취소하시겠습니까?");
	    if (confirmCancel) {
	        window.close();
	    }
	}
	
</script>