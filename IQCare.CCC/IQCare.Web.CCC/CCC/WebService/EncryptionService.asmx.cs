using Application.Common;
using Application.Presentation;
using Interface.Security;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Protocols;

namespace IQCare.Web.CCC.WebService
{
    /// <summary>
    /// Summary description for EncryptionService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class EncryptionService : System.Web.Services.WebService
    {
        private string Msg { get; set; }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public IEnumerable<UserInformation> GetUserInformation()
        {
            List<UserInformation> userList = new List<UserInformation>();
            IUser _usr = (IUser) ObjectFactory.CreateInstance("BusinessProcess.Security.BUser, BusinessProcess.Security");

            Utility util = new Utility();

            DataTable dt = _usr.GetAllUserInformation();
            try
            {
                if (dt != null)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        UserInformation userInformation = new UserInformation();
                        userInformation.Username = dt.Rows[i]["username"].ToString();
                        String password = util.Decrypt(dt.Rows[i]["password"].ToString());
                        userInformation.Password = password;
                        userInformation.Role = dt.Rows[i]["role"].ToString();
                        userInformation.Deleted = dt.Rows[i]["deleted"].ToString();
                        userList.Add(userInformation);
                    }
                }

            }
            catch (SoapException e)
            {
                Msg = e.Message;
            }
            IEnumerable<UserInformation> allUserInformation = userList;

            return allUserInformation;
        }
    }
}

public class UserInformation
{
    public string Username { get; set; }
    public string Password { get; set; }
    public string Role { get; set; }
    public string Deleted { get; set; }
}