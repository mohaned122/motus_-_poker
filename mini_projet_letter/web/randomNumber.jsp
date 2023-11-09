<%-- 
    Document   : randomNumber
    Created on : 23 oct. 2023, 21:48:17
    Author     : zayoud_mohanned
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.Math" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .carre{
                height: 90vh;
                width: 100%;
                background-color: mediumaquamarine;
                border-radius: 10px;
            }
            .carrep{
                height: 50vh;
                width: 80%;
                background-color: white;
                border-radius: 10px;
                margin-left: 10%;
                display: flex;
                justify-content: center;
                font-size: 18px;
            }
            div input{
                display: inline;
            }
            .form1{
                display: flex;
                justify-content: center;
            }
        </style>
    </head>
    <body>
        <div class="carre">
            <h1><center>Devine Mon Chiffre</center></h1>
            <p><center>en 10 tantative</center></p>
        <form action="./randomNumber.jsp" method="get">
            <div class="form1">
                <input type="number" name="choix">
                <button type="submit">Valider</button>
            </div>
        </form>
        <br>
            <div class="carrep">
                <%
                    if(session.getAttribute("lose")== null || session.getAttribute("machine")== null){
                        session.setAttribute("lose", "0");
                        session.setAttribute("machine", Integer.toString((int)(Math.random()*10)));
                    }
                    
                    int k=Integer.parseInt(session.getAttribute("machine").toString());
                    
                    if(request.getParameter("choix") != null){
                        int y = Integer.parseInt(request.getParameter("choix"));
                        
                        if(y == k){
                           out.println("you win"+k);
                           session.setAttribute("lose", "0");
                           session.setAttribute("machine", Integer.toString((int)(Math.random()*10)));
                        }else{
                           
                           if(Integer.parseInt(session.getAttribute("lose").toString()) <= 10){
                            int x= Integer.parseInt(session.getAttribute("lose").toString());
                            x++;
                            String str = Integer.toString(x);
                            session.setAttribute("lose",str);
                            for(int i=0;i<x;i++){
                               out.println("tentative"+i+": you lose");
                               out.println("<br>");
                            }
                           }else{
                             session.setAttribute("lose","0");
                             out.println("you lose your tentative.the value was "+k+" try "+"<a href='./randomNumber.jsp'>another game</a>");
                             session.setAttribute("machine", Integer.toString((int)(Math.random()*10)));
                            }
                        }
                    }
                    %>
            </div>
        </div>
    </body>
</html>
