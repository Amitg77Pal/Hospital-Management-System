<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="DatabaseConnection.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Record</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 50%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #333;
        }

        .btn-back {
            background-color: #f0ad4e;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
        }

        .btn-back:hover {
            background-color: #ec971f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Delete Record</h1>
        
        <%
            // Get the record ID from the URL parameter
            int id = Integer.parseInt(request.getParameter("id"));
            Connection conn = null;
            PreparedStatement ps = null;
            boolean deleted = false;
            DatabaseConnection db = new DatabaseConnection();

            try {
                // Establish database connection
                conn = db.getConnection();

                // Prepare the DELETE query
                String deleteQuery = "DELETE FROM hospital.signup WHERE patientNu = ?";
                ps = conn.prepareStatement(deleteQuery);
                ps.setInt(1, id);

                // Execute the DELETE query
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    deleted = true;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Close resources
                if (ps != null) try { ps.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }

            // Display message based on the outcome
            if (deleted) {
                out.println("<p>Record with ID " + id + " was deleted successfully!</p>");
                response.sendRedirect("crud_op.jsp"); // Redirect to the main list page after deletion
            } else {
                out.println("<p>Failed to delete record with ID " + id + ".</p>");
            }
        %>

        <button class="btn-back" onclick="window.location.href='crud_op.jsp'">Back to List</button>
    </div>
</body>
</html>
