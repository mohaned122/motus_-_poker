<%-- 
    Document   : letter
    Created on : 28 oct. 2023, 15:59:35
    Author     : zayoud_mohanned
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            table{
                width: 100%;
                height: fit-content;
            }
            .body-game{
                height: 90vh;
                width: 100%;
                background: wheat;
            }
            .controller-game{
                display: flex;
                justify-content: center;
            }
            input{
                display: inline;
            }
        </style>
    </head>
    <body>
        <jsp:useBean id="service" class="bean.Service" scope="session"></jsp:useBean>
        <%!
        boolean win(String actual,String except){
            if(actual.equalsIgnoreCase(except)){
            return true;
        }
        return false;
        }
        String letterExiste(String except,String x,int nx){
          if(except.contains(x) && (except.indexOf(x) == nx || except.lastIndexOf(x) == nx)){
            return "<td style='background:green'>"+x.toString()+"</td>";
        }else if(except.contains(x) ){
        return "<td style='background:blue'>"+x.toString()+"</td>";
        }else{
        return "<td style='background:red'>"+x.toString()+"</td>";
        }
        }
        
        String printy(String winWord,String e){
             String str="<tr>";
             if(win(winWord,e)){
            str +="<td style='background:green'>"
            +e.charAt(0) +"</td><td style='background:green'>"
            +e.charAt(1)+"</td><td style='background:green'>"
            +e.charAt(2)+"</td><td style='background:green'>"
            +e.charAt(3)+"</td><td style='background:green'>"
            +e.charAt(4)+"</td><td style='background:green'>"
            +e.charAt(5)+"</td><td style='background:green'>"
            +e.charAt(6)+"</td><td style='background:green'>"
            +e.charAt(7)+"</td><td style='background:green'>"
            +e.charAt(8)+"</td><td style='background:green'>"
            +e.charAt(9)+"</td></tr>";
            }
            else{
            for(int i=0;i<10;i++){
            String l=e.charAt(i)+"";
            str += letterExiste(winWord,l,i);
        }
        str +="</tr>";
        }
        return str;
        }
        String description(String msg){
            return "<tr style='background:white' >"+msg+"</tr>";
        }
        %>
        <h1><center>letter Game</center></h1>
        <p><center>you have 10 tentative and all the word have 10letter</center></p>
<p><center>*rouge:n'existe pas *vert:exist et dans sa bon position *bleu: existe mais n'ai pas dans sa bon position</center></p>
<div class="game">
    <div class="controller-game">
    <form method="get" action="#" >
        <input type="text" size="10" name="exceptWord">
        <input type="submit" value="play">
    </form>
</div>
    <br>
<div class="body-game">
    <table>
        <%
             service.Connection();
            String str =service.getWord().get(0);
            
            if(request.getParameter("exceptWord") != null){
                String except = request.getParameter("exceptWord");
                session.setAttribute("list", except);
            }
            out.print(description(service.getWord().get(1)));
            String e ="          ";
            if(request.getParameter("exceptWord") != null){
                e=session.getAttribute("list").toString();
                service.insertTry(e,7);
            }
            boolean b = win(e,str);
            if(service.getAllTry().size()<= 10 && b == false){
            for(String s:service.getAllTry()){
                out.print(printy(str,s));
            }
            }else if(service.getAllTry().size()<= 10 && b){
            out.print("<br><tr> we have winner");
            service.remouveTry();
            }else{
            // lose
            out.print(description("you lose..!"));
            service.remouveTry();
            }
            
            %>
    </table>
</div>
</div>
    </body>
</html>
