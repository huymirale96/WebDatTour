using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebDatTour.View.FontEnd
{
    public partial class ToanThanhThanhToan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["id"] != null)
            {
                if(Request.QueryString["id"].ToString().Equals("1"))
                {
                    txtnoti.InnerHtml = "<label class='label label-success'>Giao Dịch Thành Công.</label>";
                }
                else
                {
                    txtnoti.InnerHtml = "<label class='label label-danger'>Giao Dịch Thất Bại.</label>";
                }
            }
        }
    }
}