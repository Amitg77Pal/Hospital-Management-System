<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="DatabaseConnection.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital_Data Display Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url('https://www.ache.org/-/media/ache/blog/using_data_analytics_1200x628_twig.png?h=675&w=1290&la=en&hash=ADB5835B39274E3477E33608F46B786B') no-repeat center center fixed;
            background-size: cover;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 15px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #f0ad4e;
            color: white;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .operation-buttons {
            display: flex;
            gap: 10px;
        }

        button {
            background-color: #5bc0de;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            font-size: 14px;
            border-radius: 5px;
        }

        button:hover {
            background-color: #0275d8;
        }

    </style>
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        DatabaseConnection db = new DatabaseConnection();
        conn = db.getConnection();
    %>
    <script>
        function updateRecord(id) {
            alert("Update functionality for record ID: " + id);
        }

        function deleteRecord(id) {
            alert("Delete functionality for record ID: " + id);
        }
    </script>
</head>
<body>
    <div class="container">
       <h1 style="color: #009688;">Hospital Data Entry</h1>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Age</th>
                    <th>Phone Number</th>
                    <th>Service</th>
                    <th>Doctor</th>
                    <th>Operations</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        String sql = "select * from hospital.signup";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            int id = rs.getInt("patientNu");
                            String name = rs.getString("Name");
                            String email = rs.getString("email");
                            int age = rs.getInt("Age");
                            String phone = rs.getString("ContactNumber");
                            String ser = rs.getString("service");
                            String doctor = rs.getString("doctor");
                %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= name %></td>
                                <td><%= email %></td>
                                <td><%= age %></td>
                                <td><%= phone %></td>
                                <td><%= ser %></td>
                                <td><%= doctor %></td>
                                <td>
                                    <div class="operation-buttons">
                                        <button onclick="window.location.href='update.jsp?id=<%= id %>'">Update</button>
                                        <button onclick="window.location.href='delete.jsp?id=<%= id %>'">Delete</button>
                                        <button onclick="window.location.href='receipt.jsp?id=<%= id %>'">Print</button>
                                    </div>
                                </td>
                            </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) {}
                        if (ps != null) try { ps.close(); } catch (SQLException e) {}
                        if (conn != null) try { conn.close(); } catch (SQLException e) {}
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
