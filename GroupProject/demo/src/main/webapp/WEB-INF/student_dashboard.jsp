<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>

    </style>
</head>
<body>
    <style>
        body {
           
            height: 100vh;
            margin: 0;
            background: linear-gradient(rgba(8, 0, 58, 0.7), rgba(8, 0, 58, 0.7)), url('./hero.png');
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
    .class1 {
        display: flex;
      justify-content: center;
      
      
      height: auto;
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
    }
    
    
    .class2{
        display: flex;
      justify-content: center;
      
      
      height: auto;
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
    
    }
    
    .container {
      display: flex;
      width: 100%;
      justify-content: center;
    }
    
    .dashboard1 {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 60px;
      justify-content: flex-start;
      padding: 50px;
      width: auto;
    }
    
    .card {
        background-color: #090a0a91;
        color: #00000061;
        width: 250;
        height: 320px;
        max-height: 800;
        border-radius: 10px;
        box-shadow: rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px;
        margin: 20px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    
    .card-img {
      height: 180px;
      display: flex;
      justify-content: center;
    }
    
    .card-img img {
        height: 100%;
        width: 100%;
        object-fit: cover;
        border-radius: 10px;
        box-shadow: rgba(37, 63, 89, 0.2) 0px 8px 24px;
    }
    
    .project-info {
      padding: 20px;
      display: flex;
      flex-direction: column;
      gap: 10px;
    }
    
    .project-title {
      font-weight: 500;
      font-size: 1.2em;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      color: rgb(255, 255, 255);
    }
    
    .lighter {
      font-size: 0.9em;
      color: aliceblue;
    }
    
    .flex {
        display: flex;
        align-content: center;
        flex-direction: row;
        flex-wrap: wrap;
    
    }
    
    .tag {
      font-weight: lighter;
      color: grey;
      font-size: 0.8em;
    }
    
    .card-buttons {
      display: flex;
      justify-content: space-between;
      padding: 10px;
    }
    
    button {
      padding: 10px 20px;
      border: 0;
      border-radius: 10px;
      background-color: #2ba8fb;
      color: #ffffff;
      font-weight: bold;
      transition: all 0.5s;
    }
    
    button:hover {
      background-color: #6fc5ff;
      box-shadow: 0 0 20px #6fc5ff50;
      transform: scale(1.1);
    }
    
    button:active {
      background-color: #3d94cf;
      transition: all 0.25s;
      box-shadow: none;
      transform: scale(0.98);
    }
    
    button .icon {
      margin-right: 5px;
    }
    
    /* New styles for the registration form */
    .formRe {
      display: flex;
      flex-direction: column;
      gap: 10px;
      height: 600px;
      width: 450px;
      padding: 20px;
      border-radius: 20px;
      position: relative;
      background-color: #1a1a1a;
      color: #fff;
      border: 1px solid #333;
      justify-content: space-between;
    }
    
    .title {
      font-size: 28px;
      font-weight: 600;
      letter-spacing: -1px;
      position: relative;
      display: flex;
      align-items: center;
      padding-left: 30px;
      color: #00bfff;
    }
    
    .title::before,
    .title::after {
      position: absolute;
      content: "";
      height: 16px;
      width: 16px;
      border-radius: 50%;
      left: 0px;
      background-color: #00bfff;
    }
    
    .title::before {
      width: 18px;
      height: 18px;
    }
    
    .title::after {
      width: 18px;
      height: 18px;
      animation: pulse 1s linear infinite;
    }
    
    .message,
    .signin {
      font-size: 14.5px;
      color: rgba(255, 255, 255, 0.7);
    }
    
    .signin {
      text-align: center;
    }
    
    .signin a:hover {
      text-decoration: underline royalblue;
    }
    
    .signin a {
      color: #00bfff;
    }
    
    .formRe label {
      position: relative;
    }
    
    .formRe label .inputrg {
      background-color: #333;
      color: #fff;
      width: 100%;
      padding: 20px 5px 5px 10px;
      outline: 0;
      border: 1px solid rgba(105, 105, 105, 0.397);
      border-radius: 10px;
    }
    
    .formRe label .inputrg + span {
      color: rgba(255, 255, 255, 0.5);
      position: absolute;
      left: 10px;
      top: 0px;
      font-size: 0.9em;
      cursor: text;
      transition: 0.3s ease;
    }
    
    .formRe label .inputrg:placeholder-shown + span {
      top: 12.5px;
      font-size: 0.9em;
    }
    .card-buttons {
      display: flex;
      justify-content: space-between;
      padding: 10px;
    
    }
    
    button {
      padding: 10px 20px;
      border: 0;
      border-radius: 10px;
      background-color: #2ba8fb;
      color: #ffffff;
      font-weight: bold;
      transition: all 0.5s;
    }
    
    button:hover {
      background-color: #6fc5ff;
      box-shadow: 0 0 20px #6fc5ff50;
      transform: scale(1.1);
    }
    
    button:active {
      background-color: #3d94cf;
      transition: all 0.25s;
      box-shadow: none;
      transform: scale(0.98);
    }
    
    button .icon {
      margin-right: 5px; /* Add some space between the icon and text */
    }
    .add {
        display: flex;
        align-items: flex-end;
        justify-content: space-evenly;
    }
    .card-buttons a{
    
        color: #0d1117;
    }
     .add a{
        color: #0d1117;
    }
    .Login-text {
  text-align: center;
  max-width: 800px;
  margin-bottom: 2em;
}

.Login-text h1 {
  font-size: 100px;
  font-weight: 100;
}

.Login-text p{  
  
  font-size: 50px;
  font-weight: 100;}



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
                    <svg xmlns="" viewBox="0 0 128 128" width="24" height="24">
                    </svg>
                    courses
                </button>
    
    
    
                <button class="value">
                    <svg xmlns="" viewBox="0 0 128 128" width="24" height="24">
                    </svg>
                    Logout
                </button>
            </div>
        
    
    
            <div class="class2">   
    
               

              <div class="Login-text">
                <h1>Welcome, Student!</h1>
                <p>You have successfully logged in.</p>
                <p>Here are your courses and other details.</p>       
            </div>


                    
    
                        

             
         </div> 
         
    
    </div>
</body>
</html>



