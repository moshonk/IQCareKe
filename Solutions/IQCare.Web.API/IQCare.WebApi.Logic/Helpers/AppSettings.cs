using Microsoft.Extensions.Configuration;
using System.ComponentModel;
using System.Configuration;

namespace IQCare.WebApi.Logic.Helpers
{
    public class AppSettings
    {
        IConfiguration _configuration;

        public static string IlServer()
        {
            return ConfigurationManager.AppSettings.Get("ilServer");
        }

        public static string EnableOutgoingMessages()
        {
            return _configuration.GetSection("ILServer").GetSection("ilEnableOutgoingMessages").Value;

            //return ConfigurationManager.AppSettings.Get("ilEnableOutgoingMessages");
        }

        public static string ProcessIncomingMessages()
        {
            return ConfigurationManager.AppSettings.Get("ilProcessIncomingMessages");
        }

    }

    public enum Senders
    {
        ADT = 1,
        T4A,
        MLAB,
        [Description("MLAB SMS APP")]
        MLAB_SMS_APP,
        KENYAEMR
    }
}
