﻿using Npgsql;
using System;
using System.Collections.Generic;

namespace ProximityUploadEngine
{
    public class AgencyData
    {
        private readonly string connectionString;
        public AgencyData()
        {
            //this.connectionString = "Host=192.168.1.165;Port=5432;Database=ProximityDatabase;Username=postgres;Password=SURoot;Timeout=15;Pooling=true;";
            this.connectionString = "Host=localhost;Port=5432;Database=ProximityDatabase2;Username=postgres;Password=SURoot;Timeout=15;Pooling=true;";
        }
        public void CreateAgency(Agency agency)
        {
            using (var conn = new NpgsqlConnection(connectionString))
            {
                conn.Open();
                using (var cmd = new NpgsqlCommand("INSERT INTO tb_agency (id, name, email, password) VALUES (@id, @name, @email, @password)", conn))
                {
                    cmd.Parameters.AddWithValue("id", agency.id);
                    cmd.Parameters.AddWithValue("name", agency.name);
                    cmd.Parameters.AddWithValue("email", agency.email);
                    cmd.Parameters.AddWithValue("password", agency.password);

                    cmd.ExecuteNonQuery();
                }
            }
        }
        public Agency GetAgency(int id)
        {
            var agency = new Agency();
            using (var conn = new NpgsqlConnection(connectionString))
            {
                conn.Open();

                using (var cmd = new NpgsqlCommand("SELECT * FROM tb_agency WHERE id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("id", id);

                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            agency.id = Convert.ToInt32(reader["id"]);
                            agency.name = reader["name"].ToString();
                            agency.email = reader["email"].ToString();
                            agency.password = reader["password"].ToString();
                        }
                        else
                        {
                            // No user found with the provided email
                            // You might want to return null or handle this case as needed
                            return null;
                        }
                    }
                }
            }
            return agency;
        }
        public List<Agency> GetAllAgency()
        {
            var users = new List<Agency>();

            using (var conn = new NpgsqlConnection(connectionString))
            {
                conn.Open();

                using (var cmd = new NpgsqlCommand("SELECT * FROM tb_agency", conn))
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var agency = new Agency
                        {
                            id = Convert.ToInt32(reader["id"].ToString()),
                            name = reader["name"].ToString(),
                            email = reader["email"].ToString(),
                            password = reader["password"].ToString(),
                        };

                        users.Add(agency);
                    }
                }
            }

            return users;
        }
        public void UpdateAgency(Agency agency)
        {
            using (var conn = new NpgsqlConnection(connectionString))
            {
                conn.Open();

                using (var cmd = new NpgsqlCommand("UPDATE tb_agency SET id = @id, name = @name, email = @email, password = @password WHERE id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("id", agency.id);
                    cmd.Parameters.AddWithValue("name", agency.name);
                    cmd.Parameters.AddWithValue("email", agency.email);
                    cmd.Parameters.AddWithValue("password", agency.password);

                    cmd.ExecuteNonQuery();
                }
            }
        }
        public void DeleteAgency(Agency agency)
        {
            using (var conn = new NpgsqlConnection(connectionString))
            {
                conn.Open();

                using (var cmd = new NpgsqlCommand("DELETE FROM tb_agency WHERE id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("id", agency.id);

                    cmd.ExecuteNonQuery();
                }
            }
        }
        public void DeleteAllAgency()
        {
            using (var conn = new NpgsqlConnection(connectionString))
            {
                conn.Open();

                using (var cmd = new NpgsqlCommand("DELETE FROM tb_agency", conn))
                {
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
    public class Agency
    {
        public int id { get; set; }
        public string name { get; set; }
        public string email { get; set; }
        public string password { get; set; }
    }
}