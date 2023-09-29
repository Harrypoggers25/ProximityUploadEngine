using ProximityUploadEngine.HP_Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.EnterpriseServices.Internal;
using System.Linq;
using System.Web;

namespace ProximityUploadEngine.Database
{
    public class ContentDb
    {
        public readonly string connectionString1;
        public ContentDb()
        {
            this.connectionString1 = ConfigurationManager.ConnectionStrings["Vf28AdvertisementConnection"].ConnectionString;
        }
        public void CreateContent(Content content)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["client_id"] = content.clientId;
                hpsql.values["hotel_id"] = content.hotelId;
                hpsql.values["title"] = content.title;
                hpsql.values["path"] = content.path;
                hpsql.values["description"] = content.description;
                hpsql.InsertRow("tbl_contents");
            }
        }
        public List<Content> GetAllContent()
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                var contents = new List<Content>();

                using (var reader = hpsql.ReadCommand("SELECT * FROM tbl_contents"))
                {
                    while (reader.Read())
                    {
                        var content = new Content();

                        content.id = hpsql.ToInt32(reader["id"]);
                        content.clientId = hpsql.ToInt32(reader["client_id"]);
                        content.clientId = hpsql.ToInt32(reader["hotel_id"]);
                        content.title = hpsql.ToString(reader["title"]);
                        content.path = hpsql.ToString(reader["path"]);
                        content.description = hpsql.ToString(reader["description"]);

                        contents.Add(content);
                    }
                    return contents;
                }
            }
        }
        public Content GetContent(int id)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                var content = new Content();

                hpsql.values["id"] = id;
                using (var reader = hpsql.ReadCommand("SELECT FROM tbl_contents WHERE id = @id"))
                {
                    if (reader.Read())
                    {
                        content.id = hpsql.ToInt32(reader["id"]);
                        content.clientId = hpsql.ToInt32(reader["client_id"]);
                        content.clientId = hpsql.ToInt32(reader["hotel_id"]);
                        content.title = hpsql.ToString(reader["title"]);
                        content.path = hpsql.ToString(reader["path"]);
                        content.description = hpsql.ToString(reader["description"]);
                    }
                    return content;
                }
            }
        }
        public bool IsPathExist(string path)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["path"] = path;
                return hpsql.IsColExist("tbl_contents");
            }
        }
        public void UpdateContent(Content content)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["id"] = content.id;
                hpsql.values["client_id"] = content.clientId;
                hpsql.values["hotel_id"] = content.clientId;
                hpsql.values["title"] = content.title;
                hpsql.values["path"] = content.path;
                hpsql.values["description"] = content.description;
                hpsql.UpdateRow("tbl_contents", "id");
            }
        }
        public void DeleteAllContent()
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.DeleteRow("tbl_contents");
                hpsql.ResetSerial("tbl_contents", "id");
            }
        }
        public void DeleteContent(int id)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["id"] = id;

                hpsql.DeleteRow("tbl_contents", "id");
                if (hpsql.CountRow("tbl_contents") == 0) hpsql.ResetSerial("tbl_contents", "id");
            }
        }
        public void DeleteAllClientContent(int clientId)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                var contentIds = new List<int>();

                hpsql.values["client_id"] = clientId;
                using (var reader = hpsql.ReadCommand("SELECT id FROM tbl_contents WHERE client_id = @client_id"))
                {
                    while (reader.Read())
                    {
                        contentIds.Add(Convert.ToInt32(reader["id"]));
                    }
                }
                hpsql.ClearValues();

                foreach (var id in contentIds)
                {
                    hpsql.values["id"] = id;
                    hpsql.DeleteRow("tbl_contents", "id");
                }
                if (hpsql.CountRow("tbl_contents") == 0) hpsql.ResetSerial("tbl_contents", "id");
            }
        }
    }
}