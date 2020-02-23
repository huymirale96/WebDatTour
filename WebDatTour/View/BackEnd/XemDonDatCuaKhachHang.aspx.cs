using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;

namespace WebDatTour.View.BackEnd
{
    
    public partial class XemDonDatCuaKhachHang : System.Web.UI.Page
    {
        DonDatTourController datTourController = new DonDatTourController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                layDonDatTour(Request.QueryString["id"].ToString());
            }
            else
            {
            
            }
        }
        public void layDonDatTour(string id)
        {
            rptdondattour.DataSource = datTourController.donHanh_khachHang(id);
            rptdondattour.DataBind();
        }
        public String toCurruncy_(int x)
        {
            return x.ToString("#,##0");
        }
        public string trangThai(string id)
        {
            switch (id)
            {
                case "0": return "<label class='label label-warning'>Chờ Xác Nhận</label>";
                case "1": return "<label class='label label-success'>Đã Xác Nhận</label>";
                case "2": return "<label class='label label-danger'> Đã Hủy</label>";
                case "3": return "<label class='label label-danger'> Đã Bị Hủy</label>";
                default: return "";

            }
        }
    }
}