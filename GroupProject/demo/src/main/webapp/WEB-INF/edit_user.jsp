<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css' />">
</head>
<body>


  <style>
      body {
         
          height: 100vh;
          margin: 0;
          background: linear-gradient(rgba(8, 0, 58, 0.7), rgba(8, 0, 58, 0.7)), url("https://www.thoughtco.com/thmb/U0oKRWkIdw_ZW_3KuDtjvqpMTYk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/IMG_1640-56aa5cd….jpg");
      }
  
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
      /* General styles */
.create {
  display: flex;
  align-items: center;
  justify-content: center;
 
  
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

.createform {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  padding: 20px;
}

/* Form styles */
.formCo {
  display: flex;
  flex-direction: column;
  gap: 10px;
  height: auto;
  width: 450px;
  padding: 20px;
  border-radius: 20px;
  position: relative;
  background-color: #1a1a1a;
  color: #fff;
  border: 1px solid #333;
  justify-content: space-between;
}

/* Style for labels and inputs */
.formCo label {
  position: relative;
  display: block;
  margin-bottom: 20px;
}

.formCo label input.inputrg,
.formCo label select.inputrg { /* Apply the same styles to select */
  background-color: #333;
  color: #fff;
  width: 100%; /* Make the select element the same width as input */
  padding: 12px;
  outline: none;
  border: 1px solid rgba(105, 105, 105, 0.397);
  border-radius: 10px;
  transition: border-color 0.3s ease;
}

.formCo label input.inputrg:focus,
.formCo label select.inputrg:focus { /* Apply focus style to select */
  border-color: #00bfff;
}

.formCo label span {
  color: rgba(255, 255, 255, 0.5);
  position: absolute;
  left: 15px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 0.9em;
  cursor: text;
  transition: top 0.3s, font-size 0.3s;
}

.formCo label input.inputrg::placeholder,
.formCo label select.inputrg::placeholder { /* Apply placeholder style to select */
  color: rgba(255, 255, 255, 0.5);
}

.formCo label input.inputrg:focus + span,
.formCo label input.inputrg:valid + span,
.formCo label select.inputrg:focus + span,
.formCo label select.inputrg:valid + span { /* Apply focus style to select */
  color: #00bfff;
  top: 0;
  font-size: 0.8em;
  font-weight: 600;
}

/* File drop styles */
.form6 {
  background-color: #fff;
  box-shadow: 0 10px 60px rgb(218, 229, 255);
  border: 1px solid rgb(159, 159, 160);
  border-radius: 20px;
  padding: 20px;
  text-align: center;
  font-size: 1.125rem;
  max-width: 320px;
}

.form-title {
  color: #000000;
  font-size: 1.8rem;
  font-weight: 500;
}

.form-paragraph {
  margin-top: 10px;
  font-size: 0.9375rem;
  color: rgb(105, 105, 105);
}

.drop-container {
  background-color: #fff;
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 20px;
  margin-top: 20px;
  border-radius: 10px;
  border: 2px dashed rgb(171, 202, 255);
  color: #444;
  cursor: pointer;
  transition: background .2s ease-in-out, border .2s ease-in-out;
}

.drop-container:hover {
  background: rgba(0, 140, 255, 0.164);
  border-color: rgba(17, 17, 17, 0.616);
}

.drop-container:hover .drop-title {
  color: #222;
}

.drop-title {
  color: #444;
  font-size: 20px;
  font-weight: bold;
  text-align: center;
  transition: color .2s ease-in-out;
}

#file-input {
  display: none;
}

/* Submit button styles */
.submit {
  border: none;
  outline: none;
  padding: 12px 24px;
  border-radius: 10px;
  color: #fff;
  font-size: 16px;
  background-color: #00bfff;
  cursor: pointer;
  transition: background-color 0.3s ease;
  margin-top: 20px;
}

.submit:hover {
  background-color: #00bfff96;
}
.fille{

  display: flex;
  align-items: center;
  justify-content: center;
  align-content: center;
}
      
      
      
      
      
      
      </style>
<div class="class1">

<div class="Nav">

    <div class="navbar">
        <button class="value">
            <svg data-name="Layer 2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16">
                <path d="M1.5 13v1a.5.5 0 0 0 .3379.4731A18.9718 18.9718 0 0 0 8 15.5a18.9629 18.9629 0 0 0 6.1621-1.0269.5.5 0 0 0 .3379-.4731v-1a6.5083 6.5083 0 0 0-4.461-6.1676 3.5 3.5 0 1 0-4.078 0A6.5083 6.5083 0 0 0 1.5 13zm4-9a2.5 2.5 0 1 1 2.5 2.5A2.5026 2.5026 0 0 1 5.5 4zm2.5 3.5a5.5066 5.5066 0 0 1 5.5 5.5v.6392a18.08 18.08 0 0 1-11 0v-.6392A5.5066 5.5066 0 0 1 8 7.5z" fill="#7D8590"></path>
            </svg>
            Dashboard
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
            <svg xmlns="" viewBox="0 0 128 128" width="24" height="24">
            </svg>
            Logout
        </button>
    </div>










          <div class="create">
              <div class="createform">
                <form:form method="POST" modelAttribute="user" action="${pageContext.request.contextPath}/api/users/${user.id}/edit">
                      
                      <div class="formCo">
                          <h1>Edit Course Form</h1>
                          <label >Email:
                              <input class="inputrg">
                              <form:label path="email"></form:label>
                              <form:input path="email" class="form-control"/>
                              
                          </label>


                          <label >Password:
                            <input class="inputrg">
                            <form:label path="password">Password</form:label>
                            <form:input path="password" class="form-control" type="password"/>
                            
                        </label>
                        
                        <label >Roles:
                          <input class="inputrg">
                          <form:label path="roles"></form:label>
                          <form:checkboxes path="roles" items="${roles}" itemLabel="name" itemValue="name"/>
                          
                      </label>



                          <label >Courses:
                              <input class="inputrg">
                              <form:label path="courses"></form:label>
                              <form:checkboxes path="courses" items="${courses}" itemLabel="name" itemValue="id"/>
                              
                          </label>

                          <button type="submit" class="submit">Update</button>
                      </div>
                  </form:form>
              </div>
          </div>

      </div>
      </div>   
</body>
</html>








