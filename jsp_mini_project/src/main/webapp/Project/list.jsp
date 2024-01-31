<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- list.jsp -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
        }

        /* 좌측 메뉴 컨테이너 스타일 */
        .menu-container {
            width: 200px;
            background-color: #333;
            color: white;
            padding: 20px;
            box-sizing: border-box;
        }

        /* 중앙 컨테이너 스타일 */
                .main-container {
            flex: 1;
            display: flex;
            padding: 20px;
            box-sizing: border-box;
            width: calc(100% - 200px); /* 좌측 메뉴의 넓이를 제외한 크기로 조절 */
            overflow: auto; /* 스크롤 추가 */
        }

        /* 추가된 스타일 부분 */
        .main-container iframe {
            width: 100%; /* iframe이 부모 너비를 100%로 사용하도록 설정 */
            height: 100vh; /* iframe이 전체 화면 높이를 사용하도록 설정 */
            border: none; /* iframe 테두리 제거 */
        }
        
        

        /* 좌측 메뉴 항목 스타일 */
        .menu-item {
            margin-bottom: 10px;
            padding: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        /* 좌측 메뉴 항목에 호버 효과 스타일 */
        .menu-item:hover {
            background-color: #555;
        }

        /* 중앙 컨테이너 좌측에 회원 정보 입력 영역 스타일 */
        .input-area {
            width: 300px;
            padding: 20px;
            box-sizing: border-box;
            background-color: #f0f0f0;
            margin-right: 20px;
        }

        .input-area h2 {
            margin-bottom: 20px;
        }

        .input-area label {
            display: block;
            margin-bottom: 10px;
        }

        .input-area input,
        .input-area select {
            width: calc(100% - 20px); /* 텍스트 박스가 부모 요소의 패딩을 고려하여 크기 조절 */
            padding: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        .input-area button {
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

    <!-- 좌측 메뉴 컨테이너 -->
    <div class="menu-container">
        <div class="menu-item" onclick="showMenu('members')">회원</div>
        <div class="menu-item" onclick="showMenu('trainers')">트레이너</div>
        <div class="menu-item" onclick="showMenu('reservation')">PT 예약 현황</div>
        <div class="menu-item" onclick="showMenu('sales')">매출</div>
    </div>

     <!-- 중앙 컨테이너 -->
    <div class="main-container">
        <iframe src="members.jsp" frameborder="0" width="100%" height="100%"></iframe>
    </div>


</body>
</html>
<script>
	// 메뉴를 클릭했을 때 해당 메뉴의 컨텐츠를 보이도록 하는 함수
    function showMenu(menuId) {
    	// 모든 메뉴 숨기기
        document.getElementById('members').style.display = 'none';
        document.getElementById('trainers').style.display = 'none';
        document.getElementById('reservation').style.display = 'none';
        document.getElementById('sales').style.display = 'none';

        // 클릭한 메뉴만 보이도록 설정
        document.getElementById(menuId).style.display = 'block';
        }

        
    function showMenu(menu) {
            // 여기서 각 메뉴에 따라 로드할 페이지의 경로를 지정
    	var pagePath;

        switch (menu) {
        	case 'members':
            	pagePath = 'members.jsp'; // 예시: 회원 페이지 경로
            	break;
            case 'trainers':
                pagePath = 'trainers.jsp'; // 예시: 트레이너 페이지 경로
                break;
            case 'reservation':
                pagePath = 'reservation.jsp'; // 예시: PT 예약 페이지 경로
                break;
            case 'sales':
                pagePath = 'sales.jsp'; // 예시: 매출 페이지 경로
                break;
            default:
                // 기본적으로 보일 페이지 설정
                pagePath = 'default.jsp'; // 예시: 기본 페이지 경로
       }

            // 중앙 컨테이너에 페이지 로드
            var mainContainer = document.querySelector('.main-container');
            mainContainer.innerHTML = ''; // 기존 내용 비우기
            var iframe = document.createElement('iframe');
            iframe.src = pagePath;
            mainContainer.appendChild(iframe);
        }
</script>

