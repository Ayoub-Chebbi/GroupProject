<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<style>
/* General Styles */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.body {
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #060c12;
  height: 100vh;
}

.NewLoginClass {
  width: 100%;
  height: 100vh;
  background: linear-gradient(rgba(8, 0, 58, 0.7), rgba(8, 0, 58, 0.7)), url('https://www.thoughtco.com/thmb/U0oKRWkIdw_ZW_3KuDtjvqpMTYk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/IMG_1640-56aa5cde3df78cf772b0df57.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  color: #fff;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}

.Login-text {
  text-align: center;
  max-width: 800px;
  margin-bottom: 2em;
}

.Login-text h1 {
  font-size: 50px;
  font-weight: 100;
}

.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 2em;
}

/* Form Styles */
.form1 {
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 2em;
  width: 400px;
  background-color: #171825;
  border-radius: 25px;
  transition: 0.4s ease-in-out;
}

.form1:hover {
  transform: scale(1.05);
  border: 1px solid black;
}

h2 {
  text-align: center;
  margin-bottom: 2em;
  color: rgb(255, 255, 255);
}

.form-group {
  margin-bottom: 1em;
}

.form-group .form-control {
  background: none;
  border: none;
  outline: none;
  width: 100%;
  color: #d3d3d3;
  background-color: #171717;
  padding: 10px;
  border-radius: 5px;
  box-shadow: inset 2px 5px 10px rgb(5, 5, 5);
}

.form-group .form-control::placeholder {
  color: rgba(211, 211, 211, 0.7);
}

.btn-primary {
  display: block;
  width: 100%;
  padding: 10px;
  border: none;
  border-radius: 5px;
  background-color: #00bfff;
  color: #fff;
  transition: 0.4s ease-in-out;
}

.btn-primary:hover {
  background-color: #00bfff96;
}

.text-danger {
  color: red;
}
</style>

<div class="body">
    <div class="NewLoginClass">
        <div class="Login-text">
            <h1>We Ensure Better Education for a Better World</h1>
        </div>
        <div class="login-container">
            <!-- Login Form -->
            <div class="form1">
                <form:form action="${pageContext.request.contextPath}/user/login" method="post" modelAttribute="newLogin">
                    <h2>Log In</h2>
                    <div class="form-group">
                        <form:errors path="email" class="text-danger"/>
                        <form:input class="form-control" path="email" placeholder="Email"/>
                    </div>
                    <div class="form-group">
                        <form:errors path="password" class="text-danger"/>
                        <form:input class="form-control" path="password" placeholder="Password" type="password"/>
                    </div>
                    <button type="submit" class="btn btn-primary">Log In</button>
                </form:form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
