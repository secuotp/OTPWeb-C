<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="OTPWeb.EditUser" %>
<%@ Import Namespace="WebFunc" %>
<%@ import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<%
    var username = "";
    if (Request.Cookies["cookie"] != null)
    {
        username = Request.Cookies["cookie"].Value;
        SqlDataReader data = verify.userDetails(username);
        bool otp = verify.IsOTPEnabled(username);
        SqlDataReader method = verify.whatOTPMethod(username);
        data.Read();
        string uname = data[1].ToString();
        string fname = data[2].ToString();
        string lname = data[3].ToString();
        string email = data[4].ToString();
        string phone = data[5].ToString();
        method.Read();
        string otpmethod = method[0].ToString();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit user data</title>
</head>
<body>
Edit user: <%=uname%><br /><br />
<form action="process.aspx" method="post">
                <input type="hidden" name="type" value="edit"/>
                <input type="hidden" name="username" value="<%=username%>" />
                <div style="float: left; width: 150px; line-height: 26.5px; ">
                    Firstname 
                    <br />
                    Lastname
                    <br />
                    Email
                    <br />
                    Phone Number
                    <br />
                    Current Password
                    <br />
                    Renew Password
                    <br />
                    Re-type Password
                </div>
                <div style="float: left; margin: 0px 10px 0px 0px; line-height: 26.5px; ">
                    : 
                    <br />
                    : 
                    <br />
                    : 
                    <br />
                    : 
                    <br />
                    : 
                    <br />
                    : 
                    <br />
                    : 
                </div>
                <div style="float: left; line-height: 26.5px; ">
                    <input type="text" name="fname" value="<%=fname%>" />
                    <br>
                    <input type="text" name="lname" value="<%=lname%>" />
                    <br>
                    <input type="email" name="email" value="<%=email%>" />
                    <br>
                    <input type="text" name="phone" value="<%=phone%>" />
                    <br/>
                    <input type="password" name="curpasswd" />
                    <br>
                    <input type="password" name="newpasswd" />
                    <br>
                    <input type="password" name="repasswd" />
                </div>
                <div style="padding-top: 10px; clear: left;">
                    <input type="submit" value="Edit Data" /> | <a href="member.aspx">Back</a>
                </div>
</form>
</body>
</html>
<%
    }else{
%>
    <META HTTP-EQUIV="refresh" CONTENT="0;URL=index.html">
<%
    }
%>
