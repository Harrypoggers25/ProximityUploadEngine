using ProximityUploadEngine.HP_Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Dynamic;

namespace ProximityUploadEngine.Database
{
    public class AgencyDb
    {
        private readonly string connectionString1;
        private readonly string connectionString2;
        public AgencyDb()
        {
            connectionString1 = ConfigurationManager.ConnectionStrings["Vf28AdvertisementConnection"].ConnectionString;
            connectionString2 = ConfigurationManager.ConnectionStrings["Vf28HotelConnection"].ConnectionString;
        }
        public void CreateAgency(Agency agency)
        {
            if (agency.credential.email != "" && agency.credential.email != null)
            {
                using (var hpsql = new HPpgsql(connectionString1))
                {
                    hpsql.values["email"] = agency.credential.email;
                    hpsql.values["password"] = agency.credential.password;
                    hpsql.values["contact_number"] = agency.credential.contactNumber;
                    hpsql.values["profile_picture"] = agency.credential.profilePicture;
                    hpsql.InsertRow("tbl_credentials");
                    hpsql.ClearValues();

                    int credential_id = hpsql.GetLastSerial("tbl_credentials", "id");

                    hpsql.values["name"] = agency.name;
                    hpsql.values["description"] = agency.description;
                    hpsql.values["credential_id"] = credential_id;
                    hpsql.InsertRow("tbl_agencies");
                }
            }
        }
        public List<Agency> GetAllAgency()
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                var agencies = new List<Agency>();

