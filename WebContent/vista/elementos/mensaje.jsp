<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String mensaje = (String)session.getAttribute("mensaje");
    if(mensaje!=null&&mensaje!=""){%>
    <div style="font-size: 1.2em;" class="alert alert-<%=mensaje.split(";")[0] %> alert-dismissable mensaje">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <p class="text-center"><strong><%=mensaje.split(";")[1] %></strong> <%=mensaje.split(";")[2] %></p>
    </div>
<% session.removeAttribute("mensaje");} %>