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
            if (Session["maKH"].ToString().Equals(""))
            {
                Response.Redirect("index.aspx");
            }
            if (!HttpContext.Current.Session["tenKH"].ToString().Equals(""))
            {
                if (!IsPostBack)
                {
                    tenDangNhap.Text = HttpContext.Current.Session["tenKH"].ToString();
                    //txtMatKhauCu_.Text = "";
                   // lblNoti.Text = Session["mess"].ToString();
                  //  lblNoti.CssClass = Session["type"].ToString();
                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string matKhauCu = txtMatKhauCu_.Text;
            string matKhauMoi = txtMatKhauMoi.Text;
            int id = Convert.ToInt32(HttpContext.Current.Session["maKH"].ToString());
            Debug.WriteLine("id de doi mat khau "+id+ "mkmc  " +matKhauCu);
            KhachHang khachHang = new KhachHang();
            khachHang.MaKH = id;
            khachHang.MatKhau = txtMatKhauCu_.Text;
            if(khachHangController.kiemTraDangNhap(khachHang))
            {
                KhachHang khachHang_ = new KhachHang();
                khachHang_.MaKH = id;
                khachHang_.MatKhau = txtMatKhauMoi.Text;
                khachHangController.doiMatKhau(khachHang_);
              Debug.WriteLine("doi mat khau" + txtMatKhauMoi.Text + khachHang_.MatKhau);
                Session["mess"] = "Đổi mật khẩu thành công.";
                Session["type"] = "text-success";
               // Response.Redirect("doimatkhau.aspx");
            }
            else
            {
                Debug.WriteLine("doi mat khau k dung");
               // Session["mess"] = "Mật Khẩu Cũ Không Đúng.";
                //Session["type"] = "text-danger";

            }
        }

        protected void btnDoiMK_Click(object sender, EventArgs e)
        {
            string matKhauCu = txtMatKhauCu_.Text;
            string matKhauMoi = txtMatKhauMoi.Text;
            int id = Convert.ToInt32(HttpContext.Current.Session["maKH"].ToString());
            Debug.WriteLine("id de doi mat khau " + id + "mkmc  " + matKhauCu);
            KhachHang khachHang = new KhachHang();
            khachHang.MaKH = id;
            khachHang.MatKhau = matKhauCu;
            if (khachHangController.kiemTraDangNhap(khachHang))
            {
                KhachHang khachHang_ = new KhachHang();
                khachHang_.MaKH = id;
                khachHang_.MatKhau = matKhauMoi;
                if (khachHangController.doiMatKhau(khachHang_))
                {
                    Debug.WriteLine("doi mat khau " +khachHang_.MatKhau);
                    Session["mess"] = "Đổi mật khẩu thành công.";
                    Session["type"] = "text-success";
                    // Response.Redirect("doimatkhau.aspx");
                    lblNoti.CssClass = "text-success";
                    lblNoti.Text = "Đổi mật khẩu thành công.";
                }
                else
                {
                    //Session["mess"] = "Đổi mật khẩu Thất bại.";
                   // Session["type"] = "text-warning";
                    lblNoti.Text = "Thất Bại";
                }
            }
            else
            {
                
                lblNoti.CssClass = "text-warning";
                lblNoti.Text = "Mật Khẩu Cũ Không Đúng.";

            }
        }
    }
}