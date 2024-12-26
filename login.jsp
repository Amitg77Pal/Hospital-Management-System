<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseConnection.jsp" %>
<%@ page import ="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: url('https://cdn.dribbble.com/users/5772166/screenshots/15160568/media/794c55fc5b389db23135835f04aaaf29.png') no-repeat center center fixed;
        background-size: cover; /* Ensure the image covers the full background */
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .container {
        width: 400px;
        padding: 40px;
        background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent white */
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    .login-form h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #009688; /* Changed to #009688 */
    }

    .login-form label {
        font-size: 14px;
        color: #333;
        display: block;
        margin-bottom: 8px;
    }

    .login-form input[type="text"],
    .login-form input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 14px;
    }

    .login-form input[type="submit"] {
        width: 100%;
        background-color: #009688; /* Changed to #009688 */
        color: white;
        border: none;
        padding: 12px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    .login-form input[type="submit"]:hover {
        background-color: #00796B; /* A slightly darker shade on hover */
    }

    .signup-link {
        text-align: center;
        margin-top: 10px;
        font-size: 14px;
    }

    .signup-link a {
        color: #009688; /* Changed to #009688 */
        text-decoration: none;
    }

    .signup-link a:hover {
        text-decoration: underline;
    }

</style>
<%
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    DatabaseConnection db =  new DatabaseConnection();
    connection = db.getConnection();
%>
</head>
<body>
    <div class="container">
        <div class="login-form">
            <h2>Login</h2>
            <form name="loginForm" method="POST" onsubmit="return validateLoginForm()">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" placeholder="Enter Email">
                
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter Password">
                
                <input type="submit" value="Login">
            </form>
            <p class="signup-link">Don't have an account? <a href="signup.jsp">Sign Up</a></p>
        </div>
        <%
         if(request.getMethod().equalsIgnoreCase("POST")){
            String username = request.getParameter("email");
            String password = request.getParameter("password");

            preparedStatement = connection.prepareStatement("select email , password from hospital.signup where email = ? ");
            preparedStatement.setString(1,username);
            resultSet = preparedStatement.executeQuery();
            if(resultSet != null && resultSet.next())
            {
                    if (resultSet.getString("password") != null && password.equals(resultSet.getString("password"))) {
                        response.sendRedirect("appointment.jsp");
                        session.setAttribute("user",username);
                    }
                else{
                    response.sendRedirect("wrongPassword.jsp");
                }
            }
            else{
                response.sendRedirect("signup.jsp");
            }
         }
        %>
    </div>
</body>
<script>
function validateLoginForm() {
    var email = document.forms["loginForm"]["email"].value;
    var password = document.forms["loginForm"]["password"].value;

    if (email == "") {
        alert("Email must be filled out");
        return false;
    }
    
    // Basic email validation
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    if (!emailPattern.test(email)) {
        alert("Please enter a valid email address");
        return false;
    }
    
    if (password == "") {
        alert("Password must be filled out");
        return false;
    }
    
    return true;
}
</script>
</html>
