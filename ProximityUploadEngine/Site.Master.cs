using System;
using System.Web.UI;

using ProximityUploadEngine.Database;

namespace ProximityUploadEngine
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        public void setLblUsername(string username)
        {
            //lbl_username.Text = username;
        }
        public void updateProfilePicture()
        {

        }
        public void toggleLoginHiddenElement(bool hidden)
        {
            //if (hidden)
            //{
            //    pnl_mysidebar.Visible = false;
            //    pnl_hdrProfile.Visible = false;
            //}
            //else
            //{
            //    pnl_mysidebar.Visible = true;
            //    pnl_hdrProfile.Visible = true;
            //}
        }
        public Agency getAgencyFromSession()
        {
            var agency = new Agency();
            try
            {
                agency.id = Convert.ToInt32(Session["id"]);
                agency.name = Session["name"].ToString();
                agency.credential.email = Session["email"].ToString();
                agency.credential.password = Session["password"].ToString();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
                Response.Redirect("Default.aspx");
            }
            return agency;
        }
        public void updateSessionFromUser(Agency user)
        {
            Session["id"] = user.id;
            Session["name"] = user.name;
            Session["email"] = user.credential.email;
            Session["password"] = user.credential.password;
        }
    }
}