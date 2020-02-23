using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Controllers;
using WebDatTour.Object;
using System.Diagnostics;
using Newtonsoft.Json;

namespace WebDatTour.View.BackEnd
{
    public partial class DoiMatKhau : System.Web.UI.Page
    {
        NhanVienController nhanVienController = new NhanVienController();
        protected void Page_Load(object sender, EventArgs e)
        {
            tenDangNhap.Text = HttpContext.Current.Session["tenNV"].ToString();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string matKhauCu = txtMatKhauCu_.Text;
            string matKhauMoi = txtMatKhauMoi.Text;
            int id = Convert.ToInt32(HttpContext.Current.Session["maNV"].ToString());
            
            NhanVien nhanVien = new NhanVien();
            nhanVien.MaNV = id;
            nhanVien.MatKhau = matKhauCu;
            //Debug.WriteLine("id de doi mat khau " + id + "mkmc  " + matKhauCu+JsonConvert.SerializeObject(nhanVien));
            if (nhanVienController.kiemTraDangNhap(nhanVien))
            {
                NhanVien nhanVien_ = new NhanVien();
                nhanVien_.MaNV = id;
                nhanVien_.MatKhau = matKhauMoi;
                nhanVienController.doiMatKhau(nhanVien_);
                Debug.WriteLine("doi mat khau");
                lblNoti.Text = "Đổi mật khẩu thành công.";
                Session["mess"] = "Đổi mật khẩu thành công.";
                Session["type"] = "text-success";
               // Response.Redirect("doimatkhau.aspx");
            }
            else
            {
                Debug.WriteLine("doi mat khau k dung");
                lblNoti.Text = "Mật Khẩu Cũ Không Đúng.";
                Session["mess"] = "Mật Khẩu Cũ Không Đúng.";
                Session["type"] = "text-danger";

            }
        }
    }
}