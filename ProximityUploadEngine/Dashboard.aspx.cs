using ProximityUploadEngine.Database;
using ProximityUploadEngine.Web_Handlers.Dashboard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProximityUploadEngine
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            cbl_hotel.Items.Add("hotel1");
            cbl_hotel.Items.Add("hotel2");
            cbl_hotel.Items.Add("hotel3");
            cbl_hotel.Items.Add("hotel4");
            cbl_hotel.Items.Add("hotel5");
            cbl_hotel.Items.Add("hotel6");
            cbl_hotel.Items.Add("hotel7");
            cbl_hotel.Items.Add("hotel8");
            cbl_hotel.Items.Add("hotel9");
            cbl_hotel.Items.Add("hotel10");
            cbl_hotel.Items.Add("hotel11");
            cbl_hotel.Items.Add("hotel12");
            cbl_hotel.Items.Add("hotel13");
            cbl_hotel.Items.Add("hotel14");
            cbl_hotel.Items.Add("hotel15");

            var videoDetails = new VideoDetails();
            setVideoDetails(videoDetails);
        }
        public void setVideoDetails(VideoDetails videoDetails)
        {
            lb_videoDetails.Items.Clear();
            lb_videoDetails.Items.Add($"File Directory:      {videoDetails.filePath}/{videoDetails.fileName}");
            lb_videoDetails.Items.Add($"File Size:           {videoDetails.fileSize}");
            lb_videoDetails.Items.Add($"File Type:           {videoDetails.fileType}");
            lb_videoDetails.Items.Add($"Video Duration:      {videoDetails.videoDuration}");
            lb_videoDetails.Items.Add($"Video Resolution:    {videoDetails.videoResolution}");
            lb_videoDetails.Items.Add($"Audio Format:        {videoDetails.audioFormat}");
            lb_videoDetails.Items.Add($"Audio Channel:       {videoDetails.audioChannel}");
        }
    }
}