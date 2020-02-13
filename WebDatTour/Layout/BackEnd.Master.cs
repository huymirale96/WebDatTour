using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebDatTour.Layout
{
    public partial class BackEnd : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["chucnang"] != null)
            {
                if(Request.QueryString["chucnang"].ToString().Equals("dangxuat"))
                {
                    Session["tenNV"] = "";
                    Session["quyen"] = "";
                    Session["maNV"] = "";
                    Response.Redirect("dangnhap.aspx");

                }
            }

        }
    }
}