                using (var reader = hpsql.ReadCommand(
                    "SELECT " +
                    "   c.id AS credential_id, " +
                    "   a.id AS agency_id, " +
                    "   a.name AS name, " +
                    "   c.email AS email, " +
                    "   c.password AS password, " +
                    "   a.description AS description, " +
                    "   c.contact_number AS contact_number, " +
                    "   c.profile_picture AS profile_picture " +
                    "FROM tbl_agencies AS a " +
                    "INNER JOIN tbl_credentials AS c " +
                    "ON a.credential_id = c.id;"))
                {
                    while (reader.Read())
                    {
                        var agency = new Agency();

                        agency.id = hpsql.ToInt32(reader["agency_id"]);
                        agency.credential.id = hpsql.ToInt32(reader["credential_id"]);
                        agency.name = hpsql.ToString(reader["name"]);
                        agency.credential.email = hpsql.ToString(reader["email"]);
                        agency.credential.password = hpsql.ToString(reader["password"]);
                        agency.description = hpsql.ToString(reader["description"]);
                        agency.credential.contactNumber = hpsql.ToString(reader["contact_number"]);
                        agency.credential.profilePicture = hpsql.ToString(reader["profile_picture"]);

                        agencies.Add(agency);
                    }
                    return agencies;
                }

            }
        }
        public Agency GetAgency(string agencyEmail)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                Agency agency = new Agency();
                hpsql.values["email"] = agencyEmail;
                using (var reader = hpsql.ReadCommand(
                    "SELECT " +
                    "   c.id AS credential_id, " +
                    "   a.id AS agency_id, " +
                    "   a.name AS name, " +
                    "   c.email AS email, " +
                    "   c.password AS password, " +
                    "   a.description AS description, " +
                    "   c.contact_number AS contact_number, " +
                    "   c.profile_picture AS profile_picture " +
                    "FROM tbl_agencies AS a " +
                    "INNER JOIN tbl_credentials AS c " +
                    "ON a.credential_id = c.id " +
                    "WHERE c.email = @email;"))
                {
                    if (reader.Read())
                    {
                        agency.id = hpsql.ToInt32(reader["agency_id"]);
                        agency.credential.id = hpsql.ToInt32(reader["credential_id"]);
                        agency.name = hpsql.ToString(reader["name"]);
                        agency.credential.email = hpsql.ToString(reader["email"]);
                        agency.credential.password = hpsql.ToString(reader["password"]);
                        agency.description = hpsql.ToString(reader["description"]);
                        agency.credential.contactNumber = hpsql.ToString(reader["contact_number"]);
                        agency.credential.profilePicture = hpsql.ToString(reader["profile_picture"]);
                    }
                    return agency;
                }
            }
        }
        public bool IsEmailExist(string agencyEmail)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["email"] = agencyEmail;
                return hpsql.IsColExist("tbl_credentials");
            }
        }
        public bool IsPasswordCorrect(string agencyEmail, string agencyPassword)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["email"] = agencyEmail;
                hpsql.values["password"] = agencyPassword;
                return hpsql.IsColExist("tbl_credentials");
            }
        }
        public void UpdateAgency(Agency agency)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["email"] = agency.credential.email;
                hpsql.values["password"] = agency.credential.password;
                hpsql.values["contact_number"] = agency.credential.contactNumber;
                hpsql.values["profile_picture"] = agency.credential.profilePicture;
                hpsql.UpdateRow("tbl_credentials", "email");
                hpsql.ClearValues();

                hpsql.values["description"] = agency.description;
                hpsql.values["credential_id"] = GetAgency(agency.credential.email).id;
                hpsql.UpdateRow("tbl_agencies", "credential_id");
            }
        }
        public void DeleteAllAgency()
        {
            DeleteAllClient();
            using (var hpsql = new HPpgsql(connectionString1))
            {
                List<Agency> agencies = GetAllAgency();
                hpsql.DeleteRow("tbl_agencies");       // Deletes Agency First
                foreach (var agency in agencies)
                {
                    hpsql.values["id"] = agency.credential.id;
                    hpsql.DeleteRow("tbl_credentials", "id");               // Deletes its Credentials
                    hpsql.ClearValues();
                }
                hpsql.ResetSerial("tbl_agencies", "id");
                if (hpsql.CountRow("tbl_credentials") == 0) hpsql.ResetSerial("tbl_credentials", "id");
            }
        }
        public void DeleteAgency(string agencyEmail)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                Agency agency = GetAgency(agencyEmail);

                hpsql.values["credential_id"] = agency.credential.id;
                hpsql.values["id"] = agency.id;

                hpsql.DeleteRow("tbl_agencies", "credential_id");
                hpsql.DeleteRow("tbl_credentials", "id");

                if (hpsql.CountRow("tbl_agencies") == 0) hpsql.ResetSerial("tbl_agencies", "id");
                if (hpsql.CountRow("tbl_credentials") == 0) hpsql.ResetSerial("tbl_credentials", "id");
            }
        }

        // Agency's Client handlers
        public void CreateClient(Client client)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["agency_id"] = client.agencyId;
                hpsql.values["name"] = client.name;
                hpsql.values["description"] = client.description;
                hpsql.values["location"] = client.location;
                hpsql.InsertRow("tbl_clients");
            }
        }
        public List<Agency> GetAllAgencyWithClient()
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                var agencies = new List<Agency>();
                using (var reader = hpsql.ReadCommand(
                    "SELECT DISTINCT a.email " +
                    "FROM tbl_credentials a " +
                    "INNER JOIN tbl_agencies b " +
                    "   ON a.id = b.credential_id " +
                    "INNER JOIN tbl_clients c " +
                    "   ON b.id = c.agency_id;"))
                {
                    while (reader.Read())
                    {
                        agencies.Add(GetAgency(reader.GetString(0)));
                    }
                    return agencies;
                }
            }
        }
        public List<Client> GetAllClient(string agencyEmail)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                var clients = new List<Client>();

                hpsql.values["email"] = agencyEmail;
                using (var reader = hpsql.ReadCommand(
                    "SELECT c.* " +
                    "FROM tbl_clients c " +
                    "INNER JOIN tbl_agencies b " +
                    "   ON c.agency_id = b.id " +
                    "INNER JOIN tbl_credentials a " +
                    "   ON b.credential_id = a.id " +
                    "WHERE a.email = @email;"))
                {
                    while (reader.Read())
                    {
                        var client = new Client();
                        client.id = hpsql.ToInt32(reader["id"]);
                        client.agencyId = hpsql.ToInt32(reader["agency_id"]);
                        client.name = hpsql.ToString(reader["name"]);
                        client.description = hpsql.ToString(reader["description"]);
                        client.location = hpsql.ToString(reader["location"]);

                        clients.Add(client);
                    }
                    return clients;
                }
            }
        }
        public Client GetClient(int clientId)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                var client = new Client();

                hpsql.values["id"] = clientId;
                using (var reader = hpsql.ReadCommand("SELECT * FROM tbl_clients WHERE id = @id"))
                {
                    if (reader.Read())
                    {
                        client.id = hpsql.ToInt32(reader["id"]);
                        client.agencyId = hpsql.ToInt32(reader["agency_id"]);
                        client.name = hpsql.ToString(reader["name"]);
                        client.description = hpsql.ToString(reader["description"]);
                        client.location = hpsql.ToString(reader["location"]);
                    }
                    return client;
                }
            }
        }
        public bool HasClient(string agencyEmail)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["agency_email"] = agencyEmail;
                return hpsql.ReadCommand(
                    "SELECT COUNT(*) " +
                    "FROM tbl_clients " +
                    "WHERE agency_id IN (" +
                    "   SELECT id FROM tbl_agencies " +
                    "   WHERE credential_id IN (" +
                    "       SELECT id FROM tbl_credentials " +
                    "       WHERE email = @agency_email" +
                    "   )" +
                    ")").HasRows;
            }
        }
        public void UpdateClient(Client client)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                hpsql.values["id"] = client.id;
                hpsql.values["name"] = client.name;
                hpsql.values["description"] = client.description;
                hpsql.values["location"] = client.location;

                hpsql.UpdateRow("tbl_clients", "id");
            }
        }
        public void DeleteAllClient()
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                var agencyIds = new List<int>();
                using (var reader = hpsql.ReadCommand(
                    "SELECT id " +
                    "FROM tbl_clients " +
                    "WHERE agency_id IN (SELECT id FROM tbl_agencies);"))
                {
                    while (reader.Read())
                    {
                        agencyIds.Add(reader.GetInt32(0));
                    }
                }
                foreach (var id in agencyIds)
                {
                    hpsql.values["id"] = id;
                    hpsql.DeleteRow("tbl_clients", "id");
                    hpsql.ClearValues();
                }
                if (hpsql.CountRow("tbl_clients") == 0) hpsql.ResetSerial("tbl_clients", "id");
            }
        }
        public void DeleteClient(int clientId)
        {
            using (var hpsql = new HPpgsql(connectionString1))
            {
                var client = GetClient(clientId);

                hpsql.values["id"] = client.id;
                hpsql.DeleteRow("tbl_clients", "id");
                if (hpsql.CountRow("tbl_clients") == 0) hpsql.ResetSerial("tbl_clients", "id");
            }
        }

        // Agency's Hotel handlers
        public List<Hotel> GetAllHotel(string agencyEmail)
        {
            int agencyId = GetAgency(agencyEmail).id;

            using (var hpsql = new HPpgsql(connectionString2)) // For Hotel Database
            {
                var hotels = new List<Hotel>();

                hpsql.values["agency_id"] = agencyId;
                using (var reader = hpsql.ReadCommand("SELECT * FROM tbl_hotels WHERE agency_id = @agency_id"))
                {
                    while (reader.Read())
                    {
                        Hotel hotel = new Hotel();
                        hotel.id = hpsql.ToInt32(reader["id"]);
                        hotel.agencyId = hpsql.ToNullInt32(reader["agency_id"]);
                        hotel.name = hpsql.ToString(reader["name"]);
                        hotel.email = hpsql.ToString(reader["email"]);
                        hotel.password = hpsql.ToString(reader["password"]);
                        hotel.contactNumber = hpsql.ToString(reader["contact_number"]);
                        hotel.profilePicture = hpsql.ToString(reader["profile_picture"]);
                        hotel.description = hpsql.ToString(reader["description"]);
                        hotel.location = hpsql.ToString(reader["location"]);

                        hotels.Add(hotel);
                    }
                    return hotels;
                }
            }
        }
        //public List<Hotel> GetAllHotel(string agencyEmail)
        //{
        //    using (var hpsql1 = new HPpgsql(connectionString1)) // For Agency Database
        //    using (var hpsql2 = new HPpgsql(connectionString2)) // For Hotel Database
        //    {
        //        var hotels = new List<Hotel>();

        //        hpsql1.values["email"] = agencyEmail;
        //        using (var reader = hpsql1.ReadCommand(
        //            "SELECT h.* " +
        //            "FROM Vf28HotelDatabase.public.tbl_hotels AS h " +
        //            "JOIN Vf28AdvertisementDatabase.public.tbl_agencies AS a " +
        //            "ON h.agency_id = a.id " +
        //            "   WHERE a.email = @email"))
        //        {
        //            while (reader.Read())
        //            {
        //                Hotel hotel = new Hotel();
        //                hotel.id = hpsql1.ToInt32(reader["id"]);
        //                hotel.agencyId = hpsql1.ToNullInt32(reader["agency_id"]);
        //                hotel.name = hpsql1.ToString(reader["name"]);
        //                hotel.email = hpsql1.ToString(reader["email"]);
        //                hotel.password = hpsql1.ToString(reader["password"]);
        //                hotel.contactNumber = hpsql1.ToString(reader["contact_number"]);
        //                hotel.profilePicture = hpsql1.ToString(reader["profile_picture"]);
        //                hotel.description = hpsql1.ToString(reader["description"]);
        //                hotel.location = hpsql1.ToString(reader["location"]);

        //                hotels.Add(hotel);
        //            }
        //            return hotels;
        //        }
        //    }
        //}
    }
}