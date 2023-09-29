using Newtonsoft.Json;
using ProximityUploadEngine.Database;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.ModelBinding;
using System.Web.Services;

namespace ProximityUploadEngine
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["agency_hotels"] != null)
            //{
            //    var hotels = JsonConvert.DeserializeObject<List<Hotel>>(Session["agency_hotels"].ToString());
            //    cbl_hotel.Items.Clear();
            //    foreach (var hotel in hotels)
            //    {
            //        cbl_hotel.Items.Add(hotel.name);
            //    }
            //}
        }
        [WebMethod]
        public static string getAllAgency()
        {
            var agencyDb = new AgencyDb();
            var agencies = agencyDb.GetAllAgency();
            return JsonConvert.SerializeObject(agencies);
        }
        [WebMethod]
        public static string getAgencyAllClient(string email)
        {
            var agencyDb = new AgencyDb();
            var clients = agencyDb.GetAllClient(email);
            return JsonConvert.SerializeObject(clients);
        }
        [WebMethod]
        public static string getAllAgencyHotel(string email)
        {
            var agencyDb = new AgencyDb();

            return JsonConvert.SerializeObject(agencyDb.GetAllHotel(email));
        }
    }
}