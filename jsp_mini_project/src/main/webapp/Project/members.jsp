<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>회원 관리 시스템</title>
    <style>
        .container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        .form-container {
            width: 30%;
            margin-right: 5%;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .list-container {
            width: 65%;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
            box-shadow: 0 2px 3px rgba(0, 0, 0, 0.1);
        }

        th, td {
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            margin-bottom: 20px;
        }

        .form-container h2 {
            text-align: center;
            color: #333;
        }

        .form-container form {
            display: grid;
            grid-gap: 20px;
        }

        .form-container label {
            font-weight: bold;
            color: #555;
        }

        .form-container input[type="text"],
        .form-container input[type="date"],
        .form-container select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
        }

        .form-container input[type="submit"] {
            background-color: #5C6BC0;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .form-container input[type="submit"]:hover {
            background-color: #3F51B5;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                align-items: center;
            }
        }
 
        .birthdate-group {
            display: flex; /* 이를 통해 항목들을 가로로 나열합니다. */
            align-items: center; /* 항목들을 세로 중앙에 배치합니다. */
        }

        .birthdate-group label,
        .birthdate-group select {
            margin-right: 10px; /* 라벨과 셀렉트 박스 사이의 간격을 설정합니다. */
            /* font-size: 0.9rem; /* 폰트 사이즈를 줄여 드롭다운을 더 작게 만듭니다. */ */
        }

        .birthdate-group select {
            width: auto; /* 드롭다운 너비를 내용에 맞게 자동 조정합니다. */
            padding: 5px; /* 드롭다운 내부 패딩을 줄여 크기를 감소시킵니다. */
        }
    </style>
</head>
<body>
	<%@ include file="dbconn.jsp" %>

	<div class="container">
	    <div class="form-container">
	        <h2>회원 등록</h2>
	        <form action="members_save.jsp" method="post">
	            <label for="name">이름:</label>
	            <input type="text" id="name" name="name" required><br>
	
	            <div class="birthdate-group">
		            <label for="birthYear">생년:</label>
		            <select id="birthYear" name="birthYear" required>
		                <% for (int i = 1900; i <= 2020; i++) { %>
		                    <option value="<%= i %>"><%= i %></option>
		                <% } %>
		            </select>

		            <label for="birthMonth">월:</label>
		            <select id="birthMonth" name="birthMonth" required>
		                <% for (int i = 1; i <= 12; i++) { %>
		                    <option value="<%= i %>"><%= i %></option>
		                <% } %>
		            </select>

		            <label for="birthDay">일:</label>
		            <select id="birthDay" name="birthDay" required>
		                <% for (int i = 1; i <= 31; i++) { %>
		                    <option value="<%= i %>"><%= i %></option>
		                <% } %>
		            </select>
	        	</div>
        
	            <label for="gender">성별:</label>
	            <select id="gender" name="gender" required>
	                <option value="M">남성</option>
	                <option value="F">여성</option>
	            </select><br>
	
	            <label for="phone">연락처:</label>
	            <input type="text" id="phone" name="phone" required><br>
	
	            <!-- 회원권 구매 옵션 -->
		        <label for="membershipPlan">회원권 구매:</label>
		        <select id="membershipPlan" name="membershipPlan" required>
		            <% 
		                String plansQuery = "SELECT * FROM PLANS";
		                ResultSet planOptions = stmt.executeQuery(plansQuery);
		                while (planOptions.next()) {
		                    String planId = planOptions.getString("PLAN_ID");
		                    String DURATION = planOptions.getString("DURATION");
		                    String PRICE = planOptions.getString("PRICE");
		            %>
		            <option value="<%= planId %>"><%= DURATION %>일, <%= PRICE %>원</option>
		            <% 
		                }
		            %>
		        </select>
		
		        <!-- PT 구매 옵션 -->
		        <label for="ptSessions">PT 구매:</label>
		        <select id="ptSessions" name="ptSessions" required>
		            <% 
		                String ptSessionsQuery = "SELECT * FROM PTSESSIONS";
		                ResultSet ptSessionOptions = stmt.executeQuery(ptSessionsQuery);
		                while (ptSessionOptions.next()) {
		                    String ptId = ptSessionOptions.getString("PT_ID");
		                    String sessions = ptSessionOptions.getString("SESSIONS");
		                    String ptPrice = ptSessionOptions.getString("PRICE");
		            %>
		            <option value="<%= ptId %>"><%= sessions %>회, <%= ptPrice %>원</option>
		            <% 
		                }
		            %>
		        </select>
		        
		        <!-- 담당 트레이너 선택 -->
		        <label for="trainer">담당 트레이너:</label>
		        <select id="trainer" name="trainer" required>
		            <% 
		                // 데이터베이스에서 트레이너 목록 조회
		                String trainerQuery = "SELECT * FROM TRAINERS";
		                ResultSet trainers = stmt.executeQuery(trainerQuery);
		                while (trainers.next()) {
		                    String trainerId = trainers.getString("TRAINER_ID");
		                    String trainerName = trainers.getString("NAME");
		            %>
		            <option value="<%= trainerId %>"><%= trainerName %></option>
		            <% 
		                }
		            %>
		        </select> 
	
	            <input type="submit" value="회원 등록">
	        </form>
	    </div>
	
	    <div class="list-container">
	        <h2>회원 리스트</h2>
			<table border="1">
			    <tr>
			    	<th>번호</th>
				   	<th>회원 이름</th>
				    <th>생년월일</th>
				    <th>성별</th>
				    <th>연락처</th>
				    <th>회원권 구매일</th>
				    <th>남은 기간</th>
				    <th>PT 남은 횟수</th>
				    <th>회원권 상태</th>
				    <th>담당 트레이너</th>
				    <th>회원권 만료일</th>
			    </tr>
			    <%
			    String sql = "SELECT m.MEMBER_ID, m.NAME, m.BIRTHDATE, m.GENDER, m.PHONE, m.PURCHASE_DATE, m.REMAINING_PLAN, m.REMAINING_PT, m.PAUSED, t.NAME AS TRAINER_NAME, m.EXPIRATION_DATE FROM MEMBERS m LEFT JOIN TRAINERS t ON m.TRAINER_ID = t.TRAINER_ID";
			        ResultSet rs = stmt.executeQuery(sql);
			
			        while (rs.next()) {
			        	 String gender = rs.getString("GENDER");
			             String genderDisplay = "M".equals(gender) ? "남성" : "여성";
			             String pausedDisplay = rs.getBoolean("PAUSED") ? "이용중" : "정지";
			             String trainerName = rs.getString("TRAINER_NAME");
			    %>
			    <tr>
			        <td><%= rs.getString("MEMBER_ID") %></td>
			        <td><%= rs.getString("NAME") %></td>
			        <td><%= rs.getDate("BIRTHDATE") %></td>
			        <td><%= genderDisplay %></td>
			        <td><%= rs.getString("PHONE") %></td>
			        <td><%= rs.getDate("PURCHASE_DATE") %></td>
			        <td><%= rs.getInt("REMAINING_PLAN") %>일</td>
			        <td><%= rs.getInt("REMAINING_PT") %>회</td>
			        <td><%= pausedDisplay %></td>
			        <td><%= trainerName != null ? trainerName : "미정" %></td> <!-- 트레이너 이름 표시 -->
        			<td><%= rs.getDate("EXPIRATION_DATE") %></td>
			    </tr>
			    <%
			        }
			        rs.close();
			        stmt.close();
			    %>
			</table>
	    </div>
	</div>

</body>
</html>
