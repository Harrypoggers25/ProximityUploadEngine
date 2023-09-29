using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using ProximityUploadEngine.Database;
using System.Runtime.InteropServices;

namespace ProximityUploadEngine.Web_Handlers.Dashboard
{
    /// <summary>
    /// Summary description for UpdateVideoDetails
    /// </summary>
    ///  public class VideoDetails
    public class UpdateVideoDetils : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            HttpPostedFile file = context.Request.Files["file"];

            if (file != null)
            {
                var videoData = new VideoDetails
                {
                    fileName = file.FileName,
                    fileDir = context.Server.MapPath(file.FileName),
                    fileSize = ConvertSize(file.ContentLength),
                    fileType = file.ContentType,
                    videoDuration = TimeSpan.FromSeconds(Math.Round(GetMediaDuration(context.Server.MapPath(file.FileName)))).ToString()
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
        private double GetMediaDuration(string path)
        {
            try
            {
                var w = new WMPLib.WindowsMediaPlayer();
                var m = w.newMedia(path);
                w.close();

                return m.duration;
            }
            catch (Exception)
            {
                return 0;
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


