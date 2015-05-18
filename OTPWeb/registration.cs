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
    public class registration
    {
        public static bool regisCheck(string username)
        {
            SqlConnection con;
            SqlCommand sql, sql2;
            var auth = "Server=OTPTEST\\OTPWEBTEST;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            sql = new SqlCommand("select username from MemberDetails where username='" + username + "' COLLATE SQL_Latin1_General_Cp437_BIN", con);
            sql2 = new SqlCommand("select username from MemberAuthen where username='" + username + "' COLLATE SQL_Latin1_General_Cp437_BIN", con);
            SqlDataReader reader = sql.ExecuteReader();
            bool result = reader.Read();
            reader.Close();
            SqlDataReader reader2 = sql2.ExecuteReader();
            bool result2 = reader2.Read();
            reader2.Close();

            if ((result == true && result2 == true) ||
                (result == true && result2 == false) ||
                (result == false && result2 == true))
                return true;
            else
                return false;
        }

        public static bool regis(
            string username, string password, string fname, 
            string lname, string email, string pnumber)
        {
            SqlConnection con;
            SqlCommand count, sql, sql2;
            var auth = "Server=OTPTEST\\OTPWEBTEST;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            count = new SqlCommand("select count(*) from MemberDetails",con);
            count.CommandType = CommandType.Text;
            int counts = (int)count.ExecuteScalar();
            sql = new SqlCommand("insert into MemberDetails (id,username,fname,lname,email,pnumber) values"+
                "("+(counts+1)+",'"+username+"','"+fname+"','"+lname+"','"+email+"','"+pnumber+"')", con);
            int resultDetails = sql.ExecuteNonQuery();
            sql2 = new SqlCommand("insert into MemberAuthen (id,username,password,otpenabled,otpmethod,migratecode) values "+
                "(" + (counts+1) + ",'" + username + "','" + password + "', 1,'sms','None')", con);
            int resultAuthen = sql2.ExecuteNonQuery();

            if (resultAuthen == 1 & resultDetails == 1)
                return true;
            else
                return false;
        }

        public static int enableOTP(
            string username, string fname,
            string lname, string email, string pnumber)
        {
            SecuOTPService service = new SecuOTPService("https://secuotp-test.co.th", "5L44G-7XR1G-V5RAM-JC6KG");
            ServiceStatus status = service.registerEndUser(username, email, fname, lname, pnumber);
            return status.getStatusId();
        }

        public static void disableOTP(string username){
            SqlConnection con;
            SqlCommand sql;
            var auth = "Server=OTPTEST\\OTPWEBTEST;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            sql = new SqlCommand("update MemberAuthen set otpenabled=0 where username='" + username + "' COLLATE SQL_Latin1_General_Cp437_BIN", con);
            sql.ExecuteNonQuery();
        }
    }
}