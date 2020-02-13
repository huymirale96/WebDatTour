using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using WebDatTour.Controllers;
using WebDatTour.Object;

namespace WebDatTour.View.FontEnd
{
    public partial class DoiMatKhau : System.Web.UI.Page
    {
        KhachHangController khachHangController = new KhachHangController();
        protected void Page_Load(object sender, EventArgs e)
        {
            tenDangNhap.Text = HttpContext.Current.Session["tenKH"].ToString();
            //txtMatKhauCu_.Text = "";
            lblNoti.Text = Session["mess"].ToString();
            lblNoti.CssClass = Session["type"].ToString();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string matKhauCu = txtMatKhauCu_.Text;
            string matKhauMoi = txtMatKhauMoi.Text;
            int id = Convert.ToInt32(HttpContext.Current.Session["maKH"].ToString());
            //Debug.WriteLine("id de doi mat khau "+id+ "mkmc  " +matKhauCu);
            KhachHang khachHang = new KhachHang();
            khachHang.MaKH = id;
            khachHang.MatKhau = matKhauCu;
            if(khachHangController.kiemTraDangNhap(khachHang))
            {
                KhachHang khachHang_ = new KhachHang();
                khachHang_.MaKH = id;
                khachHang_.MatKhau = matKhauMoi;
                khachHangController.doiMatKhau(khachHang);
            //    Debug.WriteLine("doi mat khau");
                Session["mess"] = "Đổi mật khẩu thành công.";
                Session["type"] = "text-success";
                Response.Redirect("doimatkhau.aspx");
            }
            else
            {
               // Debug.WriteLine("doi mat khau k dung");
                Session["mess"] = "Mật Khẩu Cũ Không Đúng.";
                Session["type"] = "text-danger";

            }
        }
    }
}