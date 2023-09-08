using Microsoft.Ajax.Utilities;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Remoting.Contexts;
using System.Text.Json.Serialization;
using System.Web;

namespace ProximityUploadEngine
{
    public class FileUploadHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            HttpPostedFile file = context.Request.Files["file"];
            var rect = context.Request["rect"] != null ? JsonConvert.DeserializeObject<Dictionary<string, int>>(context.Request["rect"]) : null;

            localSave(context, file, rect);
        }
        private void localSave(HttpContext context, HttpPostedFile file, Dictionary<string, int> rect)
        {
            if (file != null)
            {
                string fileName = rect != null ? $"{rect["x"]}_{rect["y"]}_{rect["w"]}{Path.GetExtension(file.FileName)}" : $"content{Path.GetExtension(file.FileName)}";
                string rel_filePath = rect != null ? "/sources/profile_pictures/_test/" : "/sources/contents/_test/";
                string abs_filePath = context.Server.MapPath("~" + rel_filePath);
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
                    file.SaveAs(fullFilePath);
                    //context.Response.ContentType = "application/json";
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("File Saved at: " + fullFilePath);
                    //context.Response.Write(JsonConvert.SerializeObject(rect));
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                }
            }
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
