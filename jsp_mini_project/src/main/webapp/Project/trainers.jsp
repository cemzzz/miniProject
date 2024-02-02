<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
    	font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        display: flex;
        }
        
    /* 좌측 컨테이너 스타일 */    
	#leftContainer {
    	width: 20%; 
        background-color: #f0f0f0; 
        padding: 20px; 
        height: 100vh; 
        overflow-y: auto; 
    }
    #leftContainer li {
    	padding: 8px;
 		margin-bottom: 5px;
        background-color: #e9e9e9;
        border-radius: 4px;
        list-style-type: none;
        cursor: pointer;
        display: block; 
       	margin: auto;
    }
 	#leftContainer li:hover {
        background-color: #d9d9d9;
    }
    #leftContainer ul {
	   	padding-left: 0;
	   	magin-bottom: 10px;
	    text-align: center; /* 텍스트 중앙 정렬 */
    
    }
    

	/* 중앙 컨테이너 스타일 */
	#mainContainer {
    	width: 80%; 
        background-color: #ffffff; 
        padding: 20px; 
        height: 100vh; 
        overflow-y: auto; 
    }	

  
    #trainerDetail {
    	height: 50%; 
        border-bottom: 1px solid #ddd; 
        margin-bottom: 20px; 
        padding: 10px; 
   }
 
   
    /* 담당 회원 목록 스타일 */
    #trainerActions {
        /* 배경, 여백, 테두리 스타일 */
        background-color: #f9f9f9;
        border-top: 2px solid #dedede;
        padding: 15px;
    }
    #trainerActions h2 {
        /* 제목 스타일 */
        color: #333;
        font-size: 1.5em;
        margin-bottom: 10px;
    }
    #trainerActions ul {
        /* 목록 스타일 */
        list-style-type: none;
        padding: 0;
        margin: 0;
    }
    #trainerActions ul li {
        /* 목록 항목 스타일 */
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 10px;
        margin-bottom: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        transition: background-color 0.3s;
    }
    #trainerActions ul li:hover {
        /* 목록 항목 호버 스타일 */
        background-color: #e9e9e9;
    }
     
	   
	
</style>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	
	
	<div id="leftContainer">
		<ul>
	        <% 
	            String sql = "SELECT TRAINER_ID, NAME FROM TRAINERS WHERE TRAINER_ID != 1";
	            ResultSet rs = stmt.executeQuery(sql);
	            while (rs.next()) {
	            	int trainerId = rs.getInt("TRAINER_ID");
	                String name = rs.getString("NAME");
	        %>
	            <li><a href="?trainerId=<%= trainerId %>"><%= name %></a></li>
	              
	        <% 
	            }
	            rs.close();
	            stmt.close();
	        %>
	   </ul>


	</div>
	
	<div id="mainContainer">
		<div id="trainerDetail">
	  	<% 
            String selected = request.getParameter("trainerId");
            if (selected != null && !selected.isEmpty()) {
                stmt = conn.createStatement();
                sql = "SELECT NAME, BIRTHDATE, GENDER, CONTACT FROM TRAINERS WHERE TRAINER_ID = " + selected;
                rs = stmt.executeQuery(sql);
                if (rs.next()) {
                    String name = rs.getString("NAME");
                    Date birthdate = rs.getDate("BIRTHDATE");
                    String gender = rs.getString("GENDER");
                    String contact = rs.getString("CONTACT");
        %>
                    <p>이름: <%= name %></p>
                    <p>생년월일: <%= birthdate.toString() %></p>
                    <p>성별: <%= gender %></p>
                    <p>연락처: <%= contact %></p>
        <% 
                }
                rs.close();
                stmt.close();
            }
        %>
	    </div>
	    
	    <div id="trainerActions">
	        <% 
		        if (selected != null && !selected.isEmpty()) {
		            stmt = conn.createStatement();
		            sql = "SELECT MEMBER_ID, NAME, PHONE FROM MEMBERS WHERE TRAINER_ID = " + selected;
		            rs = stmt.executeQuery(sql);
		    %>
		    <h2>담당 회원 목록</h2>
		    <ul>
	        <%
	            while (rs.next()) {
	                int memberId = rs.getInt("MEMBER_ID");
	                String memberName = rs.getString("NAME");
	                String phone = rs.getString("PHONE");
	        %>
	                <li><%= memberId %>: <%= memberName %> (<%= phone %>)</li>
	        <%
	            }
	            rs.close();
	            stmt.close();
	        }
	        %>
    		</ul>
	    </div>
	</div>
    
</body>
</html>

<script>
     

</script>