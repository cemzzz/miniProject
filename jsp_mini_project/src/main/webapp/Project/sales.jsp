<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        background-color: #f4f4f4;
    }

    .container {
        display: flex;
        min-height: 100vh;
    }

    .sidebar {
        width: 20%;
        background-color: #2c3e50;
        padding: 20px;
        color: white;
    }

    .sidebar a {
        display: block;
        color: #fff;
        padding: 10px;
        margin-bottom: 10px;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s;
    }

    .sidebar a:hover, .sidebar a.active {
        background-color: #34495e;
    }

    .main-content {
        width: 80%;
        padding: 20px;
        background-color: #ecf0f1;
    }

    .sales-record {
        background-color: white;
        padding: 15px;
        margin-bottom: 15px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .sales-record h3 {
        margin-top: 0;
    }
	
</style>

</head>
<body>
	<%@ include file="dbconn.jsp"%>
	
	<div class="container">
        <div class="sidebar">
            <!-- 매출 종류 리스트 -->
	        <a href="sales.jsp?sales_type=daily" class="active">일일 매출</a>
	        <a href="sales.jsp?sales_type=monthly" class="active">월별 매출</a>
	        <a href="sales.jsp?type=quarterly">분기별 매출</a>
	        <a href="sales.jsp?sales_type=total" class="active">총 매출</a>     
        </div>
        <div class="main-content">
        	  <% 
              String salesType = request.getParameter("sales_type");
        	 
              ResultSet rs = null;
              
              if ("monthly".equals(salesType)) {
                  String sqlMonthly = "SELECT TO_CHAR(PURCHASE_DATE, 'YYYY-MM') AS SALE_MONTH, SUM(p.PRICE + pt.PRICE) AS MONTHLY_SALES "
                                    + "FROM MEMBERS m "
                                    + "LEFT JOIN PLANS p ON m.PLAN_ID = p.PLAN_ID "
                                    + "LEFT JOIN PTSESSIONS pt ON m.PT_ID = pt.PT_ID "
                                    + "GROUP BY TO_CHAR(PURCHASE_DATE, 'YYYY-MM') "
                                    + "ORDER BY SALE_MONTH";
                  ResultSet rsMonthly = stmt.executeQuery(sqlMonthly);
                  while(rsMonthly.next()){
                      String month = rsMonthly.getString("SALE_MONTH");
                      int monthlySales = rsMonthly.getInt("MONTHLY_SALES");
              %>
                          <h3><%= month %> 월</h3>
                      <div class="sales-record">
                          <p><%= String.format("%,d", monthlySales) %>원</p>
                      </div>
              <%
                  }
                  rsMonthly.close();
              } else if ("total".equals(salesType)) {
            	  // 총 매출 SQL 쿼리
                  String sql = "SELECT SUM(total_price) AS TOTAL_AMOUNT FROM ( " +
                               "SELECT SUM(p.PRICE) AS total_price FROM MEMBERS m JOIN PLANS p ON m.PLAN_ID = p.PLAN_ID " +
                               "UNION ALL " +
                               "SELECT SUM(pt.PRICE) AS total_price FROM MEMBERS m JOIN PTSESSIONS pt ON m.PT_ID = pt.PT_ID)";
                  rs = stmt.executeQuery(sql);
                  
                  double totalAmount = 0;
                  while(rs.next()){
                      totalAmount += rs.getDouble("TOTAL_AMOUNT");
                  }
                  
                  // 소수점 이하를 제거하기 위해 Math.round를 사용합니다.
                  totalAmount = Math.round(totalAmount);
              %>
                  <h2>총 매출</h2>
              	<div class="sales-record">
                  <p>총 매출액: <%= String.format("%,d", (int)totalAmount) %>원</p>
                </div>
              <%
              } else if ("daily".equals(salesType)) {
                  String sql = "SELECT EXTRACT(YEAR FROM m.PURCHASE_DATE) AS SALE_YEAR, EXTRACT(MONTH FROM m.PURCHASE_DATE) AS SALE_MONTH, " +
                          "EXTRACT(DAY FROM m.PURCHASE_DATE) AS SALE_DAY, SUM(p.PRICE + pt.PRICE) AS DAILY_SALES " +
                          "FROM MEMBERS m " +
                          "JOIN PLANS p ON m.PLAN_ID = p.PLAN_ID " +
                          "JOIN PTSESSIONS pt ON m.PT_ID = pt.PT_ID " +
                          "GROUP BY EXTRACT(YEAR FROM m.PURCHASE_DATE), EXTRACT(MONTH FROM m.PURCHASE_DATE), EXTRACT(DAY FROM m.PURCHASE_DATE) " +
                          "ORDER BY SALE_YEAR, SALE_MONTH, SALE_DAY";
	             rs = stmt.executeQuery(sql);
	
	             int currentYear = 0;
	             int currentMonth = 0;
	
	             while(rs.next()){
	                 int year = rs.getInt("SALE_YEAR");
	                 int month = rs.getInt("SALE_MONTH");
	                 int day = rs.getInt("SALE_DAY");
	                 int dailySales = rs.getInt("DAILY_SALES");
	
	                 // 연도와 월이 변경되면 새로운 헤더를 출력
	                 if (year != currentYear || month != currentMonth) {
	                     currentYear = year;
	                     currentMonth = month;
	                     %><h3><%= year %>년 <%= month %>월</h3><%
	                 }
					
	                 %>
	                 	<div class="sales-record">
	                 		<p><%= day %>일 <%= String.format("%,d", dailySales) %>원</p>
	                 	</div>
	                 <%
	                 		 
	             }
	         }
    
             if (rs != null) rs.close();
             stmt.close();
             %>
        	  
        </div>
    </div>
	
	
	
</body>
</html>