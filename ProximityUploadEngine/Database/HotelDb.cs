using ProximityUploadEngine.HP_Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace ProximityUploadEngine.Database
{
    public class HotelDb
    {
        private readonly string connectionString2;
        public HotelDb()
        {
            connectionString2 = ConfigurationManager.ConnectionStrings["Vf28HotelConnection"].ConnectionString;
        }
        public void CreateHotel(Hotel hotel)
        {
            if (hotel.email != "" && hotel.email != null)
            {
                using (var hpsql = new HPpgsql(connectionString2))
                {
                    if (hotel.agencyId != null) hpsql.values["agency_id"] = hotel.agencyId;
                    hpsql.values["email"] = hotel.email;
                    hpsql.values["name"] = hotel.name;
                    hpsql.values["password"] = hotel.password;
                    hpsql.values["contact_number"] = hotel.contactNumber;
                    hpsql.values["profile_picture"] = hotel.profilePicture;
                    hpsql.values["description"] = hotel.description;
                    hpsql.values["location"] = hotel.location;
                    hpsql.InsertRow("tbl_hotels");
                    hpsql.ClearValues();
                }
            }
        }
        public List<Hotel> GetAllHotel()
        {
            using (var hpsql = new HPpgsql(connectionString2))
            {
                var hotels = new List<Hotel>();
                using (var reader = hpsql.ReadCommand("SELECT * FROM tbl_hotels"))
                {
                    while (reader.Read())
                    {
                        var hotel = new Hotel();

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
        public Hotel GetHotel(string hotelEmail)
        {
            using (var hpsql = new HPpgsql(connectionString2))
            {
                var hotel = new Hotel();

                hpsql.values["email"] = hotelEmail;
                using (var reader = hpsql.ReadCommand("SELECT * FROM tbl_hotels WHERE email = @email"))
                {
                    if (reader.Read())
                    {
                        hotel.id = hpsql.ToInt32(reader["id"]);
                        hotel.agencyId = hpsql.ToNullInt32(reader["agency_id"]);
                        hotel.name = hpsql.ToString(reader["name"]);
                        hotel.email = hpsql.ToString(reader["email"]);
                        hotel.password = hpsql.ToString(reader["password"]);
                        hotel.contactNumber = hpsql.ToString(reader["contact_number"]);
                        hotel.profilePicture = hpsql.ToString(reader["profile_picture"]);
                        hotel.description = hpsql.ToString(reader["description"]);
                        hotel.location = hpsql.ToString(reader["location"]);
                    }
                    return hotel;
                }
            }
        }
        public bool IsEmailExist(string hotelEmail)
        {
            using (var hpsql = new HPpgsql(connectionString2))
            {
                hpsql.values["email"] = hotelEmail;
                return hpsql.IsColExist("tbl_hotels");
            }
        }
        public bool IsPasswordCorrect(string hotelEmail, string hotelPassword)
        {
            using (var hpsql = new HPpgsql(connectionString2))
            {
                hpsql.values["email"] = hotelEmail;
                hpsql.values["password"] = hotelPassword;
                return hpsql.IsColExist("tbl_hotels");
            }
        }
        public void UpdateHotel(Hotel hotel)
        {
            using (var hpsql = new HPpgsql(connectionString2))
            {
                hpsql.values["agency_id"] = hotel.agencyId;
                hpsql.values["email"] = hotel.email;
                hpsql.values["name"] = hotel.name;
                hpsql.values["password"] = hotel.password;
                hpsql.values["contact_number"] = hotel.contactNumber;
                hpsql.values["profile_picture"] = hotel.profilePicture;
                hpsql.values["description"] = hotel.description;
                hpsql.values["location"] = hotel.location;
                hpsql.UpdateRow("tbl_hotels", "email");
            }
        }
        public void DeleteAllHotel()
        {
            using (var hpsql = new HPpgsql(connectionString2))
            {
                hpsql.DeleteRow("tbl_hotels");
                hpsql.ResetSerial("tbl_hotels", "id");
            }
        }
        public void DeleteHotel(string hotelEmail)
        {
            using (var hpsql = new HPpgsql(connectionString2))
            {
                hpsql.values["id"] = GetHotel(hotelEmail).id;

                hpsql.DeleteRow("tbl_hotels", "id");
                if (hpsql.CountRow("tbl_hotels") == 0) hpsql.ResetSerial("tbl_hotels", "id");
            }
        }
    }
}