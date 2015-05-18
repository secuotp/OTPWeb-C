using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebFunc
{
    public class verify
    {
        public static bool loginVerify(string username, string password)
        {
            SqlConnection con;
            SqlCommand sql;
            var auth = "Server=OTPTEST\\OTPWEBTEST;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            sql = new SqlCommand("select username from MemberAuthen where username='" + username + "' and password='" + password + "' COLLATE SQL_Latin1_General_Cp437_BIN", con);
            SqlDataReader reader = sql.ExecuteReader();
            bool result = reader.Read();
            reader.Close();

            return result;
        }

        public static string IsOTPEnabled(string username)
        {
            SqlConnection con;
            SqlCommand sql;
            var auth = "Server=OTPTEST\\OTPWEBTEST;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            sql = new SqlCommand("select otpenabled from MemberAuthen where username='" + username + "'", con);
            SqlDataReader reader = sql.ExecuteReader();
            reader.Read();
            string value = reader[0].ToString();
            reader.Close();

            return value;
        }

        public static SqlDataReader whatOTPMethod(string username)
        {
            SqlConnection con;
            SqlCommand sql;
            var auth = "Server=OTPTEST\\OTPWEBTEST;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            sql = new SqlCommand("select otpmethod from MemberAuthen where username='" + username + "'", con);
            SqlDataReader reader = sql.ExecuteReader();

            return reader;
        }

        public static SqlDataReader userDetails(string username)
        {
            SqlConnection con;
            SqlCommand sql;
            var auth = "Server=OTPTEST\\OTPWEBTEST;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            sql = new SqlCommand("select * from MemberDetails where username='" + username + "'", con);
            SqlDataReader reader = sql.ExecuteReader();

            return reader;
        }
    }
}