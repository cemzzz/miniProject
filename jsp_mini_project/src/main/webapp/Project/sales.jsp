<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    .main-container {
        display: flex;
        min-height: 100vh;
    }

    .sidebar {
        width: 200px;
        background-color: #f0f0f0;
        padding: 20px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .menu ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .menu li a {
        display: block;
        padding: 10px;
        color: #333;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s ease;
    }

    .menu li a:hover {
        background-color: #4CAF50;
        color: white;
    }

    .content {
        flex-grow: 1;
        padding: 20px;
        background-color: #fff;
    }

    #salesData {
        padding: 20px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
</style>

</head>
<body>
	<%@ include file="dbconn.jsp"%>
	
	<div class="main-container">
    <aside class="sidebar">
        <nav class="menu">
            <ul>
                <li><a href="#" onclick="showSales('daily')">일별 매출</a></li>
                <li><a href="#" onclick="showSales('monthly')">월별 매출</a></li>
                <li><a href="#" onclick="showSales('annual')">연간 매출</a></li>
                <!-- 기타 매출 현황 선택 기능 -->
            </ul>
        </nav>
    </aside>

    <section class="content">
        <div id="salesData">
            <!-- 매출 데이터를 동적으로 표시할 영역 -->
        </div>
    </section>
	</div>

</body>
</html>