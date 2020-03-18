using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;

namespace WebDatTour.View.BackEnd
{
    public partial class ThongKeTaiKhoan : System.Web.UI.Page
    {
        NhanVienController nhanVienController = new NhanVienController();
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable data = nhanVienController.thongKeTaiKhoan();
            tkad.InnerHtml = data.Rows[0]["soadmin"].ToString();
            tknv.InnerHtml = data.Rows[0]["sonv"].ToString();
            tkqt.InnerHtml = data.Rows[0]["sotaikhoannv"].ToString();
            tkkh.InnerHtml = data.Rows[0]["sokh"].ToString();
        }
    }
}