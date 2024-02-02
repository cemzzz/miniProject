<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .container {
        display: flex;
        justify-content: space-between;
    }

    .sidebar {
        width: 200px;
        background-color: #f2f2f2;
        padding: 20px;
    }

    .sidebar h2 {
        font-size: 24px;
        margin-bottom: 10px;
    }

    .sidebar ul {
        list-style-type: none;
        padding: 0;
    }

    .sidebar ul li {
        margin-bottom: 10px;
    }

    .content {
        flex-grow: 1;
        padding: 20px;
    }

    h1 {
        font-size: 28px;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    table, th, td {
        border: 1px solid #ccc;
    }

    th, td {
        padding: 10px;
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
</style>

</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<div class="container">
        <div class="sidebar">
            <h2>매출 선택</h2>
            <ul>
                <li><a href="?view=daily">일별</a></li>
                <li><a href="?view=monthly">월별</a></li>
                <li><a href="?view=quarterly">분기별</a></li>
            </ul>
        </div>
        <div class="content">
            <h1>매출 현황</h1>
            <table border="1">
                <tr>
                    <th>매출 번호</th>
                    <th>회원 이름</th>
                    <th>이용권 이름</th>
                    <th>PT 세션</th>
                    <th>매출 일자</th>
                    <th>총액</th>
                </tr>
                <%
	                String view = request.getParameter("view");
	                if (view == null) {
	                    view = "daily"; // 기본값 설정
	                }
	                
	                String sql = "";

                    if ("daily".equals(view)) {
                    	sql = "SELECT SALE_ID, MEMBERS.NAME, PLANS.NAME, PTSESSIONS.SESSIONS, SALE_DATE, PLANS.PRICE " +
                    	       "FROM SALESRECORDS " +
                    	       "INNER JOIN MEMBERS ON SALESRECORDS.MEMBER_ID = MEMBERS.MEMBER_ID " +
                    	       "INNER JOIN PLANS ON SALESRECORDS.PLAN_ID = PLANS.PLAN_ID " +
                    	       "INNER JOIN PTSESSIONS ON SALESRECORDS.PT_ID = PTSESSIONS.PT_ID " +
                    	       "WHERE TO_DATE(SALE_DATE, 'YYYY-MM-DD') = TRUNC(SYSDATE)";

                    } else if ("monthly".equals(view)) {
                        sql = "SELECT SALE_ID, MEMBERS.NAME, PLANS.NAME, PTSESSIONS.SESSIONS, SALE_DATE, TOTAL_AMOUNT " +
                              "FROM SALESRECORDS " +
                              "INNER JOIN MEMBERS ON SALESRECORDS.MEMBER_ID = MEMBERS.MEMBER_ID " +
                              "INNER JOIN PLANS ON SALESRECORDS.PLAN_ID = PLANS.PLAN_ID " +
                              "INNER JOIN PTSESSIONS ON SALESRECORDS.PT_ID = PTSESSIONS.PT_ID " +
                              "WHERE TO_CHAR(SALE_DATE, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')";

                    } else if ("quarterly".equals(view)) {
                        sql = "SELECT SALE_ID, MEMBERS.NAME, PLANS.NAME, PTSESSIONS.SESSIONS, SALE_DATE, TOTAL_AMOUNT " +
                              "FROM SALESRECORDS " +
                              "INNER JOIN MEMBERS ON SALESRECORDS.MEMBER_ID = MEMBERS.MEMBER_ID " +
                              "INNER JOIN PLANS ON SALESRECORDS.PLAN_ID = PLANS.PLAN_ID " +
                              "INNER JOIN PTSESSIONS ON SALESRECORDS.PT_ID = PTSESSIONS.PT_ID " +
                              "WHERE TO_CHAR(SALE_DATE, 'YYYY-Q') = TO_CHAR(SYSDATE, 'YYYY-Q')";
                    }
                    
                    ResultSet rs = stmt.executeQuery(sql);

                   
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getInt("SALE_ID") + "</td>");
                        out.println("<td>" + rs.getString("NAME") + "</td>");
                        out.println("<td>" + rs.getString("NAME") + "</td>");
                        out.println("<td>" + rs.getInt("SESSIONS") + "</td>");
                        out.println("<td>" + rs.getDate("SALE_DATE") + "</td>");
                        out.println("<td>" + rs.getDouble("TOTAL_AMOUNT") + "</td>");
                        out.println("</tr>");
                    }

                    // 자원 해제
                    rs.close();
                    stmt.close();
                    // 연결을 끊지 않고 닫음
                %>
            </table>
        </div>
    </div>
	
	
	
</body>
</html>