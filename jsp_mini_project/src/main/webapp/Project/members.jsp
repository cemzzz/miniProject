<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>

<!-- members.jsp -->
<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        /* 스타일링을 위한 예시 */
        .container {
            display: flex;
        }

        .sidebar {
            width: 250px;
            background-color: #f1f1f1;
            padding: 20px;
        }

        .main-content {
            flex: 1;
            padding: 20px;
        }

        /* 입력 폼 스타일링을 위한 예시 */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        /* 회원 리스트 테이블 스타일링 */
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        /* 성별 선택 목록 스타일링 */
        .form-group select {
            margin-top: 5px;
        }

        /* 등록 버튼 스타일링 */
        #registerBtn {
            background-color: #4caf50;
            color: white;
            padding: 10px;
            cursor: pointer;
            border: none;
        }
    </style>
</head>
<body>

    <%@ include file="dbconn.jsp"%>

    <!-- 전체 컨테이너 -->
    <div class="container">

        <!-- 좌측 영역 컨테이너 -->
        <div class="sidebar">
            <!-- 회원 정보 입력 폼 -->
            <div class="form-group">
            	<h2>회원 정보 입력</h2> <!-- 이 부분에 제목 추가 -->
                <label for="memberName">이름</label>
                <input type="text" id="memberName" name="memberName" required>
            </div>

            <div class="form-group">
	        	<label for="birthDate">생년월일</label>
	        <div style="display: flex; gap: 5px;">
	            <select id="birthYear" name="birthYear" required>
	                <% for (int year = 1900; year <= 2024; year++) { %>
	                    <option value="<%= year %>"><%= year %></option>
	                <% } %>
           		</select>
            	<select id="birthMonth" name="birthMonth" required>
                <% for (int month = 1; month <= 12; month++) { %>
                    <option value="<%= month %>"><%= month %></option>
                <% } %>
            	</select>
            	<select id="birthDay" name="birthDay" required>
                <% for (int day = 1; day <= 31; day++) { %>
                    <option value="<%= day %>"><%= day %></option>
                <% } %>
            	</select>
        	</div>
    	</div>

            <div class="form-group">
                <label for="gender">성별</label>
                <select id="gender" name="gender" required>
                    <option value="male">남성</option>
                    <option value="female">여성</option>
                </select>
            </div>

            <div class="form-group">
                <label for="phoneNumber">핸드폰 번호</label>
                <input type="text" id="phoneNumber" name="phoneNumber" required>
            </div>
            
             <div class="form-group">
        		<label for="membershipPeriod">회원권 구매</label>
        		<select id="membershipPeriod" name="membershipPeriod">
            		<option value="90">90일</option>
           			<option value="180">180일</option>
            		<option value="270">270일</option>
            		<option value="360">360일</option>
        		</select>
    		</div>
    		
    		<div class="form-group">
        		<label for="ptTicket">PT 이용권 구매</label>
        		<select id="ptTicket" name="ptTicket">
            		<option value="10">10회</option>
           			<option value="15">15회</option>
            		<option value="20">20회</option>
            		<option value="25">25회</option>
            		<option value="30">30회</option>
        		</select>
    		</div>
    		
    		<div class="form-group">
			    <label for="trainer">담당 트레이너</label>
			    <select id="trainer" name="trainer" required>
			        <%
			            // 데이터베이스에서 트레이너 목록을 가져오는 SQL 쿼리
			            String trainerQuery = "SELECT * FROM TRAINERS";
			            ResultSet trainerRs = stmt.executeQuery(trainerQuery);
			
			            // 트레이너 목록을 드롭다운 메뉴로 표시
			        %>
			        		<option value="">--</option>			        
			        <% 
			            while (trainerRs.next()) {
			        %>
			                <option value="<%= trainerRs.getInt("TRAINER_ID") %>">
			                    <%= trainerRs.getString("NAME") %>
			                </option>
			        <%
			            }
			            trainerRs.close(); // 리소스 닫기
			        %>
			    </select>
			     <input type="hidden" id="trainerId" name="trainerId" value="">
			</div>
					<button id="registerBtn" onclick="registerMember()">등록</button>
					
			
        </div>

          <!-- 중앙 영역 컨테이너 -->
        <div class="main-content">
            <!-- 회원 리스트를 HTML로 표시 -->
            <h2>회원 리스트</h2>
            <table border="1">
                <tr>
                    <th>이름</th>
                    <th>생년월일</th>
                    <th>성별</th>
                    <th>핸드폰 번호</th>
                    <th>구매일</th>
                    <th>회원권 남은 기간</th>
					<th>남은 PT 횟수</th>
					<th>회원권 이용 상태</th>
					<th>담당 트레이너</th>
					<th>회원권 만료일</th>      
                </tr>

                <!-- 데이터베이스 조회 및 표시 부분 여기에 추가 -->
                <%
                    // 데이터베이스 조회
                    String query = "SELECT MEMBERS.*, TRAINERS.NAME AS TRAINER_NAME FROM MEMBERS LEFT JOIN TRAINERS ON MEMBERS.TRAINER_ID = TRAINERS.TRAINER_ID";
    				ResultSet resultSet = stmt.executeQuery(query);
    				
                    while (resultSet.next()) {
                %>
                    <tr>
                        <td><%= resultSet.getString("NAME") %></td>
                        <td><%= resultSet.getDate("BIRTHDATE") %></td>
                        <td><%= resultSet.getString("GENDER").equals("M") ? "남성" : "여성" %></td>
                        <td><%= resultSet.getString("PHONE") %></td>
                        <td><%= resultSet.getDate("PURCHASE_DATE") %></td>
                        <td><%= resultSet.getInt("REMAINING_PLAN") %>일</td>
                        <td><%= resultSet.getInt("REMAINING_PT") %>회</td>
                        <td><%= resultSet.getBoolean("PAUSED") ? "일시정지" : "이용 가능" %></td>
                        <td><%= resultSet.getString("TRAINER_NAME") %></td>
                        <td><%= resultSet.getDate("EXPIRATION_DATE") %></td>
                    </tr>
                <%
                    }

                    // 리소스 닫기 
                    resultSet.close();
                %>
            </table>
        </div>
    </div>

    <script>
    	 function registerMember() {
    		 var memberName = document.getElementById("memberName").value;
    	        var birthYear = document.getElementById("birthYear").value;
    	        var birthMonth = document.getElementById("birthMonth").value;
    	        var birthDay = document.getElementById("birthDay").value;
    	        var gender = document.getElementById("gender").value;
    	        var phoneNumber = document.getElementById("phoneNumber").value;
    	        var membershipPeriod = document.getElementById("membershipPeriod").value;
    	        var ptTicket = document.getElementById("ptTicket").value;
    	        var trainerId = document.getElementById("trainer").value;

    	        // 날짜 형식 조합
    	        var birthDate = birthYear + "-" + birthMonth + "-" + birthDay;
        		var purchaseDate = new Date().toISOString().split('T')[0]; // 현재 날짜를 yyyy-MM-dd 형식으로 가져옴

    	        // URL에 전달할 링크 생성
    	        var url = "members_save.jsp?" +
    	            "name=" + encodeURIComponent(memberName) +
    	            "&birthDate=" + encodeURIComponent(birthDate) +
    	            "&gender=" + encodeURIComponent(gender) +
    	            "&phone=" + encodeURIComponent(phoneNumber) +
    	            "&membershipPeriod=" + encodeURIComponent(membershipPeriod) +
    	            "&ptTicket=" + encodeURIComponent(ptTicket) +
    	            "&trainerId=" + encodeURIComponent(trainerId);

    	        // URL로 이동
    	        location.href = url;
    	}  
    	
    </script>

</body>
</html>
