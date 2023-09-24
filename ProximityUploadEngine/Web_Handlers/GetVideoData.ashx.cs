using Newtonsoft.Json;
using System;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Web;
using MediaInfo.DotNetWrapper;
using MediaInfo.DotNetWrapper.Enumerations;

namespace ProximityUploadEngine.Web_Handlers
{
    public class GetVideoData : IHttpHandler
    {
        public class VideoData
        {
            public string FileName { get; set; }
            public string FilePath { get; set; }
            public string FileSize { get; set; }
            public string FileType { get; set; }
            public string VideoDuration { get; set; }
            public string VideoResolution { get; set; }
        }
        public void ProcessRequest(HttpContext context)
        {
            HttpPostedFile file = context.Request.Files["file"];

            if (file != null)
            {
                var videoData = new VideoData
                {
                    FileName = file.FileName,
                    FilePath = context.Server.MapPath(file.FileName),
                    FileSize = ConvertSize(file.ContentLength),
                    FileType = file.ContentType,
                };


                string jsonResult = JsonConvert.SerializeObject(videoData);
                context.Response.ContentType = "application/json";
                context.Response.Write(jsonResult);
            }
        }
        private string ConvertSize(long size)
        {
            string convertedResult = $"{size.ToString()} bytes";
            if (size > 1048576)
            {
                // Greater than 1Mb
                size = size / 1024 / 1024;
                convertedResult = $"{size.ToString()} Mb";
            }
            else if (size > 1024)
            {
                // Greater than 1Kb
                size = size / 1024;
                convertedResult = $"{size.ToString()} Kb";
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