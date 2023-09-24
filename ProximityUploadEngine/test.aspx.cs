using System;
using System.Collections.Generic;
using System.Web.Services;
using Newtonsoft.Json;
using ProximityUploadEngine.Database;

namespace ProximityUploadEngine
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Agency Handler - 1
        protected void btnSubmit1_clicked(object sender, EventArgs e)
        {
            AgencyDb agencyDb = new AgencyDb();
            if (!agencyDb.IsEmailExist(tb_email1.Text))
            {
                Agency agency = new Agency();
                agency.name = tb_name1.Text;
                agency.credential.email = tb_email1.Text;
                agency.credential.password = tb_password1.Text;
                agency.credential.contactNumber = tb_contactNumber1.Text;
                agency.credential.profilePicture = "path1/hehe/huhu";
                agency.description = tb_description1.Text;

                agencyDb.CreateAgency(agency);
                tb_email1.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                tb_email1.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnRetrieve1_clicked(object sender, EventArgs e)
        {

            AgencyDb agencyDb = new AgencyDb();
            if (agencyDb.IsEmailExist(tb_email1.Text))
            {
                tb_email1.ForeColor = System.Drawing.Color.Black;

                Agency agency = agencyDb.GetAgency(tb_email1.Text);
                tb_name1.Text = agency.name;
                tb_password1.Text = agency.credential.password;
                tb_contactNumber1.Text = agency.credential.contactNumber;
                tb_description1.Text = agency.description;

                var clients = agencyDb.GetAllClient(tb_email1.Text);
                lb_clients1.Items.Clear();
                foreach (var client in clients)
                {
                    lb_clients1.Items.Add(client.name);
                }

                var hotels = agencyDb.GetAllHotel(tb_email1.Text);
                lb_hotels1.Items.Clear();
                foreach (var hotel in hotels)
                {
                    lb_hotels1.Items.Add(hotel.name);
                }
            }
            else
            {
                tb_email1.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnUpdate1_clicked(object sender, EventArgs e)
        {

            AgencyDb agencyDb = new AgencyDb();
            if (agencyDb.IsEmailExist(tb_email1.Text))
            {
                tb_email1.ForeColor = System.Drawing.Color.Black;

                Agency agency = new Agency();
                agency.name = tb_name1.Text;
                agency.credential.email = tb_email1.Text;
                agency.credential.password = tb_password1.Text;
                agency.credential.contactNumber = tb_contactNumber1.Text;
                agency.credential.profilePicture = "path1/hehe/huhu";
                agency.description = tb_description1.Text;

                agencyDb.UpdateAgency(agency);
            }
            else
            {
                tb_email1.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnDeleteAll1_clicked(object sender, EventArgs e)
        {
            AgencyDb agencyDb = new AgencyDb();
            agencyDb.DeleteAllAgency();

            ClearTbs1();
        }
        protected void btnDelete1_clicked(object sender, EventArgs e)
        {
            AgencyDb agencyDb = new AgencyDb();
            if (agencyDb.IsEmailExist(tb_email1.Text))
            {
                agencyDb.DeleteAgency(tb_email1.Text);
                ClearTbs1();
            }
            else
            {
                tb_email1.ForeColor = System.Drawing.Color.Red;
            }

        }

        // Client Handler - 2
        protected void btnSubmit2_clicked(object sender, EventArgs e)
        {

            ClientDb clientDb = new ClientDb();
            if (!clientDb.IsEmailExist(tb_email2.Text))
            {
                Client client = new Client();
                client.name = tb_name2.Text;
                client.credential.email = tb_email2.Text;
                client.credential.password = tb_password2.Text;
                client.credential.contactNumber = tb_contactNumber2.Text;
                client.credential.profilePicture = "path2/hehe/huhu";
                client.description = tb_description2.Text;
                client.location = tb_location2.Text;

                clientDb.CreateDirectClient(client);
                tb_email2.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                tb_email2.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnRetrieve2_clicked(object sender, EventArgs e)
        {
            ClientDb clientDb = new ClientDb();
            if (clientDb.IsEmailExist(tb_email2.Text))
            {
                tb_email2.ForeColor = System.Drawing.Color.Black;

                Client client = clientDb.GetDirectClient(tb_email2.Text);
                tb_name2.Text = client.name;
                tb_password2.Text = client.credential.password;
                tb_contactNumber2.Text = client.credential.contactNumber;
                tb_description2.Text = client.description;
                tb_location2.Text = client.location;
            }
            else
            {
                tb_email2.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnUpdate2_clicked(object sender, EventArgs e)
        {
            ClientDb clientDb = new ClientDb();
            if (clientDb.IsEmailExist(tb_email2.Text))
            {
                tb_email2.ForeColor = System.Drawing.Color.Black;

                Client client = new Client();
                client.name = tb_name2.Text;
                client.credential.email = tb_email2.Text;
                client.credential.password = tb_password2.Text;
                client.credential.contactNumber = tb_contactNumber2.Text;
                client.credential.profilePicture = "path1/hehe/huhu";
                client.description = tb_description2.Text;
                client.location = tb_location2.Text;

                clientDb.UpdateDirectClient(client);
            }
            else
            {
                tb_email2.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnDeleteAll2_clicked(object sender, EventArgs e)
        {
            ClientDb clientDb = new ClientDb();
            clientDb.DeleteAllDirectClient();

            ClearTbs2();
        }
        protected void btnDelete2_clicked(object sender, EventArgs e)
        {
            ClientDb clientDb = new ClientDb();
            if (clientDb.IsEmailExist(tb_email2.Text))
            {
                clientDb.DeleteDirectClient(tb_email2.Text);
                ClearTbs2();
            }
            else
            {
                tb_email2.ForeColor = System.Drawing.Color.Red;
            }
        }

        // Agency's Client Handler - 3
        protected void btnSubmit3_clicked(object sender, EventArgs e)
        {
            var agencyDb = new AgencyDb();
            if (agencyDb.IsEmailExist(tb_email3.Text))
            {
                var client = new Client();
                client.agencyId = agencyDb.GetAgency(tb_email3.Text).id;
                client.name = tb_name3.Text;
                client.description = tb_description3.Text;
                client.location = tb_location3.Text;

                agencyDb.CreateClient(client);

                tb_email3.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                tb_email3.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnRetrieve3_clicked(object sender, EventArgs e)
        {
            if (hf_clientId3.Value != "")
            {
                int clientId = Convert.ToInt32(hf_clientId3.Value);
                var agencyDb = new AgencyDb();

                var client = agencyDb.GetClient(clientId);

                tb_name3.Text = client.name;
                tb_description3.Text = client.description;
                tb_location3.Text = client.location;
            }
        }
        protected void btnUpdate3_clicked(object sender, EventArgs e)
        {
            var agencyDb = new AgencyDb();
            if (agencyDb.HasClient(tb_email3.Text))
            {
                if (hf_clientId3.Value != "")
                {
                    int clientId = Convert.ToInt32(hf_clientId3.Value);

                    var client = new Client();
                    client.id = clientId;
                    client.name = tb_name3.Text;
                    client.description = tb_description3.Text;
                    client.location = tb_location3.Text;

                    agencyDb.UpdateClient(client);
                }

                tb_email3.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                tb_email3.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnDeleteAll3_clicked(object sender, EventArgs e)
        {
            var agencyDb = new AgencyDb();
            agencyDb.DeleteAllClient();

            ClearTbs3();
        }
        protected void btnDelete3_clicked(object sender, EventArgs e)
        {
            if (hf_clientId3.Value != "")
            {
                int clientId = Convert.ToInt32(hf_clientId3.Value);

                var agencyDb = new AgencyDb();
                agencyDb.DeleteClient(clientId);

                ClearTbs3();
            }
        }

        // Hotel's handler - 4
        protected void btnSubmit4_clicked(object sender, EventArgs e)
        {
            HotelDb hotelDb = new HotelDb();
            if (!hotelDb.IsEmailExist(tb_email4.Text))
            {
                Hotel hotel = new Hotel();
                hotel.name = tb_name4.Text;
                hotel.email = tb_email4.Text;
                hotel.password = tb_password4.Text;
                hotel.contactNumber = tb_contactNumber4.Text;
                hotel.profilePicture = "path3/hehe/huhu";
                hotel.description = tb_description4.Text;
                hotel.location = tb_location4.Text;
                if (hf_agencyEmail4.Value != "") hotel.agencyId = Convert.ToInt32(hf_agencyEmail4.Value);

                hotelDb.CreateHotel(hotel);

                tb_email4.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                tb_email4.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnRetrieve4_clicked(object sender, EventArgs e)
        {
            HotelDb hotelDb = new HotelDb();
            if (hotelDb.IsEmailExist(tb_email4.Text))
            {
                tb_email4.ForeColor = System.Drawing.Color.Black;

                Hotel hotel = hotelDb.GetHotel(tb_email4.Text);
                tb_name4.Text = hotel.name;
                tb_password4.Text = hotel.password;
                tb_contactNumber4.Text = hotel.contactNumber;
                tb_description4.Text = hotel.description;
                tb_location4.Text = hotel.location;
            }
            else
            {
                tb_email4.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnUpdate4_clicked(object sender, EventArgs e)
        {
            HotelDb hotelDb = new HotelDb();
            if (hotelDb.IsEmailExist(tb_email4.Text))
            {
                tb_email4.ForeColor = System.Drawing.Color.Black;

                Hotel hotel = new Hotel();
                hotel.name = tb_name4.Text;
                hotel.email = tb_email4.Text;
                hotel.password = tb_password4.Text;
                hotel.contactNumber = tb_contactNumber4.Text;
                hotel.profilePicture = "path1/hehe/huhu";
                hotel.description = tb_description4.Text;
                hotel.location = tb_location4.Text;

                hotelDb.UpdateHotel(hotel);
            }
            else
            {
                tb_email4.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnDeleteAll4_clicked(object sender, EventArgs e)
        {
            HotelDb hotelDb = new HotelDb();
            hotelDb.DeleteAllHotel();

            ClearTbs4();
        }
        protected void btnDelete4_clicked(object sender, EventArgs e)
        {

            HotelDb hotelDb = new HotelDb();
            if (hotelDb.IsEmailExist(tb_email4.Text))
            {
                hotelDb.DeleteHotel(tb_email4.Text);
                ClearTbs4();
            }
            else
            {
                tb_email4.ForeColor = System.Drawing.Color.Red;
            }

        }

        // Content's handler - 5
        protected void btnSubmit5_clicked(object sender, EventArgs e)
        {
            ContentDb contentDb = new ContentDb();

            Content content = new Content();
            content.title = tb_title5.Text;
            content.path = tb_path5.Text;
            content.description = tb_description5.Text;

            contentDb.CreateContent(content);
        }
        protected void btnRetrieve5_clicked(object sender, EventArgs e)
        {
        }
        protected void btnUpdate5_clicked(object sender, EventArgs e)
        {
        }
        protected void btnDeleteAll5_clicked(object sender, EventArgs e)
        {
        }
        protected void btnDelete5_clicked(object sender, EventArgs e)
        {
        }

        private void ClearTbs1()
        {
            tb_email1.ForeColor = System.Drawing.Color.Black;

            tb_name1.Text = "";
            tb_email1.Text = "";
            tb_password1.Text = "";
            tb_contactNumber1.Text = "";
            tb_description1.Text = "";
        }
        private void ClearTbs2()
        {
            tb_email2.ForeColor = System.Drawing.Color.Black;

            tb_name2.Text = "";
            tb_email2.Text = "";
            tb_password2.Text = "";
            tb_contactNumber2.Text = "";
            tb_description2.Text = "";
            tb_location2.Text = "";
        }
        private void ClearTbs3()
        {
            tb_email3.ForeColor = System.Drawing.Color.Black;

            tb_name3.Text = "";
            tb_email3.Text = "";
            tb_description3.Text = "";
            tb_location3.Text = "";
        }
        private void ClearTbs4()
        {
            tb_email4.ForeColor = System.Drawing.Color.Black;

            tb_email4.Text = "";
            tb_name4.Text = "";
            tb_password4.Text = "";
            tb_contactNumber4.Text = "";
            tb_description4.Text = "";
            tb_location4.Text = "";
        }
        private void ClearTbs5()
        {
            tb_title5.Text = "";
            tb_path5.Text = "";
            tb_description5.Text = "";
        }

        [WebMethod]
        public static string getAllAgency()
        {
            var agencyDb = new AgencyDb();
            List<Agency> agencies = agencyDb.GetAllAgency();
            return JsonConvert.SerializeObject(agencies);
        }
        [WebMethod]
        public static string getAllAgencyWithClient()
        {
            var agencyDb = new AgencyDb();
            List<Agency> agencies = agencyDb.GetAllAgencyWithClient();
            return JsonConvert.SerializeObject(agencies);
        }
        [WebMethod]
        public static string getAgencyAllClient(string email)
        {
            var agencyDb = new AgencyDb();
            List<Client> clients = agencyDb.GetAllClient(email);
            return JsonConvert.SerializeObject(clients);
        }
        [WebMethod]
        public static string getAllDirectClient()
        {
            var clientDb = new ClientDb();
            List<Client> clients = clientDb.GetAllDirectClient();
            return JsonConvert.SerializeObject(clients);
        }
        [WebMethod]
        public static string getAllHotel()
        {
            var hotelDb = new HotelDb();
            List<Hotel> hotels = hotelDb.GetAllHotel();
            return JsonConvert.SerializeObject(hotels);
        }
    }
}