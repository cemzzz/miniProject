<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- jQuery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Bootstrap JavaScript 추가 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<style>
 
       

</style>

</head>
<body>
	<%@ include file="dbconn.jsp"%>
	
	<div class="container-fluid">
    <div class="row">
        <!-- 좌측 컨테이너 -->
        <div class="col-md-3 bg-light">
            <h2 class="mt-3">매출 종류 리스트</h2>
            <ul class="list-group">
                <li class="list-group-item"><a href="#">일별 매출</a></li>
                <li class="list-group-item"><a href="#">월별 매출</a></li>
                <li class="list-group-item"><a href="#">분기별 매출</a></li>
            </ul>
        </div>

        <!-- 중앙 컨테이너 -->
        <div class="col-md-9">
            <div class="mt-3">
                <h1 class="display-4">매출 현황</h1>
            </div>
            <div class="sales-data">
                <!-- 매출 현황 데이터를 여기에 표시할 것입니다. -->
            </div>
        </div>
    </div>
</div>
	
	
</body>
</html>