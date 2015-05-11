<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="process.aspx.cs" Inherits="OTPWeb.WebForm1" %>
<%@ Import Namespace="C_Connector" %>
<%@ Import Namespace="WebFunc" %>
<%@ import Namespace="System.Data.SqlClient" %>

<%    
    var type = Request["type"];

    if(type.Equals("login")){
        var username = Request["user"];
        var password = Request["pass"];
        bool check = verify.loginVerify(username, password);
        bool otp = verify.IsOTPEnabled(username);
        
        if (check == true && otp == true)
        {
            SqlDataReader otpType = verify.whatOTPMethod(username);
            otpType.Read();
            string otpmethod = otpType[0].ToString();
            
            if (otpmethod.Equals("sms"))
            {
                otpgen.otpGen(username);
            }
%>
            <div style="text-align:center; padding: 10px 10px 10px 10px; border: 1px solid;">
                <form action="otpvalidate.aspx" method="post">
                    <input type="hidden" name="username" value="<%=username%>" />
                    <input type="hidden" name="password" value="<%=password%>" />
                    <input type="hidden" name="type" value="<%=type%>" />
                    Please enter OTP Password in the field below.<br/>
                    <input type="text" name="otppasswd" /><br/>
                    <input type="submit" value="Validate" />
                </form>
            </div>
<%
            } else if (check == true && otp == false)
            {
                Response.Cookies["cookie"].Value = username;
                Response.Cookies["cookie"].Expires = DateTime.Now.AddMinutes(15);
%>
       <META HTTP-EQUIV="refresh" CONTENT="5;URL=member.aspx">
       Login successful. Please wait until this page redirect to member page.
<%
            }
            else
            {
%>
                <META HTTP-EQUIV="refresh" CONTENT="5;URL=index.html">
                Login unsuccessful.
<%
            }
    }else if(type.Equals("register")){
        var username = Request["user"];
        var password = Request["pass"];
        var repassword = Request["repass"];
        var fname = Request["fname"];
        var lname = Request["lname"];
        var email = Request["email"];
        var pnumber = Request["pnumber"];

        bool check = registration.regisCheck(username);
        
        if (check == true || !password.Equals(repassword)){
%>
            <META HTTP-EQUIV="refresh" CONTENT="5;URL=index.html">
            Register failed - Password mismatch or username already exists.
<%
        }
        else
        {
            bool regisCheck = registration.regis(username, password, fname, lname, email, pnumber);
            if (regisCheck == true)
            {
                int regisStatus = registration.enableOTP(username, fname, lname, email, pnumber);
                if(regisStatus == 100){
%>
                        <META HTTP-EQUIV="refresh" CONTENT="5;URL=index.html">
                        Register completed. Please wait for redirect to login page.
<%
                }else{
                        registration.disableOTP(username);
%>
                        <META HTTP-EQUIV="refresh" CONTENT="5;URL=index.html">
                        Register completed but failed to enable OTP service.<br/>
                        Please wait for redirect to login page.
<%
                }
            }
            else
            {
%>
                <META HTTP-EQUIV="refresh" CONTENT="5;URL=index.html">
                Register failed - Process interrupted when registration in progress.
<%
            }
        }
    } if (type.Equals("edit")){
        string username = Request["username"];
        string fname = Request["fname"];
        string lname = Request["lname"];
        string email = Request["email"];
        string pnumber = Request["phone"];
        string curpassword = Request["curpasswd"];
        string newpassword = Request["newpasswd"];
        string repassword = Request["repasswd"];

        if (curpassword != "" && newpassword != "" && repassword != "")
        {
            bool editUser = edit.editUser(username, fname, lname, email, pnumber);
            bool changePasswd = edit.editPasswd(username, curpassword, newpassword, repassword);
            if (editUser != false && changePasswd != false)
            {
%>
                <META HTTP-EQUIV="refresh" CONTENT="5;URL=member.aspx">
                Edit complete - Please wait until this page redirected.
<%
            }
            else
            {
%>
                <META HTTP-EQUIV="refresh" CONTENT="5;URL=member.aspx">
                Edit failed - Please check data in fields and password before submit.
<%                
            }
        }
        else
        {
            bool editUser = edit.editUser(username, fname, lname, email, pnumber);
            if (editUser != false)
            {
%>
                <META HTTP-EQUIV="refresh" CONTENT="5;URL=member.aspx">
                Edit complete - Please wait until this page redirected.
<%
            }
            else
            {
%>
                <META HTTP-EQUIV="refresh" CONTENT="5;URL=member.aspx">
                Edit failed - Please check data in fields before submit.
<%   
            }
        }
    }
%>