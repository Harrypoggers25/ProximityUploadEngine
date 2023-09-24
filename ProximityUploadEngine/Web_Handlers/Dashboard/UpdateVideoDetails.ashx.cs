using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProximityUploadEngine.Web_Handlers.Dashboard
{
    public class VideoDetails
    {
        public string fileName { get; set; }
        public string filePath { get; set; }
        public string fileSize { get; set; }
        public string fileType { get; set; }
        public string videoDuration { get; set; }
        public string videoResolution { get; set; }
        public string audioFormat { get; set; }
        public string audioChannel { get; set; }
        public VideoDetails()
        {
            init();
        }
        public void init()
        {
            fileName = "unknown";
            filePath = "unknown";
            fileSize = "unknown";
            fileType = "unknown";
            videoDuration = "unknown";
            videoResolution = "unknown";
            audioFormat = "unknown";
            audioChannel = "unknown";
        }
    }
    public class UpdateVideoDetails : IHttpHandler
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