<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>회원 관리 시스템</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 10px;
        }

        .form-container, .list-container {
            background-color: white;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin: 10px;
        }

        .form-container {
            width: 25%;
        }

        .list-container {
            width: 75%;
        }

        h2 {
            text-align: center;
            color: #4CAF50;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        .birthdate-section label {
		    display: block; /* 라벨을 블록 요소로 설정 */
		    font-weight: bold;
		    margin-bottom: 5px;
		}

		.birthdate-group {
		    display: flex; /* 항목들을 가로로 나열 */
		    justify-content: flex-start;
		}

		.birthdate-group select {
		    flex-basis: 30%; /* 각 드롭다운의 기본 크기 설정 */
		    margin-right: 22px; /* 드롭다운 간의 여백 */
		    padding: 8px;
		    border-radius: 4px;
		    border: 1px solid #ccc;
		}

		.birthdate-group select:last-child {
		    margin-right: 0; /* 마지막 드롭다운의 오른쪽 여백 제거 */
		}

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #5C6BC0;
            border: none;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        input[type="button"] {
        	margin-top : 10px;
            width: 100%;
            padding: 10px;
            background-color: #5C6BC0;
            border: none;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        input[type="submit"]:hover {
            background-color: #3F51B5;
        }

        table {
            width: 100%;
            border-collapse: collapse;
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

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                align-items: center;
            }

            .form-container, .list-container {
                width: 100%;
            }
        }
        
        .search-container {
	        display: flex;
	        align-items: center;
	        width : 500px
	    }
	
	    .search-input {
	        width: 100%;
	        padding: 8px; 
	        margin-right: 5px; 
	    }
	
	    .search-button {
	        width: 80px; 
	        padding: 8px; 
	        background-color: #4CAF50; 
	        color: white; 
	        border: none; 
	        border-radius: 4px; 
	        cursor: pointer; 
	    }
	
	    .search-button:hover {
	        background-color: #45a049;
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
	
	            <div class="birthdate-section">
			    <label>생년월일:</label>
				    <div class="birthdate-group">
				        <select id="birthYear" name="birthYear" required>
				            <% for (int i = 1920; i <= 2020; i++) { %>
				                <option value="<%= i %>" <%= i == 1980 ? "selected" : "" %>><%= i %></option>
				            <% } %>
				        </select>
				        <select id="birthMonth" name="birthMonth" required>
				            <% for (int i = 1; i <= 12; i++) { %>
				                <option value="<%= i %>"><%= i %></option>
				            <% } %>
				        </select>
				        <select id="birthDay" name="birthDay" required>
				            <% for (int i = 1; i <= 31; i++) { %>
				                <option value="<%= i %>"><%= i %></option>
				            <% } %>
				        </select>
				    </div>
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
	        
	    	<form action="members.jsp" method="GET">
			    <div class="search-container">
			        <input type="text" name="searchName" placeholder="이름으로 검색" class="search-input">
			        <button type="submit" class="search-button">검색</button>
			    </div>
			</form>
			
	    
			<table border="1">
			    <tr>
			    	<!-- <th>번호</th> -->
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
				    String searchName = request.getParameter("searchName");
				    String sql;
	
				    if(searchName != null && !searchName.isEmpty()) {
				        // 검색 로직
				        sql = "SELECT m.MEMBER_ID, m.NAME, m.BIRTHDATE, m.GENDER, m.PHONE, m.PURCHASE_DATE, m.REMAINING_PLAN, m.REMAINING_PT, m.PAUSED, t.NAME AS TRAINER_NAME, m.EXPIRATION_DATE FROM MEMBERS m LEFT JOIN TRAINERS t ON m.TRAINER_ID = t.TRAINER_ID WHERE m.NAME LIKE '%" + searchName + "%'";
				    } else {
				        // 기존 회원 리스트 표시 로직
				        sql = "SELECT m.MEMBER_ID, m.NAME, m.BIRTHDATE, m.GENDER, m.PHONE, m.PURCHASE_DATE, m.REMAINING_PLAN, m.REMAINING_PT, m.PAUSED, t.NAME AS TRAINER_NAME, m.EXPIRATION_DATE FROM MEMBERS m LEFT JOIN TRAINERS t ON m.TRAINER_ID = t.TRAINER_ID";
				    }
				    
				    ResultSet rs = stmt.executeQuery(sql);
			
			        while (rs.next()) {
			        	 String memberId = rs.getString("MEMBER_ID");
	                     String memberName = rs.getString("NAME");
	                     String gender = rs.getString("GENDER").trim();
	                     String genderDisplay = "M".equals(gender) ? "남성" : "여성";
	                     boolean isPaused = rs.getInt("PAUSED") == 0;
	                     String pausedDisplay = isPaused ? "정지" : "이용중";
	                     String trainerName = rs.getString("TRAINER_NAME") != null ? rs.getString("TRAINER_NAME") : "미정";

	                     Date purchaseDate = rs.getDate("PURCHASE_DATE");
	                     int remainingPlan = rs.getInt("REMAINING_PLAN");
	                     long remainingDays = remainingPlan; // 남은 기간 초기화
	                        
	                     // 회원권 상태가 중지가 아닐 때만 남은 기간 계산
	                     if (!isPaused) {
	                         long millis = System.currentTimeMillis();
	                         long elapsedDays = (millis - purchaseDate.getTime()) / (24 * 60 * 60 * 1000);
	                         remainingDays = Math.max(0, remainingPlan - elapsedDays);	
			        	 
				    	}
			    %>
			    <tr> 
			    	<%-- <td onclick="showMemberDetails('<%= memberId %>')"><%= memberId %></td> --%>
        			<td onclick="showMemberDetails('<%= memberId %>')"><%= memberName %></td> 
			       <%--  <td><%= rs.getString("MEMBER_ID") %></td>
			        <td><%= rs.getString("NAME") %></td> --%>
			        <td><%= rs.getDate("BIRTHDATE") %></td>
			        <td><%= genderDisplay %></td>
			        <td><%= rs.getString("PHONE") %></td>
			        <td><%= rs.getDate("PURCHASE_DATE") %></td>
			        <td><%= remainingDays %>일</td>
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
<script>
	function showMemberDetails(memberId) {
	    var url = "memberDetails.jsp?memberId=" + memberId;
	    window.open(url, "Member Details", "width=600,height=800");
	}

</script>