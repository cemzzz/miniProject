<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login Result</title>
    <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
</head>
<body>
<%@ include file = "dbconn.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    String trainerID = request.getParameter("trainerID");
    String adminId = request.getParameter("adminId");
    String adminPwd = request.getParameter("adminPwd");

    String sql = "SELECT * FROM TRAINERS WHERE ADMIN_ID = '" + adminId + "' AND ADMIN_PASSWORD = '" + adminPwd + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
%>
        <script>
            showAlert('로그인 성공!');
        </script>
<%
    } else {
%>
        <script>
            showAlert('로그인 실패!');
        </script>
<%
    }
%>

</body>
</html>
