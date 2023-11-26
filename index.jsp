<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Vehicle Reservation</title>
<link rel="stylesheet" href="./css/index.css">
<script type="text/javascript">
function login() {
    var authorizeEndpoint = 'https://api.asgardeo.io/t/sheran/oauth2/authorize';
    var clientId = 'ThWAxD0WwVBzO8jtBM5fLbAbmU8a';
    var redirectUri = encodeURIComponent('http://localhost:8080/SR_Reservation/authorze.jsp');

    var redirectUrl = authorizeEndpoint + '?response_type=code' +
        '&client_id=' + clientId +
        '&scope=openid address email phone profile' +
        '&redirect_uri=' + redirectUri;

    window.location.href = redirectUrl;
}
</script>
</head>
<body>
<div class="login-container">
<button class="login-button" onClick="login()">Login</button>
</div>

</body>
</html>