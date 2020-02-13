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
                nhanVien.Quyen = 2;
            }
            else
            {
                nhanVien.Quyen = 1;
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
            if(nhanVienController.ThemNhanVien(nhanVien))
            {
                Response.Write("<script language=javascript>alert('OKK');</script>");
            }
            else
            {
                Response.Write("<script language=javascript>alert('ERROR');</script>");
            }
            
        }
    }
}