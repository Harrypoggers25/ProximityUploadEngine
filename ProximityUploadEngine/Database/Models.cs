using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProximityUploadEngine.Database
{
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
}