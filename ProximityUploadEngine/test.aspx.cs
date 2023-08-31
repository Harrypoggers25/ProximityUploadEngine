using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProximityUploadEngine
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        //protected void UploadImage_Click(object sender, EventArgs e)
        //{
        //    if (fu_imgUploadHandler.HasFile)
        //    {
        //        string fileName = "profile_picture" + Path.GetExtension(fu_imgUploadHandler.FileName);
        //        string rel_filePath = "/sources/profile_pictures/_test/" + fileName;

        //        updateImage(img_profilePicture, fileName, rel_filePath);
        //    }
        //}
        //public void updateImage(Image img, string fileName, string rel_filePath)
        //{
        //    string abs_filePath = Server.MapPath("~" + rel_filePath);
        //    fu_imgUploadHandler.SaveAs(abs_filePath);

        //    img.ImageUrl = rel_filePath;
        //    using (System.Drawing.Image imgSrc = System.Drawing.Image.FromFile(abs_filePath))
        //    {
        //        int srcWidth = imgSrc.Width;
        //        int srcHeight = imgSrc.Height;
        //        if (srcHeight >= srcWidth)
        //        {
        //            img.Style["height"] = "auto";
        //            img.Style["width"] = "100%";
        //        }W
        //        else
        //        {
        //            img.Style["width"] = "auto";
        //            img.Style["height"] = "100%";
        //        }
        //    }
        //}

    }
}