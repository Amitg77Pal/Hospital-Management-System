<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Wrong Password</title>
</head>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    overflow: hidden;
    background-color: #f4f4f9;
}

.video-bg {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: -1; /* Put the video behind other elements */
}

.container {
    width: 400px;
    padding: 40px;
    background-color: rgba(255, 255, 255, 0.8); /* Slight transparency */
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    text-align: center;
    z-index: 1; /* Make sure the container stays above the video */
}

.error-box h2 {
    color: #ff4c4c;
    font-size: 24px;
    margin-bottom: 20px;
}

.error-box p {
    color: #333;
    font-size: 16px;
    margin-bottom: 30px;
}

.error-box button {
    padding: 10px 20px;
    font-size: 16px;
    background-color: #009688; /* Set background to #009688 */
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.error-box button:hover {
    background-color: #00796B; /* Slightly darker on hover */
}
</style>
<body>
    <!-- Video background -->
    <video class="video-bg" autoplay loop muted>
        <source src="https://v.ftcdn.net/06/24/20/38/700_F_624203808_52EmeuOwLqKrrAJsSKttAvnPJRYFyTOF_ST.mp4" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <div class="container">
        <div class="error-box">
            <h2>Wrong Password</h2>
            <p>You have entered the wrong password. Please try again.</p>
            <button onclick="goBack()">Return to Login</button>
        </div>
    </div>

    <script>
        function goBack() {
            window.location.href = 'login.jsp'; // Redirect to login page
        }
    </script>
</body>
</html>
