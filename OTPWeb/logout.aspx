<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="logout.aspx.cs" Inherits="OTPWeb.logout" %>
<%
    var username = Request["username"];
    var cookie = Request.Cookies["cookie"].ToString();

    if (username.Equals(cookie))
    {
        Response.Cookies["cookie"].Expires = DateTime.Now.AddMilliseconds(-1);
%>
    <META HTTP-EQUIV="refresh" CONTENT="1;URL=index.html">
<%
    }
    else
    {
        Session.Abandon();
%>
    <META HTTP-EQUIV="refresh" CONTENT="1;URL=index.html">
<%
    }
%>
