using Newtonsoft.Json;
using System;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Web;
using MediaInfo.DotNetWrapper;
using MediaInfo.DotNetWrapper.Enumerations;
using ProximityUploadEngine.Web_Handlers.Dashboard;

namespace ProximityUploadEngine.Web_Handlers
{
    
    public class GetVideoData : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            HttpPostedFile file = context.Request.Files["file"];

            if (file != null)
            {
                var videoData = new VideoDetails
                {
                    fileName = file.FileName,
                    filePath = context.Server.MapPath(file.FileName),
                    fileSize = ConvertSize(file.ContentLength),
                    fileType = file.ContentType,
                };


                string jsonResult = JsonConvert.SerializeObject(videoData);
                context.Response.ContentType = "application/json";
                context.Response.Write(jsonResult);
            }
        }
        private string ConvertSize(long size)
        {
            string convertedResult = $"{size} bytes";
            if (size > 1048576)
            {
                // Greater than 1Mb
                size = size / 1024 / 1024;
                convertedResult = $"{size} Mb";
            }
            else if (size > 1024)
            {
                // Greater than 1Kb
                size = size / 1024;
                convertedResult = $"{size} Kb";
            }

            return convertedResult;
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