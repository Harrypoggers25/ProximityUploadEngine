using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProximityUploadEngine
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rfv_title1.ControlToValidate = "tb_title1";
                rfv_title1.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}