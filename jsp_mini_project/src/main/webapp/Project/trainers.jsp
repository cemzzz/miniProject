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
            margin: 0;
            padding: 0;
            display: flex;
            background-color: #f4f4f4;
        }

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

        #trainerDetails, #trainerList {
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin: 10px;
        padding: 20px;
	    }
	
	    #trainerDetails h2, #trainerList h2 {
	        font-size: 1.4em;
	        color: #333;
	        margin-bottom: 15px;
	    }
	
	    #trainerDetails p, #trainerList li {
	        font-size: 1em;
	        color: #666;
	    }
	
	    #trainerList ul {
	        list-style: none;
	        padding: 0;
	    }
	
	    #trainerList li {
	        padding: 5px 0;
	        border-bottom: 1px solid #eee;
	    }
	
	    #trainerList li a {
	        text-decoration: none;
	        color: #007bff;
	        transition: color 0.3s ease;
	    }
	
	    #trainerList li a:hover {
	        color: #0056b3;
	    }
	    
	    #mainContainer {
		    display: flex;
		    width: 100%;
		    justify-content: space-between; /* 좌우 컨테이너 간격을 균등하게 분배 */
		}
		
		#ptList, #trainerActions {
		    width: 48%; /* 각 컨테이너의 너비를 약 50%로 설정 */
		    padding: 10px;
		    box-sizing: border-box; /* 패딩을 포함한 너비 계산 */
		}

         table {
	        width: 100%;
	        border-collapse: collapse;
	        margin-bottom: 20px;
	    }
	
	    th, td {
	        border: 1px solid #ddd;
	        text-align: left;
	        padding: 8px;
	    }
	
	    th {
	        background-color: #4CAF50;
	        color: white;
	    }
	
	    tr:nth-child(even) {
	        background-color: #f9f9f9;
	    }
	
	    tr:hover {
	        background-color: #e9e9e9;
	    }
	
	    h2 {
	        color: #333;
	        font-size: 1.5em;
	        margin-bottom: 10px;
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
	     
	</style>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	
	<div id="leftContainer">
	   	<div id="trainerDetails">
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
	
	
	<div id="mainContainer">

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
	        
		<div id="ptList">
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
			            <h3>PT 예약 내역</h3>
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