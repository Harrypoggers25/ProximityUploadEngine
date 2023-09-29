using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProximityUploadEngine.Database
{
    // Database Models
    public class Credential
    {
        public int id { get; set; }
        public string email { get; set; }
        public string password { get; set; }
        public string contactNumber { get; set; }
        public string profilePicture { get; set; }
    }
    public class Agency
    {
        public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public Credential credential { get; set; }
        public List<Client> clients { get; set; }

        public Agency()
        {
            credential = new Credential();
            clients = new List<Client>();
        }
    }
    public class Client
    {
        public int id { get; set; }
        public int? agencyId { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string location { get; set; }
        public Credential credential { get; set; }
        public Client()
        {
            credential = new Credential();
        }
    }
    public class Content
    {
        public int id { get; set; }
        public int clientId { get; set; }
        public int hotelId { get; set; }
        public string title { get; set; }
        public string path { get; set; }
        public string description { get; set; }
    }
    public class Hotel
    {
        public int id { get; set; }
        public int? agencyId { get; set; }
        public string name { get; set; }
        public string email { get; set; }
        public string password { get; set; }
        public string contactNumber { get; set; }
        public string profilePicture { get; set; }
        public string description { get; set; }
        public string location { get; set; }
    }

    // Non-Database Related Models
    public class VideoDetails
    {
        public string fileName { get; set; }
        public string fileDir { get; set; }
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
            fileDir = "unknown";
            fileSize = "unknown";
            fileType = "unknown";
            videoDuration = "unknown";
            videoResolution = "unknown";
            audioFormat = "unknown";
            audioChannel = "unknown";
        }
    }
}