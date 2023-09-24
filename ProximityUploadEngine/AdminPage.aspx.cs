using System;
using System.Collections.Generic;
using System.Web.Services;
using Newtonsoft.Json;

using ProximityUploadEngine.Database;

namespace ProximityUploadEngine
{
    public partial class AdminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var master = (SiteMaster)this.Master;
        }
        [WebMethod]
        public static void createAgency(Agency agency)
        {
            var db = new AgencyData();
            db.CreateAgency(agency);
        }
        [WebMethod]
        public static string GetAllAgency()
        {
            var db = new AgencyData();
            List<Agency> agencies = db.GetAllAgency();
            return JsonConvert.SerializeObject(agencies);
        }
        [WebMethod]
        public static string getFirstEmptyId()
        {
            var db = new AgencyData();
            return JsonConvert.SerializeObject(db.GetFirstEmptyAgency());
        }
        [WebMethod]
        public static void updateAgency(Agency agency)
        {
            var db = new AgencyData();
            db.UpdateAgency(agency);
        }
        [WebMethod]
        public static void deleteAgency(int id)
        {
            var db = new AgencyData();
            db.DeleteAgency(id);
        }
    }
}