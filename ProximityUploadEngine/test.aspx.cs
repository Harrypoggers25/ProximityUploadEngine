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
        //[WebMethod]
        //public static string UploadImage(HttpContext context)
        //{
        //    try
        //    {
        //        HttpPostedFile postedFile = context.Request.Files[0];
        //        if (uploadedFile != null && uploadedFile.ContentLength > 0)
        //        {
        //            string fileName = Path.GetFileName(uploadedFile.FileName);
        //            string savePath = HttpContext.Current.Server.MapPath("~/uploads/") + fileName;
        //            uploadedFile.SaveAs(savePath);
        //            return "{\"success\": true, \"message\": \"File uploaded successfully.\"}";
        //        }
        //        else
        //        {
        //            return "{\"success\": false, \"message\": \"No file uploaded.\"}";
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return "{\"success\": false, \"message\": \"Error: " + ex.Message + "\"}";
        //    }
        //}
    }
}