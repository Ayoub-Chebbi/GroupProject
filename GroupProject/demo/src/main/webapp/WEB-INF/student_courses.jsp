<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Courses</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Custom CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<style>
  body {
    width: 100%;
    height: 100vh;
    background: linear-gradient(rgba(8, 0, 58, 0.7), rgba(8, 0, 58, 0.7)), url("https://www.thoughtco.com/thmb/U0oKRWkIdw_ZW_3KuDtjvqpMTYk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/IMG_1640-56aa5cde3df78cf772b0df57.jpg");
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    color: #fff;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
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
    z-index: 1000;
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
  }

  .table-container {
    width: 100%;
    overflow-x: auto;
  }

  .courses-table {
    width: 100%;
    border-collapse: collapse;
  }

  .courses-table th, .courses-table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
  }

  .courses-table th {
    background-color: #2ba8fb;
    color: white;
  }

  .courses-table tr:hover {
    background-color: #1a1a1a;
  }
</style>
<body>
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
          <svg xmlns="" viewBox="0 0 128 128" width="24" height="24"></svg>
          <a href="/logout">Logout</a>
        </button>
      </div>
      <div class="class2">   
        <div class="container">
          <div class="table-container">
            <table class="courses-table">
              <thead>
                <tr>
                  <th>Course Name</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="course" items="${courses}">
                  <tr>
                    <td><c:out value="${course.name}" /></td>
                    <td><c:out value="${course.description}" /></td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div> 
      </div>
    </div>
  </div>
</body>
</html>
