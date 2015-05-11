using C_Connector;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

namespace WebFunc
{
    public class otpgen
    {
        public static void otpGen(string username)
        {
            SecuOTPService service = new SecuOTPService("https://secuotp-test.co.th", "5L44G-7XR1G-V5RAM-JC6KG");
            service.generateOneTimePassword(username);
        }
    }
}