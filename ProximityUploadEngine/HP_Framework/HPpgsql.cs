using Npgsql;
using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace ProximityUploadEngine.HP_Framework
{
    public class HPpgsql : IDisposable
    {
        public Dictionary<string, Object> values;
        private readonly NpgsqlConnection conn;

        public HPpgsql(string connectionString)
        {
            values = new Dictionary<string, object>();
            this.conn = new NpgsqlConnection(connectionString);
            conn.Open();
        }

        //----------------------------------------- Low Level Command Implementation -----------------------------------------//
        public void ExecuteNonQueryCommand(string query)
        {
            using (var cmd = new NpgsqlCommand(query, conn))
            {
                foreach (var value in values)
                {
                    cmd.Parameters.AddWithValue(value.Key, value.Value);
                }

                cmd.ExecuteNonQuery();
            }
        }
        public NpgsqlDataReader ReadCommand(string query)
        {
            using (var cmd = new NpgsqlCommand(query, conn))
            {
                foreach (var value in values)
                {
                    cmd.Parameters.AddWithValue(value.Key, value.Value);
                }

                var reader = cmd.ExecuteReader();
                return reader;
            }
        }
        public object ExecuteScalarCommand(string query)
        {
            using (var cmd = new NpgsqlCommand(query, conn))
            {
                foreach (var value in values)
                {
                    cmd.Parameters.AddWithValue(value.Key, value.Value);
                }

                return cmd.ExecuteScalar();
            }
        }
        public void ClearValues()
        {
            values.Clear();
        }
        public void OpenConnection()
        {
            conn.Open();
        }
        public void CloseConnection()
        {
            conn.Close();
        }
        public void Dispose()
        {
            conn.Close();
            conn.Dispose();
        }

        //----------------------------------------- High Level Command Implementation -----------------------------------------//
        public void ResetSerial(string table, string col)
        {
            ExecuteNonQueryCommand(
                $"SELECT setval(" +
                $"   pg_get_serial_sequence('{table}', '{col}'), " +
                $"   coalesce(max({col}), 1), " +
                $"   false " +
                $")" +
                $"FROM {table};");
        }
        public int GetLastSerial(string table, string col)
        {
            return Convert.ToInt32(ExecuteScalarCommand($"SELECT currval(pg_get_serial_sequence('{table}', '{col}'));"));
        }
        public bool IsColExist(string table)
        {
            if (values.Count == 0)
            {
                return false;
            }

            string query = "SELECT ";
            query += string.Join(",", values.Keys) + $" FROM {table} WHERE ";
            foreach (var value in values)
            {
                query += $"@{value.Key} = {value.Key} AND ";
            }
            query = query.Substring(0, query.Length - 5) + ";";

            return ReadCommand(query).HasRows;
        }
        public void InsertRow(string table)
        {
            if (values.Count != 0)
            {
                string query = $"INSERT INTO {table} (";
                query += string.Join(",", values.Keys) + ") VALUES (";
                foreach (var value in values)
                {
                    query += $"@{value.Key}, ";
                }
                query = query.Substring(0, query.Length - 2) + ");";
                ExecuteNonQueryCommand(query);
            }
        }
        public int CountRow(string table)
        {
            string query = $"SELECT COUNT(*) FROM {table}";
            if (values.Count != 0)
            {
                query += $" WHERE ";
                foreach (var value in values)
                {
                    query += $"{value.Key} = @{value.Key} AND ";
                }
                query = query.Substring(0, query.Length - 5);
            }
            query += ";";
            return Convert.ToInt32(ExecuteScalarCommand(query));
        }
        public void UpdateRow(string table, string where)
        {
            if (values.Count != 0 || values[where] != null)
            {
                string query = $"UPDATE {table} SET ";
                foreach (var value in values)
                {
                    if (value.Key == where) continue;

                    query += $"{value.Key} = @{value.Key}, ";
                }
                query = query.Substring(0, query.Length - 2) + " WHERE ";
                query += $"{where} = @{where};";

                ExecuteNonQueryCommand(query);
            }
        }
        public void DeleteRow(string table, string where = null)
        {
            string query = $"DELETE FROM {table}";
            if (where != null)
            {
                query += $" WHERE {where} = @{where}";
            }
            query += ";";
            ExecuteNonQueryCommand(query);
        }

        //---------------------------------------------------- Conversion ------------------------------------------------------//
        public int ToInt32(Object obj)
        {
            return Convert.ToInt32(obj);
        }
        public int? ToNullInt32(Object obj)
        {
            try
            {
                if (obj != null) return Convert.ToInt32(obj);
                else return null;
            }
            catch (FormatException)
            {
                return null;
            }
            catch (InvalidCastException)
            {
                return null;
            }
        }
        public string ToString(Object obj)
        {
            try
            {
                if (obj != null) return Convert.ToString(obj);
                else return null;
            }
            catch (FormatException)
            {
                return null;
            }
            catch (InvalidCastException)
            {
                return null;
            }
        }
    }
}