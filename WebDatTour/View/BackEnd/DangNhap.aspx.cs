using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;
using WebDatTour.Model;

namespace WebDatTour.View.BackEnd
{
    public partial class DangNhap : System.Web.UI.Page
    {
        XuLy xuLy = new XuLy();
        NhanVienController nhanVienController = new NhanVienController();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string tk = txtTaiKhoan.Text;
            string mk = txtMatKhau.Text;
            if(nhanVienController.dangNhap(tk, mk))
            {
                Response.Redirect("admin.aspx");
            }
            else
            {
                lblNoti.Text = "Thông Tin Đăng Nhập Không Chính Xác.";
               // Response.Redirect("dangnhap.aspx");
            }
        }
    }
}