using System;
using System.Configuration;
using Npgsql;
using System.Data;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Web.Services;
using System.Runtime.InteropServices;
using System.Linq;
using System.Reflection;
using System.Web.Script.Serialization;
using System.Data.Common;
using Newtonsoft.Json;
using System.Web.Script.Services;

namespace ProximityUploadEngine
{
    public partial class AdminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var master = (SiteMaster)this.Master;

        }
        [WebMethod]
        public static string GetAllAgency()
        {
            var db = new AgencyData();
            List<Agency> agencies = db.GetAllAgency();
            return JsonConvert.SerializeObject(agencies);
        }
        [WebMethod]
        public static void DeleteAgency(int id)
        {
            var db = new AgencyData();
            db.DeleteAgency(id);
        }
    }
}