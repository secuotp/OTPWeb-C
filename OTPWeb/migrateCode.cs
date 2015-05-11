using System.Data.SqlClient;
namespace WebFunc
{
    public class migrateCode
    {
        public static string getMigrateCode(string username)
        {
            SqlConnection con;
            SqlCommand sql;
            var auth = "Server=POLWATH-2-PC\\POLWATH;UID=admin;PASSWORD=test;Database=Member;Max Pool Size=400;Connect Timeout=600;";
            con = new SqlConnection(auth);
            con.Open();
            sql = new SqlCommand("select migrateCode from MemberAuthen where username='" + username + "' COLLATE SQL_Latin1_General_Cp437_BIN", con);
            SqlDataReader reader = sql.ExecuteReader();
            reader.Read();
            string code = reader.GetString(0);

            return code;
        }
    }
}