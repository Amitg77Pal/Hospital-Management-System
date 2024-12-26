<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseConnection.jsp" %>
<%@ page import ="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Appointment Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('https://t3.ftcdn.net/jpg/04/96/80/34/360_F_496803433_TeCu85tBSH36XkKklQ4Eu6Zc5EbZQgs5.jpg');
            background-size: cover; /* Cover the entire background */
            background-position: center; /* Center the background */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #009688; /* Set default text color */
        }

        .container {
            width: 500px;
            padding: 40px;
            background-color: rgba(255, 255, 255, 0.8); /* Slightly transparent white background */
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        form label {
            font-size: 14px;
            color: #333;
            display: block;
            margin-bottom: 10px;
        }

        form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }

        form input[type="submit"] {
            width: 100%;
            background-color: #009688; /* Blue-green color for the button */
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        form input[type="submit"]:hover {
            background-color: #00796b; /* Darker shade on hover */
        }

    </style>
</head>
<%
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    DatabaseConnection db =  new DatabaseConnection();
    connection = db.getConnection();
    String username = (String)session.getAttribute("user");
%>
<body>
    <div class="container">
        <h2 style="color: #009688;">Book Your Appointment</h2>
        <form id="appointmentForm" method="POST">
            <label for="service">Choose a Service:</label>
            <select id="service" name="service" onchange="populateDoctors()">
                <option value="">Select Service</option>
                <option value="OPD">OPD</option>
                <option value="GENERAL">General Check-Up</option>
                <option value="EMERGENCY">Emergency</option>
                <option value="DENTAL">Dental Check-Up</option>
                <option value="CARDIOLOGY">Cardiology Check-Up</option>
                <option value="PEDIATRICS">Pediatrics Check-Up</option>
                <option value="DERMATOLOGY">Dermatology Check-Up</option>
            </select>

            <label for="doctor">Choose a Doctor:</label>
            <select id="doctor" name="doctor">
                <option value="">Select Doctor</option>
                <!-- Dynamically populated -->
            </select>

            <input type="submit" value="Book Appointment">
        </form>

        <%
            if(request.getMethod().equalsIgnoreCase("POST")){

                String ser = request.getParameter("service");
                String doc = request.getParameter("doctor");

                preparedStatement = connection.prepareStatement("UPDATE hospital.signup SET doctor = ?, service = ? WHERE email = ?");
                preparedStatement.setString(1, doc);
                preparedStatement.setString(2,ser);
                preparedStatement.setString(3,username);

                int row = preparedStatement.executeUpdate();
                if(row > 0){
                    response.sendRedirect("crud_op.jsp");
                }
            }
        %>
    </div>
</body>
<script>
function populateDoctors() {
    var service = document.getElementById("service").value;
    var doctorSelect = document.getElementById("doctor");
    
    // Clear existing options
    doctorSelect.innerHTML = "<option value=''>Select Doctor</option>";
    
    var doctors = [];

    // Added more Indian doctors for each category
    if (service === "OPD") {
        doctors = [
            "Dr. Sharma (OPD)",
            "Dr. Pal (OPD)",
            "Dr. Gupta (OPD)",
            "Dr. Iyer (OPD)",
            "Dr. Singh (OPD)"
        ];
    } else if (service === "GENERAL") {
        doctors = [
            "Dr. Reddy (General)",
            "Dr. Verma (General)",
            "Dr. Pal (General)",
            "Dr. Joshi (General)",
            "Dr. Kapoor (General)"
        ];
    } else if (service === "EMERGENCY") {
        doctors = [
            "Dr. Agarwal (Emergency)",
            "Dr. Khan (Emergency)",
            "Dr. Pal (Emergency)",
            "Dr. Choudhury (Emergency)",
            "Dr. Jain (Emergency)"
        ];
    } else if (service === "DENTAL") {
        doctors = [
            "Dr. Das (Dental)",
            "Dr. Rao (Dental)",
            "Dr. Chatterjee (Dental)",
            "Dr. Bansal (Dental)",
            "Dr. Malhotra (Dental)"
        ];
    } else if (service === "CARDIOLOGY") {
        doctors = [
            "Dr. Kapoor (Cardiology)",
            "Dr. Mehta (Cardiology)",
            "Dr. Sinha (Cardiology)",
            "Dr. Prasad (Cardiology)",
            "Dr. Singh (Cardiology)"
        ];
    } else if (service === "PEDIATRICS") {
        doctors = [
            "Dr. Pal (Pediatrics)",
            "Dr. Iyer (Pediatrics)",
            "Dr. Sharma (Pediatrics)",
            "Dr. Gupta (Pediatrics)",
            "Dr. Roy (Pediatrics)"
        ];
    } else if (service === "DERMATOLOGY") {
        doctors = [
            "Dr. Joshi (Dermatology)",
            "Dr. Reddy (Dermatology)",
            "Dr. Sharma (Dermatology)",
            "Dr. Pal (Dermatology)",
            "Dr. Kapoor (Dermatology)"
        ];
    }

    // Populate the doctor dropdown
    for (var i = 0; i < doctors.length; i++) {
        var option = document.createElement("option");
        option.value = doctors[i];
        option.text = doctors[i];
        doctorSelect.add(option);
    }
}
</script>
</html>
