<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="member.aspx.cs" Inherits="OTPWeb.member" %>
<%@ Import Namespace="WebFunc" %>
<%@ Import Namespace="C_Connector" %>
<%@ import Namespace="System.Data.SqlClient" %>
<%
    
    
    var username = "";
    if (Request.Cookies["cookie"] != null)
    {
        username = Request.Cookies["cookie"].Value;
        SqlDataReader data = verify.userDetails(username);
        data.Read();
        string uname = data[1].ToString();
        string fname = data[2].ToString();
        string lname = data[3].ToString();
        string email = data[4].ToString();
        string phone = data[5].ToString();

        string code = migrateCode.getMigrateCode(username);

        SqlDataReader otp = verify.whatOTPMethod(username);
        otp.Read();
        string otpmethod = otp[0].ToString();

        SecuOTPService userdata = new SecuOTPService("https://secuotp-test.co.th", "5L44G-7XR1G-V5RAM-JC6KG");
        ServiceStatus status = userdata.getUserData(username, 1);
        User u = (User)status.getData();
%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>
    <form action="logout.aspx" method="post">
    <div>
        Welcome, <%=username%>. <br/><br />
        <table>
            <tr>
                <td>Firstname</td><td>:</td><td><%=fname%></td>
            </tr>
            <tr>
                <td>Lastname</td><td>:</td><td><%=lname%></td>
            </tr>
            <tr>
                <td>E-mail</td><td>:</td><td><%=email%></td>
            </tr>
            <tr>
                <td>OTP Method</td><td>:</td>
                <td><%=otpmethod%>
                    <%if(otpmethod.Equals("mobile")){%>
                            <input type="button" value="Change to SMS" onclick="location.href='change.aspx'" />
                    <%} else if(otpmethod.Equals("sms")){ %>
                            <input type="button" value="Change to Mobile Phone" onclick="location.href='change.aspx'" />
                    <%} %>
                    <br />
                </td>
            </tr>
            <tr>
                <td>Phone number</td><td>:</td><td><%=phone%></td>
            </tr>
            <%if(otpmethod.Equals("mobile")){%>
            <tr>
                <td>Migration Code</td><td>:</td><td><%=code%></td>
            </tr>
            <%}%>
            <tr>
                <td>Serial Number</td><td>:</td><td><%=u.getSerialNumber()%></td>
            </tr>
            <tr>
                <td>Removal Code</td><td>:</td><td><%=u.getRemovalCode()%></td>
            </tr>
        </table>
        <br />
        <a href="EditUser.aspx">Edit your data</a>
        <br /><br />
        <input type="hidden" value="<%=username%>" name="username">
        <input type="submit" value="Logout">
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
