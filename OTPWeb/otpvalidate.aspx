<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="otpvalidate.aspx.cs" Inherits="OTPWeb.otpvalidate" %>

<%@ Import Namespace="C_Connector" %>
<%@ Import Namespace="WebFunc" %>

<%
    var type = Request["type"];
    var username = Request["username"];
    var password = Request["password"];
    var otppass = Request["otppasswd"];

    int status = otpauthen.otpAuthen(username, otppass);
    
    if(status == 100){
        Response.Cookies["cookie"].Value = username;
        Response.Cookies["cookie"].Expires = DateTime.Now.AddMinutes(15);
%>
       <META HTTP-EQUIV="refresh" CONTENT="5;URL=member.aspx">
       Login successful. Please wait until this page redirect to member page.
<%
    }else{
%>
       <div style="text-align:center; padding: 10px 10px 10px 10px; border: 1px solid;">
            <form action="otpvalidate.aspx" method="post">
                <input type="hidden" name="username" value="<%=username%>" />
                <input type="hidden" name="password" value="<%=password%>" />
                <input type="hidden" name="type" value="<%=type%>" />
                Please enter OTP Password in the field below.<br/>
                <input type="text" name="otppasswd" /><br/>
                <h3 style="color:red;">Invalid OTP Password. Please type again.</h3><br/>
                <input type="submit" value="Validate" />
            </form>
        </div>
<%
    }
%>