
<%@ page session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="DatabaseConnection.jsp" %>
<%@ page import ="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
    <head>
    </head>

    <body>
        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            DatabaseConnection db = new DatabaseConnection();
            con = db.getConnection();
            if(con != null){
                %>
                <h1>Connection successfull.</h1>
                <%
            }
            else{
                %>
                <h1>Connection failed.</h1>
                <%
            }

        %>
    </body>

</html>
