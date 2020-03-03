using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebDatTour.View.FontEnd
{
    public partial class loi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Request.QueryString["id"] != null)
            {
                string x = Request.QueryString["id"].ToString();
                switch (x)
                {
                    
                case "0": txtLoi.InnerHtml = "Số Chỗ Còn lại Không Đủ"; break;
                case "1": txtLoi.InnerHtml = "Lỗi"; break;
                case "2": txtLoi.InnerHtml = ""; break;
                case "3": txtLoi.InnerHtml = ""; break;
                default: txtLoi.InnerHtml = "";  break;
                }


            }
        }
    }
}