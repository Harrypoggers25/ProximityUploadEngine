using System;
using System.IO;

namespace ProximityUploadEngine
{
    public partial class Settings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var master = (SiteMaster)this.Master;
            var agency = master.getAgencyFromSession();
            master.setLblUsername(agency.name);

            tb_email.Text = agency.email;
            lbl_username1.Text = agency.name;

            if (!IsPostBack)
            {
                tb_username.Text = agency.name;
            }
        }
        protected void UploadImage_Click(object sender, EventArgs e)
        {
            if (fu_imgUploadHandler.HasFile)
            {
                string fileName = "profile_picture" + Path.GetExtension(fu_imgUploadHandler.FileName);
                string rel_filePath = "/sources/profile_pictures/_test/" + fileName;
                string abs_filePath = Server.MapPath("~" + rel_filePath);
                fu_imgUploadHandler.SaveAs(abs_filePath);

                img_profilePicture.ImageUrl = rel_filePath;
                using (System.Drawing.Image img = System.Drawing.Image.FromFile(abs_filePath))
                {
                    int srcWidth = img.Width;
                    int srcHeight = img.Height;
                    if (srcHeight >= srcWidth)
                    {
                        img_profilePicture.Style["height"] = "auto";
                        img_profilePicture.Style["width"] = "100%";
                    }
                    else
                    {
                        img_profilePicture.Style["width"] = "auto";
                        img_profilePicture.Style["height"] = "100%";
                    }
                }
            }
        }
    }
}