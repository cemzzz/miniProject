<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
		font-family: 'Arial', sans-serif;
        background-color: #f7f7f7; 
        color: #333; 
        line-height: 1.6;
        margin: 0;
        padding: 0;
    }
    
    .container {
        display: flex;
        justify-content: center;
        margin: 20px;
    }
    
    .side, .center-left, .main {
        background: #fff; 
        padding: 20px;
        margin: 10px;
        border-radius: 8px; 
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); 
    }

    .side {
        flex: 1;
        max-width: 300px;
    }

    .center-left {
        flex: 2;
        max-width: 600px;
    }

    .main {
        flex: 3;
        max-width: 800px;
    }

    #trainerDetails, #trainerList {
        margin-bottom: 20px; /
        height: 400px; 
        overflow-y: auto; 
    }

    #trainerActions, #ptList {
        height: 400px; 
        overflow-y: auto; 
    }
    
        h1, h2, h3 {
        color: #007bff; 
    }

    a {
        color: #007bff;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    /* 버튼 및 입력 필드 스타일 */
    button, input[type="date"], select {
        font: inherit;
        border: 1px solid #ddd;
        padding: 10px 15px;
        border-radius: 4px;
        margin: 5px 0;
        transition: all 0.3s ease;
    }

    button:hover, input[type="date"]:hover, select:hover {
        border-color: #007bff;
        cursor: pointer;
    }

    /* 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th, td {
        text-align: left;
        padding: 8px;
    }

    th {
        background-color: #f9f9f9;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #eef;
    }
    
    li{
    	list-style-type: none;
    	
    }	   
	.popup {
	 	display: none;
	    position: fixed;
	    left: 50%;
	    top: 50%;
	    transform: translate(-50%, -50%);
	    border: 1px solid #ddd;
	    background-color: white;
	    padding: 20px;
	    z-index: 1000;
	}
	
	.overlay {
		display: none;
	    position: fixed;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    background-color: rgba(0, 0, 0, 0.5);
	    z-index: 999;
	}
	
	.close-button {
	    position: absolute;
	    top: 10px;
	    right: 10px;
	    cursor: pointer;
	    font-size: 20px;
	    color: #555;
	    background: none;
	    border: none;
	}

    button, input[type="date"], select {
    	border: 1px solid #ddd;
        padding: 8px;
        border-radius: 4px;
        margin: 5px 0;
        transition: all 0.3s ease;
    }

    button:hover, input[type="date"]:hover, select:hover {
    	border-color: #7ba4db;
    }
    
    input[type="text"] {
    	width: 90%;
        padding: 8px;
        margin-bottom: 10px;
        border-radius: 4px;
        border: 1px solid #ccc;
    }
    
    select {
    	width: 30%;
        padding: 8px;
        margin-bottom: 10px;
        border-radius: 4px;
        border: 1px solid #ccc;
    }
	     
	</style>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<div class="container">
		<div class="side">
       		<h2> 트레이너 등록 </h2>
       		<form>
       			<label for="name">이름:</label>
	            <input type="text" id="name" name="name" required>
	            
	            	
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
				
				<div>
					<label for="gender">성별:</label>
		            <select id="gender" name="gender" required>
		                <option value="M">남성</option>
		                <option value="F">여성</option>
		            </select>				
				</div>
				
				<div>
		            <label for="phone">연락처:</label>
		            <input type="text" id="phone" name="phone" required>				
				</div>
	
	            
       		</form>
    	</div>
		<div class="center-left">
			<div id="trainerDetails">
				<h2>트레이너 상세 정보</h2>
		        <% 
		        String selected = request.getParameter("trainerId");
		        if (selected != null && !selected.isEmpty()) {
		            stmt = conn.createStatement();
		            String sql = "SELECT NAME, BIRTHDATE, GENDER, CONTACT FROM TRAINERS WHERE TRAINER_ID = " + selected;
		            ResultSet rs = stmt.executeQuery(sql);
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
		            // rs.close();
		            // stmt.close();
		        }
		        %>
		    </div>
	
		    <div id="trainerList">
		    	<h3>트레이너 선생님</h3>
		        <ul>
		        <% 
		        // Ensure that the statement is recreated or use a different statement variable if it's closed in the above block
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
	    </div>
		<div class="main">
		    <div id="trainerActions">
			    <h2>담당 회원 목록</h2>
		        <% 
		        if (selected != null && !selected.isEmpty()) {
		            stmt = conn.createStatement();
		            sql = "SELECT MEMBER_ID, NAME, PHONE, GENDER, EXPIRATION_DATE, REMAINING_PT FROM MEMBERS WHERE TRAINER_ID = " + selected;
		            rs = stmt.executeQuery(sql);
			    %>
				    <table>
			        <thead>
			            <tr>
			                <th>이름</th>
			                <th>연락처</th>
			                <th>성별</th>
			                <th>회원권 남은 기간</th>
			                <th>PT 남은 횟수</th>
			                <th>예약하기</th>
			            </tr>
			        </thead>
			        <tbody>
		        <%
			        while (rs.next()) {
						String memberId = rs.getString("MEMBER_ID");
		                String memberName = rs.getString("NAME");
		                String phone = rs.getString("PHONE");
		                String genderCode = rs.getString("GENDER");
	                    String gender = "M".equals(genderCode) ? "남자" : ("F".equals(genderCode) ? "여성" : "기타");
		                Date expirationDate = rs.getDate("EXPIRATION_DATE");
		                int remainingPt = rs.getInt("REMAINING_PT");
		
		                // 회원권 남은 기간 계산
		                long millis = System.currentTimeMillis();
		                Date today = new Date(millis);
		                long remainingDays = (expirationDate.getTime() - today.getTime()) / (24 * 60 * 60 * 1000);     
		        %>
		             <tr onclick="loadMemberReservations('<%= memberId %>')">
	                    <td><%= memberName %></td>
	                    <td><%= phone %></td>
	                    <td><%= gender %></td>
	                    <td><%= remainingDays %>일</td>
	                    <td><%= remainingPt %>회</td>
	                    <td>
	                    	<button type="button" onclick="showReservationPopup(event, '<%= memberId %>')">예약하기</button>
	                	</td>
	                </tr>
		        <%
			    	}
		        %>
		           </tbody>
	    		</table>
	 
		        <%
		            rs.close();
		            stmt.close();
		        }
		        %>
		    </div>   
			<div id="ptList">
				<h3>PT 예약 내역</h3>
				<%
					String selectedMemberId = request.getParameter("memberId"); // 새로 추가된 회원 ID 파라미터
				    if (selected != null && !selected.isEmpty()) {
				        // 트레이너별 회원 목록 조회
				        stmt = conn.createStatement();
				        sql = "SELECT MEMBER_ID, NAME, PHONE, GENDER, EXPIRATION_DATE, REMAINING_PT FROM MEMBERS WHERE TRAINER_ID = " + selected;
				        rs = stmt.executeQuery(sql);
		
				        // 선택된 회원의 PT 예약 내역 조회
				        if (selectedMemberId != null && !selectedMemberId.isEmpty()) {
				            Statement stmtReservations = conn.createStatement();
				            String sqlReservations = "SELECT RECORD_ID, RESERVATION_TIME FROM RESERVATIONRECORDS WHERE MEMBER_ID = '" + selectedMemberId + "'";
				            ResultSet rsReservations = stmtReservations.executeQuery(sqlReservations);
		
				            boolean hasReservations = false;
				            %>
				            <ul>
				            <% 
				            while (rsReservations.next()) {
				                hasReservations = true;
				                Timestamp reservationTime = rsReservations.getTimestamp("RESERVATION_TIME");
				                int recordId = rsReservations.getInt("RECORD_ID");
				                String formattedTime = new SimpleDateFormat("yyyy/MM/dd HH:mm").format(reservationTime);
				            %>
				                <li>
				                    <%= formattedTime %> 
				                    <input type="button" value="예약 취소" onclick="cancelReservation('<%= recordId %>')">
				                </li>
				            <%
				            }
				            if (!hasReservations) {
				                out.println("<li>예약된 PT가 없습니다</li>");
				            }
				            rsReservations.close();
				            stmtReservations.close();
				            %>
				            </ul>
				            <%
				        }
				        rs.close();
				        stmt.close();
				    }
				%>
			</div>
		    <div id="popupOverlay" class="overlay" onclick="closePopup()"></div>
		    <div id="popup" class="popup">
				<form id="reservationForm" method="post" action="reservePT.jsp">
					<h2>회원 PT 현황</h2>
					<label for="datePicker">날짜 선택:</label>
				    <input type="date" id="datePicker" name="date">
					    
					<label for="hourSelect">시간 선택:</label>
					<select id="hourSelect" name="hour"></select>
					    
					    
					<input type="hidden" id="memberId" name="memberId" value="">
					<button type="submit">예약하기</button>
					<button type="button" class="close-button" onclick="closePopup()">✖</button>
				</form>
			</div>
		    
		</div>
	</div>
    
</body>
</html>

<script>
	function showReservationPopup(event,memberId) {
		event.stopPropagation();
		document.getElementById("memberId").value = memberId;
	    document.getElementById("popup").style.display = "block";
	    document.getElementById("popupOverlay").style.display = "block";
	}

    function closePopup() {
        document.getElementById("popup").style.display = "none";
        document.getElementById("popupOverlay").style.display = "none";
    }
    
    window.onload = function() {
        // 시간 드롭박스를 위한 옵션 생성
        var hourSelect = document.getElementById('hourSelect');
        for (var i = 9; i <= 23; i++) {
            var option = document.createElement('option');
            option.value = i;
            option.text = i + '시';
            hourSelect.appendChild(option);
        }
    };
    
    function loadMemberReservations(memberId) {
        window.location.href = 'trainers.jsp?trainerId=' + '<%= selected %>' + '&memberId=' + memberId;
    }
    
    function cancelReservation(recordId) {
        if (confirm("이 예약을 취소하시겠습니까?")) {
            window.location.href = 'cancelReservation.jsp?recordId=' + recordId;
        }
    }
    

</script>