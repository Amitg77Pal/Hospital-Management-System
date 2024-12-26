<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="DatabaseConnection.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Record</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('https://media.licdn.com/dms/image/v2/D5612AQFOY6zRo5lW2w/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1721173501099?e=1733961600&v=beta&t=SA_HNn1ad0cl20UCAQn1_SgeM6raA5Aub8B-2YtVW-w') no-repeat center center fixed;
            background-size: cover; /* Ensure the image covers the full background */
            margin: 0;
            padding: 0;
        }

        .container {
            width: 40%; /* Reduced width */
            margin: 30px auto; /* Reduced margin */
            background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent background */
            padding: 15px; /* Reduced padding */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        h1 {
            text-align: center;
            color: #009688;
            font-size: 24px; /* Adjusted font size */
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            font-size: 14px; /* Reduced font size */
            margin-bottom: 8px; /* Reduced margin */
        }

        input[type="text"], input[type="email"], input[type="number"] {
            padding: 8px; /* Reduced padding */
            margin-bottom: 15px; /* Reduced margin */
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            padding: 8px; /* Reduced padding */
            background-color: #009688;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #00796B;
        }

        .btn-back {
            background-color: #009688;
            margin-top: 15px; /* Reduced margin */
        }

        .btn-back:hover {
            background-color: #00796B;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Update Record</h1>

        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            int id = Integer.parseInt(request.getParameter("id"));
            String name = "";
            String email = "";
            int age = 0;
            String phone = "";
            String service = "";
            String doctor = "";
            DatabaseConnection db = new DatabaseConnection();

            try {
                conn = db.getConnection();
                String query = "SELECT Name, email, Age, ContactNumber, service, doctor FROM hospital.signup WHERE patientNu = ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, id);
                rs = ps.executeQuery();
                
                if (rs.next()) {
                    name = rs.getString("Name");
                    email = rs.getString("email");
                    age = rs.getInt("Age");
                    phone = rs.getString("ContactNumber");
                    service = rs.getString("service");
                    doctor = rs.getString("doctor");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (ps != null) try { ps.close(); } catch (SQLException e) {}
            }
        %>

        <form method="POST">
            <input type="hidden" name="id" value="<%= id %>">

            <label for="name">Name</label>
            <input type="text" name="name" value="<%= name %>" required>

            <label for="email">Email</label>
            <input type="email" name="email" value="<%= email %>" required>

            <label for="age">Age</label>
            <input type="number" name="age" value="<%= age %>" required>

            <label for="phone">Contact Number</label>
            <input type="text" name="phone" value="<%= phone %>" required>

            <label for="service">Service</label>
            <input type="text" name="service" value="<%= service %>" required>

            <label for="doctor">Doctor</label>
            <input type="text" name="doctor" value="<%= doctor %>" required>

            <button type="submit">Update Record</button>
        </form>

        <button class="btn-back" onclick="window.location.href='crud_op.jsp'">Back to List</button>

        <%
            // Handle form submission and update the record
            if(request.getMethod().equalsIgnoreCase("POST")) {
                String newName = request.getParameter("name");
                String newEmail = request.getParameter("email");
                int newAge = Integer.parseInt(request.getParameter("age"));
                String newPhone = request.getParameter("phone");
                String newService = request.getParameter("service");
                String newDoctor = request.getParameter("doctor");

                try {
                    conn = db.getConnection();
                    String updateQuery = "UPDATE hospital.signup SET Name = ?, email = ?, Age = ?, ContactNumber = ?, service = ?, doctor = ? WHERE patientNu = ?";
                    ps = conn.prepareStatement(updateQuery);
                    ps.setString(1, newName);
                    ps.setString(2, newEmail);
                    ps.setInt(3, newAge);
                    ps.setString(4, newPhone);
                    ps.setString(5, newService);
                    ps.setString(6, newDoctor);
                    ps.setInt(7, id);

                    int rowsUpdated = ps.executeUpdate();

                    if (rowsUpdated > 0) {
                        out.println("<p>Record updated successfully!</p>");
                        response.sendRedirect("crud_op.jsp");
                    } else {
                        out.println("<p>Error updating record.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (ps != null) try { ps.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            }
        %>
    </div>
</body>
</html>
