<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  		body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        
        
        
        .attendance-container {
            width: 80%;
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        
        
</style>
</head>
<body>
   <%@ include file="dbconn.jsp"%>
   
   <div class="attendance-container">
        <h2>회원 출석 기록</h2>
         <table>
	        <thead>
	            <tr>
	                <th>회원 이름</th>
	                <th>성별 <th>
	            </tr>
	        </thead>
	        <tbody>
	            <% 
	                String sql = "SELECT m.NAME, a.CHECKIN_TIME FROM ATTENDANCERECORDS a INNER JOIN MEMBERS m ON a.MEMBER_ID = m.MEMBER_ID ORDER BY a.CHECKIN_TIME DESC";
	                ResultSet rs = stmt.executeQuery(sql);
	
	                while (rs.next()) {
	                    String memberName = rs.getString("NAME");
	                    Timestamp checkinTime = rs.getTimestamp("CHECKIN_TIME");
	                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
	            %>
	            <tr>
	                <td><%= memberName %></td>
	                <td><%= sdf.format(checkinTime) %></td>
	            </tr>
	            <% 
	                }
	                rs.close();
	                stmt.close();
	            %>
	        </tbody>
    </table>
    </div>
</body>
</html>

</body> 
</html>

<script>
   
    
</script>