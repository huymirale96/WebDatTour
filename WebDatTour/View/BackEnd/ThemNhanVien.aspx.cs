using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebDatTour.Object;
using WebDatTour.Controllers;

namespace WebDatTour.View.BackEnd
{
    public partial class ThemNhanVien : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!HttpContext.Current.Session["quyen"].ToString().Equals("2"))
            {
                Response.Redirect("admin.aspx");
            }
        }

        protected void btnDangKi_Click(object sender, EventArgs e)
        {
            NhanVien nhanVien = new NhanVien();
            nhanVien.TenNhanVien = txtName.Text;
            nhanVien.StenDangNhap = txtTenDangNhap.Text;
            nhanVien.MatKhau = txtMK.Text;
            nhanVien.QueQuan = queQuan.Text;
            nhanVien.NgaySinh = DateTime.Parse(txtNgaySinh.Text);
            nhanVien.SoDienThoai = txtSDT.Text;
            if(rdoMember.Checked == true)
            {
                nhanVien.Quyen = 1;
            }
            else
            {
                nhanVien.Quyen = 2;
            }
            if (rdoNam.Checked == true)
            {
                nhanVien.GioiTinh = true;
            }
            else
            {
                nhanVien.GioiTinh = false;                
            }
            NhanVienController nhanVienController = new NhanVienController();
            if (nhanVienController.kiemTraTen(txtTenDangNhap.Text))
            {
                if (nhanVienController.ThemNhanVien(nhanVien))
                {
                    noti.Text = "Thêm Nhân Viên Thành Công";
                    // Response.Write("<script language=javascript>alert('OKK');</script>");
                }
                else
                {
                    noti.Text = "Thêm Nhân Viên Thất Bại";
                    //  Response.Write("<script language=javascript>alert('ERROR');</script>");
                }
            }
            else
            {
                noti.Text = "Tên Đăng Nhập Đã Được Sử Dụng.";
            }
            
        }
    }
}