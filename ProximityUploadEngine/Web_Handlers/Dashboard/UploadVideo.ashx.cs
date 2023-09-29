using Newtonsoft.Json;
using ProximityUploadEngine.Database;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace ProximityUploadEngine.Web_Handlers.Dashboard
{
    /// <summary>
    /// Summary description for UploadVideo
    /// </summary>
    public class UploadVideo : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            HttpPostedFile file = context.Request.Files["file"];
            var dict_content = JsonConvert.DeserializeObject<Dictionary<string, object>>(context.Request["content"]);
            var hotelIds = JsonConvert.DeserializeObject<List<int>>(context.Request["hotel_ids"]);

            string str_clientId = dict_content["client_id"].ToString();

            if (file != null)
            {
                string fileName = $"content{Path.GetExtension(file.FileName)}";
                string rel_path = $"/sources/contents/{str_clientId}";
                string abs_path = context.Server.MapPath($"~{rel_path}");
                try
                {
                    if (!Directory.Exists(abs_path))
                    {
                        Directory.CreateDirectory(abs_path);
                    }
                    else
                    {
                        string[] filesToDelete = Directory.GetFiles(abs_path);
                        foreach (string fileToDelete in filesToDelete)
                        {
                            File.Delete(fileToDelete);
                        }
                    }
                    string fullFilePath = Path.Combine(abs_path, fileName);
                    file.SaveAs(fullFilePath);

                    var content = new Content();
                    content.title = dict_content["title"].ToString();
                    content.description = dict_content["description"].ToString();
                    content.clientId = Convert.ToInt32(dict_content["client_id"]);
                    content.path = fullFilePath;

                    var contentDb = new ContentDb();
                    contentDb.DeleteAllClientContent(content.clientId);
                    foreach (var hotelId in hotelIds)
                    {
                        content.hotelId = hotelId;
                        contentDb.CreateContent(content);
                    }

                    context.Response.ContentType = "application/json";
                    context.Response.Write(JsonConvert.SerializeObject(fullFilePath));
                    //context.Response.ContentType = "text/plain";
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