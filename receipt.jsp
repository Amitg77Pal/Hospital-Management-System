<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Appointment Receipt</title>
</head>
<style>
body {
    font-family: Arial, sans-serif;
    background: url('https://www.ecourbdesigns.com/wp-content/uploads/2023/11/1.jpg') no-repeat center center fixed;
    background-size: cover;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.container {
    width: 600px;
    padding: 40px;
    background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    text-align: center;
}

h2, h1 {
    margin-bottom: 20px;
    font-size: 28px;
    color: #333;
}

.receipt-box {
    text-align: left;
    margin-bottom: 30px;
    border-top: 2px solid #ddd;
    padding-top: 20px;
}

.receipt-box p {
    font-size: 18px;
    color: #555;
    margin: 10px 0;
}

.receipt-box strong {
    color: #333;
}

button {
    padding: 12px 20px;
    font-size: 16px;
    background-color: #009688;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 20px;
}

button:hover {
    background-color: #45a049;
}

</style>
<%
    Connection connection = null;
    PreparedStatement stmt = null;
    ResultSet resultSet = null;

    DatabaseConnection db = new DatabaseConnection();
    connection = db.getConnection();
%>
<body>
    <div class="container">
        <h1 style="color: #009688;">Amit Hospital</h1>
        <h2 style="color: #009688;">Patient Appointment Receipt</h2>

        <%
            // Fetch appointment details from the database
            int id = Integer.parseInt(request.getParameter("id"));

            try {
                // Query to fetch patient and appointment details
                String query = "select * from hospital.signup where patientNu = ?";
                stmt = connection.prepareStatement(query);
                stmt.setInt(1, id);
                resultSet = stmt.executeQuery();

                if (resultSet.next()) {
                    String name = resultSet.getString("Name");
                    int age = resultSet.getInt("Age");
                    String phoneNumber = resultSet.getString("ContactNumber");
                    String serviceType = resultSet.getString("service");
                    String doctorName = resultSet.getString("doctor");
        %>

        <div class="receipt-box">
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Age:</strong> <%= age %></p>
            <p><strong>Phone Number:</strong> <%= phoneNumber %></p>
            <p><strong>Service Type:</strong> <%= serviceType %></p>
            <p><strong>Doctor:</strong> <%= doctorName %></p>
        </div>

        <%
                } else {
        %>
        <p>No appointment details found for the provided Patient ID.</p>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <p>An error occurred while fetching the appointment details.</p>
        <%
            } finally {
                try { if (resultSet != null) resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>

        <button onclick="printReceipt()">Print Receipt</button>
    </div>

    <script>
        function printReceipt() {
            window.print();
        }
    </script>
</body>
</html>
