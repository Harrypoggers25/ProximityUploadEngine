using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProximityUploadEngine
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void setLblUsername(string username)
        {
            lbl_username.Text = username;
        }
        public void updateProfilePicture()
        {

        }
        public void toggleLoginHiddenElement(bool hidden)
        {
            if (hidden)
            {
                pnl_mysidebar.Visible = false;
                pnl_hdrProfile.Visible = false;
            }
            else
            {
                pnl_mysidebar.Visible = true;
                pnl_hdrProfile.Visible = true;
            }
        }
        public Agency getAgencyFromSession()
        {
            var agency = new Agency();
            try
            {
                agency.id = Convert.ToInt32(Session["id"]);
                agency.name = Session["name"].ToString();
                agency.email = Session["email"].ToString();
                agency.password = Session["password"].ToString();
            }
            catch (Exception ex)
            {
                Response.Redirect("Default.aspx");
            }
            return agency;
        }
        public void updateSessionFromUser(Agency user)
        {
            Session["id"] = user.id;
            Session["name"] = user.name;
            Session["email"] = user.email;
            Session["password"] = user.password;
        }
    }
}