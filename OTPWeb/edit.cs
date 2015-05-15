using C_Connector;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Text;
using System.Web;

namespace WebFunc
{
    public class edit
    {
        public static bool editUser(string username, string fname, string lname, string email, string mobile)
        {
            string sql = "UPDATE MemberDetails SET fname='" + fname + "', lname='" + lname + "', email='" + email + "',"
                         + "pnumber='" + mobile + "' WHERE username='" + username + "'";
            SqlConnection con;
            SqlCommand sqlCommand;
            var auth = "Server=POLWATH-2-PC\\POLWATH;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            sqlCommand = new SqlCommand(sql, con);
            int resultDetails = sqlCommand.ExecuteNonQuery();

            if (resultDetails == 1)
                return true;
            else
                return false; 
        }

        public static bool changeOTPMethod(string username, string otp)
        {
            string otpenabled = "", otpmethod = "";
            if (otp.Equals("mphone"))
            {
                otpenabled = "1"; otpmethod = "mobile";
            }
            else if (otp.Equals("sms"))
            {
                otpenabled = "1"; otpmethod = "sms";
            }
            else if (otp.Equals("disable"))
            {
                otpenabled = "0";
            }

            string sql = "UPDATE MemberAuthen SET otpenabled='" + otpenabled + "', otpmethod='" + otpmethod + "' WHERE username='" + username + "'";

            SqlConnection con;
            SqlCommand sqlCommand;
            var auth = "Server=POLWATH-2-PC\\POLWATH;UID=admin;PASSWORD=polwath2534psa1991;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            sqlCommand = new SqlCommand(sql, con);
            int resultDetails = sqlCommand.ExecuteNonQuery();

            if (resultDetails == 1)
                return true;
            else
                return false;
        }

        public static bool editPasswd(string username, string curPasswd, string newPasswd, string rePasswd)
        {
            SqlConnection con;
            SqlCommand sqlCommand, sqlCommand2;
            var auth = "Server=POLWATH-2-PC\\POLWATH;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            sqlCommand = new SqlCommand("select password from MemberAuthen where username='" + username + "' COLLATE SQL_Latin1_General_Cp437_BIN", con);
            SqlDataReader reader = sqlCommand.ExecuteReader();
            reader.Read();
            string passwd = reader[0].ToString();
            reader.Close();

            if (curPasswd.Equals(passwd) && newPasswd.Equals(rePasswd))
            {
                sqlCommand2 = new SqlCommand("UPDATE MemberAuthen SET password='" + newPasswd + "' WHERE username='" + username + "'", con);
                int resultDetails = sqlCommand2.ExecuteNonQuery();
                con.Close();

                if (resultDetails == 1)
                    return true;
                else
                    return false;
            }
            return false;
        }

        public static int disableOTP(string username, string removalCode)
        {
            SecuOTPService changeotp = new SecuOTPService("https://secuotp-test.co.th", "5L44G-7XR1G-V5RAM-JC6KG");
            ServiceStatus status = changeotp.disableEndUser(username,removalCode);
            return status.getStatusId();
        }

        public static int enableOTP(string username, string email, string firstName, string lastName, string phone)
        {
            SecuOTPService changeotp = new SecuOTPService("https://secuotp-test.co.th", "5L44G-7XR1G-V5RAM-JC6KG");
            ServiceStatus status = changeotp.registerEndUser(username,email,firstName,lastName,phone);
            return status.getStatusId();
        }
    }
}