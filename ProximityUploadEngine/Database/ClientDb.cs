using ProximityUploadEngine.HP_Framework;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace ProximityUploadEngine.Database
{

    public class ClientDb
    {
        private readonly string connectionString1;
        public ClientDb()
        {
            this.connectionString1 = ConfigurationManager.ConnectionStrings["Vf28AdvertisementConnection"].ConnectionString;
        }
        public void CreateDirectClient(Client client)
        {
            if (client.credential.email != "" && client.credential.email != null)
            {
                using (var hpsql = new HPpgsql(connectionString1))
                {
                    hpsql.values["email"] = client.credential.email;
                    hpsql.values["password"] = client.credential.password;
                    hpsql.values["contact_number"] = client.credential.contactNumber;
                    hpsql.values["profile_picture"] = client.credential.profilePicture;
                    hpsql.InsertRow("tbl_credentials");
                    hpsql.ClearValues();

                    int credential_id = hpsql.GetLastSerial("tbl_credentials", "id");

                    hpsql.values["name"] = client.name;
                    hpsql.values["description"] = client.description;
                    hpsql.values["location"] = client.location;
                    hpsql.values["credential_id"] = credential_id;
                    hpsql.InsertRow("tbl_clients");
                }
            }
        }
        public List<Client> GetAllDirectClient()
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                var clients = new List<Client>();

                using (var reader = hpsql.ReadCommand(
                    "SELECT " +
                    "   c1.id AS credential_id, " +
                    "   c2.id AS client_id, " +
                    "   c2.name AS name, " +
                    "   c1.email AS email, " +
                    "   c1.password AS password, " +
                    "   c2.description AS description, " +
                    "   c2.location AS location, " +
                    "   c1.contact_number AS contact_number, " +
                    "   c1.profile_picture AS profile_picture " +
                    "FROM tbl_clients AS c2 " +
                    "INNER JOIN tbl_credentials AS c1 " +
                    "ON c2.credential_id = c1.id;"))
                {
                    while (reader.Read())
                    {
                        var client = new Client();

                        client.id = hpsql.ToInt32(reader["client_id"]);
                        client.credential.id = hpsql.ToInt32(reader["credential_id"]);
                        client.name = hpsql.ToString(reader["name"]);
                        client.credential.email = hpsql.ToString(reader["email"]);
                        client.credential.password = hpsql.ToString(reader["password"]);
                        client.description = hpsql.ToString(reader["description"]);
                        client.location = hpsql.ToString(reader["location"]);
                        client.credential.contactNumber = hpsql.ToString(reader["contact_number"]);
                        client.credential.profilePicture = hpsql.ToString(reader["profile_picture"]);

                        clients.Add(client);
                    }
                    return clients;
                }
            }
        }
        public Client GetDirectClient(string clientEmail)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                Client client = new Client();
                hpsql.values["email"] = clientEmail;
                using (var reader = hpsql.ReadCommand(
                    "SELECT " +
                    "   c1.id AS credential_id, " +
                    "   c2.id AS client_id, " +
                    "   c2.name AS name, " +
                    "   c1.email AS email, " +
                    "   c1.password AS password, " +
                    "   c2.description AS description, " +
                    "   c2.location AS location, " +
                    "   c1.contact_number AS contact_number, " +
                    "   c1.profile_picture AS profile_picture " +
                    "FROM tbl_clients AS c2 " +
                    "INNER JOIN tbl_credentials AS c1 " +
                    "ON c2.credential_id = c1.id " +
                    "WHERE c1.email = @email;"))
                {
                    if (reader.Read())
                    {
                        client.id = hpsql.ToInt32(reader["client_id"]);
                        client.credential.id = hpsql.ToInt32(reader["credential_id"]);
                        client.name = hpsql.ToString(reader["name"]);
                        client.credential.email = hpsql.ToString(reader["email"]);
                        client.credential.password = hpsql.ToString(reader["password"]);
                        client.description = hpsql.ToString(reader["description"]);
                        client.location = hpsql.ToString(reader["location"]);
                        client.credential.contactNumber = hpsql.ToString(reader["contact_number"]);
                        client.credential.profilePicture = hpsql.ToString(reader["profile_picture"]);
                    }
                    return client;
                }
            }
        }
        public bool IsEmailExist(string clientEmail)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["email"] = clientEmail;
                return hpsql.IsColExist("tbl_credentials");
            }
        }
        public bool IsPasswordCorrect(string clientEmail, string clientPassword)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["email"] = clientEmail;
                hpsql.values["password"] = clientPassword;
                return hpsql.IsColExist("tbl_credentials");
            }
        }
        public void UpdateDirectClient(Client client)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["email"] = client.credential.email;
                hpsql.values["password"] = client.credential.password;
                hpsql.values["contact_number"] = client.credential.contactNumber;
                hpsql.values["profile_picture"] = client.credential.profilePicture;
                hpsql.UpdateRow("tbl_credentials", "email");
                hpsql.ClearValues();

                hpsql.values["name"] = client.name;
                hpsql.values["description"] = client.description;
                hpsql.values["location"] = client.description;
                hpsql.values["credential_id"] = GetDirectClient(client.credential.email);
                hpsql.UpdateRow("tbl_clients", "credential_id");
            }
        }
        public void DeleteAllDirectClient()
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                List<Client> clients = GetAllDirectClient();
                foreach (var client in clients)
                {
                    hpsql.values["id"] = client.credential.id;
                    hpsql.values["credential_id"] = client.credential.id;
                    hpsql.DeleteRow("tbl_clients", "credential_id");       // Deletes Client First
                    hpsql.DeleteRow("tbl_credentials", "id");               // Deletes its Credentials
                    hpsql.ClearValues();
                }
                hpsql.ResetSerial("tbl_clients", "id");
                if (hpsql.CountRow("tbl_credentials") == 0) hpsql.ResetSerial("tbl_credentials", "id");
            }
        }
        public void DeleteDirectClient(string clientEmail)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                Client client = GetDirectClient(clientEmail);

                if (client != null)
                {
                    hpsql.values["credential_id"] = client.credential.id;
                    hpsql.values["id"] = client.credential.id;

                    hpsql.DeleteRow("tbl_clients", "credential_id");
                    hpsql.DeleteRow("tbl_credentials", "id");

                    if (hpsql.CountRow("tbl_clients") == 0) hpsql.ResetSerial("tbl_clients", "id");
                    if (hpsql.CountRow("tbl_credentials") == 0) hpsql.ResetSerial("tbl_credentials", "id");
                }
            }
        }
    }
}