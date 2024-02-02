<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	 /* 기본 바디 설정 */
   body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        display: flex;
        background-color: #f4f4f4; /* 전체 배경색 조정 */
    }

    /* 좌측 트레이너 목록 스타일 */
  	#leftContainer {
        width: 20%;
        background-color: #7ba4db; 
        color: white; 
        padding: 20px;
        height: 100vh;
        overflow-y: auto;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); 
    }
    #leftContainer a {
        color: white;
        text-decoration: none; 
        display: block;
        padding: 10px;
        margin-bottom: 5px; 
        transition: background-color 0.3s ease; 
    }
    #leftContainer a:hover {
        background-color: #6d97ca; 
        border-radius: 4px; 
    }
    
    #leftContainer li {
       list-style-type: none;
    }


    /* 주 컨테이너 스타일 */
    #mainContainer {
        width: 80%;
        background-color: #fff; 
        padding: 20px;
        overflow-y: auto;
    }

    /* 트레이너 상세 정보 스타일 */
    #trainerDetail {
        background-color: #fff;
        padding: 20px;
        border-bottom: 2px solid #eee; 
        margin-bottom: 20px;
    }

    table {
        width: 100%; 
        border-collapse: collapse; 
        margin-bottom: 20px;
    }
    table, th, td {
        border: 1px solid #ddd;
    }
    th, td {
        text-align: left; 
        padding: 8px; 
    }
    th {
        background-color: #f2f2f2;
        color: #333; 
    }
    tr:nth-child(even) {
        background-color: #f9f9f9; 
    }
    tr:hover {
        background-color: #e9e9e9; 
    }
    h1, h2, p {
        margin: 0;
        padding-bottom: 10px;
        color: #333;
    }
    h1 {
        font-size: 2em; 
    }
    h2 {
        font-size: 1.5em;
    }
    p {
        font-size: 1em; 
        color: #666; 
        list-style-type: none;
    }
    
 	/* 팝업창 스타일 */
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
	            sql = "SELECT MEMBER_ID, NAME, PHONE, GENDER, EXPIRATION_DATE, REMAINING_PT FROM MEMBERS WHERE TRAINER_ID = " + selected;
	            rs = stmt.executeQuery(sql);
		    %>
		    <h2>담당 회원 목록</h2>
		    <table>
	        <thead>
	            <tr>
	                <th>이름</th>
	                <th>연락처</th>
	                <th>성별</th>
	                <th>회원권 남은 기간</th>
	                <th>PT 남은 횟수</th>
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
	             <tr data-member-id="<%= memberId %>" onclick="showMemberDetails(this)">
                    <td><%= memberName %></td>
                    <td><%= phone %></td>
                    <td><%= gender %></td>
                    <td><%= remainingDays %>일</td>
                    <td><%= remainingPt %>회</td>
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
	        
	        <div id="popupOverlay" class="overlay" onclick="closePopup()"></div>
			<div id="popup" class="popup">
			    <h2>회원 PT 현황</h2>
			    <label for="datePicker">날짜 선택:</label>
			    <input type="date" id="datePicker">
			
			    <!-- 시간 선택 -->
			    <label for="hourSelect">시간 선택:</label>
			    <select id="hourSelect">
			        <!-- 시간 옵션들, JavaScript로 생성 -->
			    </select>
			
			    <!-- 예약 버튼 -->
			    <button type="button" onclick="submitReservation()">예약하기</button>
			    <button class="close-button" onclick="closePopup()">✖</button>
			    
			</div>
	    </div>
	</div>
    
</body>
</html>

<script>
	function showMemberDetails(element) {
	    var memberId = element.getAttribute("data-member-id");
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

    function submitReservation() {
        var date = document.getElementById('datePicker').value;
        var hour = document.getElementById('hourSelect').value;
        // 여기서 예약 처리 로직을 추가하세요.
        alert("예약 날짜: " + date + ", 시간: " + hour + "시");
    }
    
    
</script>