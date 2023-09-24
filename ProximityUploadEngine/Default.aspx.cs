using System;
using System.Web.UI;

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
                    Response.Redirect("Dashboard.aspx");
                }
            }
        }
    }
}