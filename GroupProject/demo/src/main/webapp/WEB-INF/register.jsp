<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<style>
   .navbar {
        position: fixed;
        top: 0;
        left: 0;
        height: 100%;
        width: 250px;
        background-color: #0d1117;
        padding: 20px;
        overflow-y: auto;
        align-content: flex-start;
        position: fixed;
  top: 0;
  left: 0;
 
  z-index: 1000; /* Ensure it's above other content */
    }

    .navbar .value {
        font-size: 15px;
        background-color: transparent;
        border: none;
        padding: 10px;
        color: white;
        display: flex;
        align-items: center;
        gap: 10px;
        cursor: pointer;
        border-radius: 10px;
        transition: 0.3s;
        box-sizing: border-box;
    }

    .navbar .value:not(:active):hover,
    .navbar .value:focus {
        border: 2px solid #1a1f24;
        color: #637185;
    }

    .navbar .value:focus,
    .navbar .value:active {
        background-color: #1a1f24;
        outline: none;
        margin-left: 17px;
    }

    .navbar .value::before {
        content: "";
        position: absolute;
        top: 5px;
        left: -15px;
        width: 5px;
        height: 80%;
        background-color: #2f81f7;
        border-radius: 5px;
        opacity: 0;
        transition: 1s;
    }

    .navbar .value:focus::before,
    .navbar .value:active::before {
        opacity: 1;
    }

    .navbar .value svg {
        width: 20px;
    }

    .navbar:hover > :not(.value:hover) {
        transition: 300ms;
        filter: blur(1.5px);
        transform: scale(0.95);
    }

    .content {
        margin-left: 250px;
        padding: 20px;
        width: calc(100% - 250px);
        
        overflow-y: auto;
    }/* Existing styles */
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


