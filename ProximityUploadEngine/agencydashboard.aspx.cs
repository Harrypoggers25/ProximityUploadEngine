﻿using System;

namespace ProximityUploadEngine
{
    public partial class agencydashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var master = (SiteMaster)this.Master;
            var agency = master.getAgencyFromSession();

            lbl_username.Text = agency.name;
        }
    }
}