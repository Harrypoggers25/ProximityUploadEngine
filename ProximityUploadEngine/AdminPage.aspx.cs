using System;
using System.Configuration;
using Npgsql;
using System.Data;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Web.Services;
using System.Runtime.InteropServices;

namespace ProximityUploadEngine
{
    public partial class AdminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        [Serializable]
        public class TableData
        {
            public int ID { get; set; }
            public string Name { get; set; }
            public string Email { get; set; }
        }

        [WebMethod]
        public static List<TableData> GetTableData()
        {
            // Simulate fetching data from a data source
            var data = new List<TableData>
        {
            new TableData { ID = 1, Name = "John Doe", Email = "john@example.com" },
            new TableData { ID = 2, Name = "Jane Smith", Email = "jane@example.com" },
            // Add more data here...
        };

            return data;
        }
    }
    public class ApplicationDbContext : DbContext
    {
        public DbSet<Agency> Agencies { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseNpgsql("YourConnectionStringHere");
        }
    }
    public class AgencyRepository
    {
        public List<Agency> GetAgencies()
        {
            using (var context = new ApplicationDbContext())
            {
                return context.Agencies.ToList();
            }
        }
    }
    [RoutePrefix("api/agencies")]
    public class AgenciesController : ApiController
    {
        private readonly AgencyRepository _agencyRepository;

        public AgenciesController()
        {
            _agencyRepository = new AgencyRepository();
        }

        [HttpGet]
        [Route("")]
        public IHttpActionResult Get()
        {
            var agencies = _agencyRepository.GetAgencies();
            return Ok(agencies);
        }
    }
}