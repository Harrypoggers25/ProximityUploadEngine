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
        protected void UploadImage_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string fileName = "profile_picture" + Path.GetExtension(FileUpload1.FileName);
                string rel_filePath = "/sources/profile_pictures/_test/";
                string abs_filePath = Server.MapPath("~" + rel_filePath);

                try
                {
                    if (!Directory.Exists(abs_filePath))
                    {
                        Directory.CreateDirectory(abs_filePath);
                    }
                    else
                    {
                        string[] filesToDelete = Directory.GetFiles(abs_filePath);
                        foreach (string fileToDelete in filesToDelete)
                        {
                            File.Delete(fileToDelete);
                        }
                    }

                    string fullFilePath = Path.Combine(abs_filePath, fileName);
                    FileUpload1.SaveAs(fullFilePath);
                    HiddenField1.Value = rel_filePath + fileName;
                    Image1.ImageUrl = HiddenField1.Value;
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                }
            }

        }
    }
}