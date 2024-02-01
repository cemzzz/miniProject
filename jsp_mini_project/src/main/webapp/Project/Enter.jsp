<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멀티플렉스짐</title>
    <style>
        body {
            font-family: Arial, sans-serif;
	        margin: 0;
	        padding: 0;
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        height: 100vh;
	        background-color: #f4f4f4;
	        background-image: url('roni.jpg'); /* 배경 이미지 URL 추가 */
	        background-size: contain; /* 이미지가 너무 크지 않게 조정 */
		    background-repeat: no-repeat;
		    background-position: center; /* 이미지를 중앙에 배치 */

        }

        .container {
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
        }

        input {
            padding: 10px;
            margin-top: 10px;
            width: 200px;
            font-size: 16px;
        }

        .number-buttons {
            margin-top: 10px;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 5px;
        }

        .number-button, .backspace-button, .admin-button, .enter-button {
            padding: 20px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
            color: white;
        }

        .number-button {
            background-color: #4CAF50;
        }

        .backspace-button {
            background-color: #ff6347;
        }

        .admin-button {
            background-color: #333;
        }

        .enter-button {
            background-color: #3498db;
            grid-column: span 3;
        }

        #registerNumberLabel {
            font-size: 14px;
            color: #777;
        }

        /* 추가된 스타일: 팝업 스타일 */
        .popup {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .popup-content {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative; /* 부모 기준으로 자식의 위치를 지정하기 위해 추가 */
            max-width: 300px; /* 팝업 최대 너비 지정 */
            margin: 0 auto; /* 가운데 정렬 */
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

        /* 추가된 스타일: 로그인 폼 스타일 */
        .login-form {
            margin-top: 20px;
        }

        .login-input {
            padding: 10px;
            margin-top: 10px;
            width: calc(100% - 20px); /* 왼쪽, 오른쪽 padding 10px 제외한 너비 */
            font-size: 16px;
        }

        .login-button {
            padding: 10px;
            margin-top: 20px;
            width: 100%;
            font-size: 16px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
	
    <div class="container">
        <h1>멀티플렉스짐</h1>
        <label id="registerNumberLabel">회원등록번호 4자리 입력해주세요</label>
        <br>
        <input type="text" maxlength="4" placeholder="4자리 입력" id="registerNumberInput">
        <div class="number-buttons">
            <!-- 수정된 숫자 버튼, 백스페이스 버튼, 관리자 버튼, 그리고 입장 버튼 배치 -->
            <button class="number-button" onclick="addNumber(1)">1</button>
            <button class="number-button" onclick="addNumber(2)">2</button>
            <button class="number-button" onclick="addNumber(3)">3</button>
            <button class="number-button" onclick="addNumber(4)">4</button>
            <button class="number-button" onclick="addNumber(5)">5</button>
            <button class="number-button" onclick="addNumber(6)">6</button>
            <button class="number-button" onclick="addNumber(7)">7</button>
            <button class="number-button" onclick="addNumber(8)">8</button>
            <button class="number-button" onclick="addNumber(9)">9</button>
            <button class="admin-button" onclick="openAdminPanel()">관리자</button>
            <button class="backspace-button" onclick="backspace()">⌫</button>
            <button class="number-button" onclick="addNumber(0)">0</button>
            <button class="enter-button" onclick="enter()">입장</button>
        </div>
    </div>

    <!-- 추가된 팝업 영역 -->
    <div id="adminPopup" class="popup">
        <div class="popup-content">
            <button class="close-button" onclick="closeAdminPanel()">✖</button>
            <h2>관리자 로그인</h2>
            <!-- 추가된 로그인 폼 -->
            <form class="login-form" action="admin_login.jsp" method="POST">
			    <input type="text" placeholder="아이디" class="login-input" name="adminId">
			    <input type="password" placeholder="비밀번호" class="login-input" name="adminPassword">
			    <button type="submit" class="login-button">로그인</button>
			</form>
        </div>
    </div>

    <script>
        // 숫자 버튼을 누를 때 호출되는 함수
        function addNumber(number) {
            var registerNumberInput = document.getElementById('registerNumberInput');
            if (registerNumberInput.value.length < 4) {
                registerNumberInput.value += number;
            }
        }

        // 백스페이스 버튼을 누를 때 호출되는 함수
        function backspace() {
            var registerNumberInput = document.getElementById('registerNumberInput');
            registerNumberInput.value = registerNumberInput.value.slice(0, -1);
        }

        // 관리자 버튼을 누를 때 호출되는 함수
        function openAdminPanel() {
            var adminPopup = document.getElementById('adminPopup');
            adminPopup.style.display = 'flex';
        }

        // 팝업 닫기 함수
        function closeAdminPanel() {
            var adminPopup = document.getElementById('adminPopup');
            adminPopup.style.display = 'none';
        }
        

        function enter() {
            var registerNumberInput = document.getElementById('registerNumberInput');
            if (registerNumberInput.value.length === 4) {
                alert('입장 로직을 추가하세요.');
            } else {
                alert('4자리를 입력해주세요.');
            }
        }
    </script>

</body>
</html>