<div class="navbar">
  <button class="value">
      <svg data-name="Layer 2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16">
          <path d="M1.5 13v1a.5.5 0 0 0 .3379.4731A18.9718 18.9718 0 0 0 8 15.5a18.9629 18.9629 0 0 0 6.1621-1.0269.5.5 0 0 0 .3379-.4731v-1a6.5083 6.5083 0 0 0-4.461-6.1676 3.5 3.5 0 1 0-4.078 0A6.5083 6.5083 0 0 0 1.5 13zm4-9a2.5 2.5 0 1 1 2.5 2.5A2.5026 2.5026 0 0 1 5.5 4zm2.5 3.5a5.5066 5.5066 0 0 1 5.5 5.5v.6392a18.08 18.08 0 0 1-11 0v-.6392A5.5066 5.5066 0 0 1 8 7.5z" fill="#7D8590"></path>
      </svg>
      <a href="/api/courses/all">Dashboard</a>
  </button>

  <button class="value">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 128">
          <path d="M109.9 20.63a6.232 6.232 0 0 0-8.588-.22L43.849 72.253c-.012.011-.02.024-.031.035s-.023.017-.034.027L39.063 77.037a1.749 1.749 0 0 0 0 2.475l.341.342-3.16 3.16a8 8 0 0 0-1.424 1.967 11.382 11.382 0 0 0-12.055 10.609c-.006.036-.011.074-.015.111a5.763 5.763 0 0 1-4.928 5.41 1.75 1.75 0 0 0-.844 3.14c4.844 3.619 9.4 4.915 13.338 4.915a17.14 17.14 0 0 0 11.738-4.545l.182-.167a11.354 11.354 0 0 0 3.348-8.081c0-.225-.02-.445-.032-.667a8.041 8.041 0 0 0 1.962-1.421l3.16-3.161.342.342a1.749 1.749 0 0 0 2.475 0l4.722-4.722c.011-.011.018-.025.029-.036s.023-.018.033-.029l51.844-57.46a6.236 6.236 0 0 0-.219-8.589zm-70.1 81.311l-.122.111c-.808.787-7.667 6.974-17.826 1.221a9.166 9.166 0 0 0 4.36-7.036 1.758 1.758 0 0 0 .036-.273 7.892 7.892 0 0 1 9.122-7.414c.017.005.031.014.048.019a1.717 1.717 0 0 0 .379.055 7.918 7.918 0 0 1 4 13.317zm5.239-10.131c-.093.093-.194.176-.293.26a11.459 11.459 0 0 0-6.289-6.286c.084-.1.167-.2.261-.3l3.161-3.161 6.321 6.326zm7.214-4.057l-9.479-9.479 2.247-2.247 9.479 9.479zm55.267-60.879l-50.61 56.092-9.348-9.348 56.092-50.61a2.737 2.737 0 0 1 3.866 3.866z" fill="#7D8590"></path>
      </svg>
      <a href="/api/users/all">Show all users</a>
  </button>

  <button class="value">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 128">
          <path d="M109.9 20.63a6.232 6.232 0 0 0-8.588-.22L43.849 72.253c-.012.011-.02.024-.031.035s-.023.017-.034.027L39.063 77.037a1.749 1.749 0 0 0 0 2.475l.341.342-3.16 3.16a8 8 0 0 0-1.424 1.967 11.382 11.382 0 0 0-12.055 10.609c-.006.036-.011.074-.015.111a5.763 5.763 0 0 1-4.928 5.41 1.75 1.75 0 0 0-.844 3.14c4.844 3.619 9.4 4.915 13.338 4.915a17.14 17.14 0 0 0 11.738-4.545l.182-.167a11.354 11.354 0 
          0 0 0 3.348-8.081c0-.225-.02-.445-.032-.667a8.041 8.041 0 0 0 1.962-1.421l3.16-3.161.342.342a1.749 1.749 0 0 0 2.475 0l4.722-4.722c.011-.011.018-.025.029-.036s.023-.018.033-.029l51.844-57.46a6.236 6.236 0 0 0-.219-8.589zm-70.1 81.311l-.122.111c-.808.787-7.667 6.974-17.826 1.221a9.166 9.166 0 0 0 4.36-7.036 1.758 1.758 0 0 0 .036-.273 7.892 7.892 0 0 1 9.122-7.414c.017.005.031.014.048.019a1.717 1.717 0 0 0 .379.055 7.918 7.918 0 0 1 4 13.317zm5.239-10.131c-.093.093-.194.176-.293.26a11.459 11.459 0 0 0-6.289-6.286c.084-.1.167-.2.261-.3l3.161-3.161 6.321 6.326zm7.214-4.057l-9.479-9.479 2.247-2.247 9.479 9.479zm55.267-60.879l-50.61 56.092-9.348-9.348 56.092-50.61a2.737 2.737 0 0 1 3.866 3.866z" fill="#7D8590"></path>
      </svg>
      <a href="/api/courses/new">Create A New Course</a>
  </button>

  <button class="value">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
          <path fill="#7D8590" d="M21.5 5.5h-19c-.28 0-.5-.22-.5-.5s.22-.5.5-.5h19c.28 0 .5.22.5.5s-.22.5-.5.5zm-19-3h13c.28 0 .5-.22.5-.5s-.22-.5-.5-.5h-13c-.28 0-.5.22-.5.5s.22.5.5.5zm19 8h-19c-.28 0-.5.22-.5.5s.22.5.5.5h19c.28 0 .5-.22.5-.5s-.22-.5-.5-.5zm0 4h-19c-.28 0-.5.22-.5.5s.22.5.5.5h19c.28 0 .5-.22.5-.5s-.22-.5-.5-.5zm0 4h-19c-.28 0-.5.22-.5.5s.22.5.5.5h19c.28 0 .5-.22.5-.5s-.22-.5-.5-.5zm0 3h-19c-.28 0-.5.22-.5.5s.22.5.5.5h19c.28 0 .5-.22.5-.5s-.22-.5-.5-.5z"></path>
          <circle cx="3.5" cy="4.5" r=".5" fill="#7D8590"></circle>
          <circle cx="3.5" cy="12" r=".5" fill="#7D8590"></circle>
          <circle cx="3.5" cy="16" r=".5" fill="#7D8590"></circle>
          <circle cx="3.5" cy="20" r=".5" fill="#7D8590"></circle>
      </svg>
      <a href="/register">Register a New User</a>
  </button>

<button class="value">
<a href="/api/instructor/add-course-to-user">Add A course To a user</a>
</button>
  <button class="value">
      <svg xmlns="" viewBox="0 0 128 128" width="24" height="24">
      </svg>
      <a href="/logout">Log Out</a>
  </button>
</div>

<div class="body">
    <div class="NewLoginClass">
        <div class="Login-text">
            <h1>We Ensure Better Education for a Better World</h1>
        </div>
        <div class="login-container">
            <!-- Register Form -->
            <div class="form1">
                <form:form action="${pageContext.request.contextPath}/user/register" method="post" modelAttribute="newUser">
                    <h2>Register</h2>
                    <div class="form-group">
                        <form:errors path="username" class="text-danger"/>
                        <form:input class="form-control" path="username" placeholder="Name"/>
                    </div>
                    <div class="form-group">
                        <form:errors path="email" class="text-danger"/>
                        <form:input class="form-control" path="email" placeholder="Email"/>
                    </div>
                    <div class="form-group">
                        <form:errors path="password" class="text-danger"/>
                        <form:input class="form-control" path="password" placeholder="Password" type="password"/>
                    </div>
                    <div class="form-group">
                        <form:errors path="confirm" class="text-danger"/>
                        <form:input class="form-control" path="confirm" placeholder="Confirm Password" type="password"/>
                    </div>
                    <button type="submit" class="btn btn-primary">Register</button>
                </form:form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
