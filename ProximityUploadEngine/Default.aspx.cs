using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics.Metrics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProximityUploadEngine
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            var master = (SiteMaster)this.Master;
            master.toggleLoginHiddenElement(true);

        }
        protected void btnLogin_click(object sender, EventArgs e)
        {
            var db = new AgencyData();

            if (db.IsAgencyExist(tb_username.Text))
            {
                if (db.IsAgencyPasswordCorrect(tb_username.Text, tb_password.Text))
                {
                    var agency = db.GetAgency(tb_username.Text);
                    var master = (SiteMaster)this.Master;
                    master.updateSessionFromUser(agency);
                    master.toggleLoginHiddenElement(false);
                    Response.Redirect("agencydashboard.aspx");
                }
            }
        }
    }
}