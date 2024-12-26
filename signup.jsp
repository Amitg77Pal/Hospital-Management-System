<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseConnection.jsp" %>
<%@ page import ="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Sign-Up</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('https://cdn.dribbble.com/users/1950768/screenshots/3987739/sign_up.png?resize=800x600&vertical=center') no-repeat center center fixed;
            background-size: cover;
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

        .signup-form h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #009688; /* Change color to green-sky blue */
        }

        .signup-form label {
            font-size: 14px;
            color: #333;
            display: block;
            margin-bottom: 8px;
        }

        .signup-form input[type="text"],
        .signup-form input[type="number"],
        .signup-form input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .signup-form input[type="submit"] {
            width: 100%;
            background-color: #009688; /* Change button color */
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .signup-form input[type="submit"]:hover {
            background-color: #00796b; /* Darker shade for hover effect */
        }
    </style>
</head>
<%
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    DatabaseConnection db = new DatabaseConnection();
    connection = db.getConnection();
%>
<body>
    <div class="container">
        <div class="signup-form">
            <h2>Patient Sign-Up</h2>
            <form name="signupForm" method="POST" onsubmit="return validateForm()">  
                <label for="id">Email:</label>
                <input type="text" id="id" name="Email" placeholder="Enter Email">
                
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" placeholder="Enter Patient Name">
                
                <label for="age">Age:</label>
                <input type="number" id="age" name="age" placeholder="Enter Patient Age">
                
                <label for="contact_number">Contact Number:</label>
                <input type="text" id="contact_number" name="contact_number" placeholder="Enter Contact Number">

                <label for="Password">Password:</label>
                <input type="password" id="pass" name="password" placeholder="Enter Password">

                <input type="submit" value="Sign Up">
            </form>
            <%
                if(request.getMethod().equalsIgnoreCase("POST")){
                    String mail = request.getParameter("Email");
                    String name = request.getParameter("name");
                    String age = request.getParameter("age");
                    int age_int = 0;
                    if(age != null && !age.isEmpty()){
                        age_int = Integer.parseInt(age);
                    }
                    String phone = request.getParameter("contact_number");
                    String pass = request.getParameter("password");
                    preparedStatement = connection.prepareStatement("insert into hospital.signup(email, Name, Age, ContactNumber, password) values(?,?,?,?,?)");
                    preparedStatement.setString(1, mail);
                    preparedStatement.setString(2, name);
                    preparedStatement.setInt(3, age_int);
                    preparedStatement.setString(4, phone);
                    preparedStatement.setString(5, pass);

                    int row = preparedStatement.executeUpdate();
                    if (row > 0){
                        response.sendRedirect("login.jsp");
                    }
                }
            %>
        </div>
    </div>
</body>
<script>
    function validateForm() {
        var id = document.forms["signupForm"]["Email"].value; // Fixed name to "Email"
        var name = document.forms["signupForm"]["name"].value;
        var age = document.forms["signupForm"]["age"].value;
        var contact_number = document.forms["signupForm"]["contact_number"].value;

        if (id == "") {
            alert("Email must be filled out");
            return false;
        }
        if (name == "") {
            alert("Name must be filled out");
            return false;
        }
        if (age == "" || isNaN(age) || age <= 0) {
            alert("Please enter a valid age");
            return false;
        }
        if (contact_number == "" || !/^\d{10}$/.test(contact_number)) {
            alert("Please enter a valid 10-digit contact number");
            return false;
        }
        return true;
    }
</script>
</html>
