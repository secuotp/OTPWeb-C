<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="change.aspx.cs" Inherits="OTPWeb.change" %>

<%@ Import Namespace="C_Connector" %>
<%@ Import Namespace="WebFunc" %>
<%@ Import Namespace="System.Data.SqlClient"%>

<%    
    var username = "";
    if (Request.Cookies["cookie"] != null)
    {
        username = Request.Cookies["cookie"].Value;
        SecuOTPService migration = new SecuOTPService("https://secuotp-test.co.th", "5L44G-7XR1G-V5RAM-JC6KG");
        ServiceStatus status = migration.migrateOTP(username);
        int result = status.getStatusId();
        string code = "";
        
        if (result == 100 || result == 101)
        {
            SqlConnection con;
            SqlCommand sqlCommand;
            var auth = "Server=OTPTEST\\OTPWEBTEST;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            
            if (result == 100)
            {
                sqlCommand = new SqlCommand("UPDATE MemberAuthen SET otpmethod='sms', migrateCode='None' WHERE username='" + username + "'", con);
                sqlCommand.ExecuteNonQuery();
                con.Close();
%>
                <META HTTP-EQUIV="refresh" CONTENT="5;URL=member.aspx">
                Migration to SMS complete. - Please wait until this page redirected.
<%
            }
            else if (result == 101)
            {
                OTPMigration getMigrationCode = (OTPMigration)status.getData();
                code = getMigrationCode.getMigration();
                sqlCommand = new SqlCommand("UPDATE MemberAuthen SET otpmethod='mobile', migrateCode='" + code + "' WHERE username='" + username + "'", con);
                sqlCommand.ExecuteNonQuery();
                con.Close();
%>
                <META HTTP-EQUIV="refresh" CONTENT="5;URL=member.aspx">
                Migration to Mobile Applicaion complete. - Please wait until this page redirected.
<%
            }
        }
        else
        {
%>
            <META HTTP-EQUIV="refresh" CONTENT="5;URL=member.aspx">
            Migration failed. Please recheck back and try again.
<%   
        }
    }
    else
    {
%>
        <META HTTP-EQUIV="refresh" CONTENT="0;URL=index.html">
<%
    }
%>